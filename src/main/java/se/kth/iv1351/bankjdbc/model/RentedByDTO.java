package se.kth.iv1351.bankjdbc.model;

/**
 * Specifies a read-only view of a rented by list.
 */
public interface RentedByDTO {

    /**
     * @return The person renting an instrument.
     */
    public String getFirstName();
}
