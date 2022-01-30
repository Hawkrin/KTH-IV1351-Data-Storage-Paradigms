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

package se.kth.iv1351.bankjdbc.controller;

import java.util.List;
import se.kth.iv1351.bankjdbc.integration.BankDAO;
import se.kth.iv1351.bankjdbc.integration.BankDBException;
import se.kth.iv1351.bankjdbc.model.Instrument;
import se.kth.iv1351.bankjdbc.model.RentedBy;

/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final BankDAO bankDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws BankDBException If unable to connect to the database.
     */
    public Controller() throws BankDBException {
        bankDb = new BankDAO();
    }

    /**
     * get all instrument tables
     * 
     * @return all instrument tables
     * @throws Exception if unable to retrieve list of instruments
     */
    public List<? extends Instrument> getAllInstruments() throws Exception {
        try {
            return bankDb.listAllInstrumentsAvailable();
        } catch (Exception e) {
            throw new Exception("Unable to list accounts.", e);
        }
    }

    /**
     * get all people that have rented instruments, as well as how which instrument
     * they have rented and of what quantity
     * 
     * @return tables of people and what instruments they have rented
     * @throws Exception if unable to retrieve list of people and their instruments
     */
    public List<? extends RentedBy> getAllRented() throws Exception {
        try {
            return bankDb.listAllRentedInstruments();
        } catch (Exception e) {
            throw new Exception("Unable to list rented instruments.", e);
        }
    }

    /**
     * Removes an ongoing rental from the rental table
     * 
     * @param id the rental id
     * @throws Exception if a rental can't be removed.
     */
    public void removeOngoingRental(int id) throws Exception {
        try {
            bankDb.deleteOnGoingRental(id);
        } catch (Exception e) {
            throw new Exception("Unable to remove ongoing rent.", e);
        }
    }

}
