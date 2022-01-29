package se.kth.iv1351.bankjdbc.model;

import java.util.List;

/**
 * Specifies a read-only view of instrument list.
 */
public interface InstrumentDTO {

    /**
     * @return The person renting an instrument.
     */
    public List<String> getRentedBy();

    /**
     * @return The instrument type.
     */
    public String getInstrumentType();

    /**
     * @return The quantity rented.
     */
    public int getQuantity();

    /**
     * @return The instrument brand.
     */
    public String getBrand();
}
