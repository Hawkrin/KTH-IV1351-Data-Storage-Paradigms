/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package se.kth.iv1351.bankjdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import se.kth.iv1351.bankjdbc.model.Instrument;
import se.kth.iv1351.bankjdbc.model.RentedBy;
import se.kth.iv1351.bankjdbc.model.RentedByDTO;

/**
 * This data access object (DAO) encapsulates all database calls in the bank
 * application. No code outside this class shall have any knowledge about the
 * database.
 */
public class BankDAO {

    private static final String INSTRUMENT_TABLE_NAME = "instrument_stock";
    private static final String INSTRUMENT_RENTED_TABLE_NAME = "instrument_renting";

    private Connection connection;
    private Connection connectionToSchool;
    private PreparedStatement listAllInstruments;
    private PreparedStatement listAllRentedInstruments;
    private PreparedStatement listAllRented;
    private PreparedStatement terminate_ongoing_renting;

    /**
     * Constructs a new DAO object connected to the bank database.
     */
    public BankDAO() throws BankDBException {
        try {
            connectToBankDB();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new BankDBException("Could not connect to datasource.", exception);
        }
    }

    /**
     * Lists all instruments which are available for rental.
     * 
     * @return the instruments available for rental
     * @throws BankDBException if no data can be reached.
     */
    public List<Instrument> listAllInstrumentsAvailable() throws BankDBException {
        String failureMsg = "Could not find data";
        ResultSet result = null;
        List<Instrument> instruments = new ArrayList<>();
        try {
            result = listAllInstruments.executeQuery();
            while (result.next()) {

                if (result.getInt("instrument_quantity") == 0) // Checks if there is something to rent.
                    continue;

                instruments.add(new Instrument(result.getString("instrument_type"),
                        result.getInt("instrument_quantity"), result.getString("instrument_brand")));
            }
            connectionToSchool.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return instruments;
    }

    /**
     *  Deletes an ongoing rent from the instrument rental list. Finds the rental to remove
     * via the rental id.
     * 
     * @param id the id of the rental
     * @throws BankDBException if the rental can't be deleted.
     */
    public void deleteOnGoingRental(int id) throws BankDBException {
        String failiureMsg = "Could not delete ongoing rent.";
        try {
            terminate_ongoing_renting.setInt(1, id);
            int updatedRows = terminate_ongoing_renting.executeUpdate();

            if (updatedRows != 1) {
                handleException(failiureMsg, null);
            }

            connectionToSchool.commit();
        } catch (SQLException sqle) {
            handleException(failiureMsg, sqle);
        }
    }

    /**
     * takes in and displays the list of all rented instruments as a list.
     * 
     * @return the list of all rented instruments
     * @throws BankDBException if can't reach the database.
     */
    public List<RentedBy> listAllRentedInstruments() throws BankDBException {
        String failureMsg = "Could not find data";
        ResultSet result = null;
        List<RentedBy> rentedBy = new ArrayList<>();
        try {
            result = listAllRented.executeQuery();
            while (result.next()) {

                // Not rented anymore...
                if (result.getBoolean("terminated") == true) {
                    continue;
                }

                rentedBy.add(new RentedBy(
                        result.getString("first_name"),
                        result.getString("last_name"),
                        result.getString("instrument_type"),
                        result.getString("brand"),
                        result.getInt("quantity"),
                        result.getInt("instrument_renting_id")));
            }

            connectionToSchool.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }

        return rentedBy;
    }

    /**
     * Commits the current transaction.
     * 
     * @throws BankDBException If unable to commit the current transaction.
     */
    public void commit() throws BankDBException {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    private void connectToBankDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/bankdb",
                "postgres", "iggy7521");

        connectionToSchool = DriverManager.getConnection("jdbc:postgresql://localhost:5432/MusicHighSchool",
                "postgres", "iggy7521");

        // connection =
        // DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb",
        // "mysql", "mysql");
        connection.setAutoCommit(false);
        connectionToSchool.setAutoCommit(false);

        listAllInstruments = connectionToSchool.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME);
        listAllRentedInstruments = connectionToSchool.prepareStatement("SELECT * FROM " + INSTRUMENT_RENTED_TABLE_NAME);

        // SELECT s.instrument_type instrument_type, s.instrument_brand brand,
        // p.first_name, p.last_name, r.amount quantity FROM instrument_renting r INNER
        // JOIN instrument_stock s ON r.instrument_stock_id = s.instrument_stock_id
        // INNER JOIN student ON student.student_id = r.student_id INNER JOIN person p
        // ON p.person_id = student.person_id

        listAllRented = connectionToSchool.prepareStatement(
                "SELECT s.instrument_type instrument_type, r.instrument_renting_id , r.terminated, s.instrument_brand brand, p.first_name, r.student_id, p.person_id, p.last_name, r.amount quantity FROM instrument_renting r INNER JOIN instrument_stock s ON r.instrument_stock_id = s.instrument_stock_id INNER JOIN student ON student.student_id = r.student_id INNER JOIN person p ON p.person_id = student.person_id");

        terminate_ongoing_renting = connectionToSchool
                .prepareStatement("UPDATE instrument_renting SET terminated = true WHERE instrument_renting_id = ?");

    }

    private void handleException(String failureMsg, Exception cause) throws BankDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new BankDBException(failureMsg, cause);
        } else {
            throw new BankDBException(failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws BankDBException {
        try {
            result.close();
        } catch (Exception e) {
            throw new BankDBException(failureMsg + " Could not close result set.", e);
        }
    }

}

