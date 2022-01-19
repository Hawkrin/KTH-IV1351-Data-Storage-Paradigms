package se.kth.iv1351.bankjdbc.model;

import java.util.List;

/**
 * Represent an instrument
 */
public class Instrument {
    private String intrument_type;
    private int quantity;
    private String brand;
    private List<String> rented_by; // Id for student.

    /**
     * Creates an instance of an instrument
     * 
     * @param intrument_type The instrument type.
     * @param quantity       The quantity of the instrument.
     * @param brand          The brand of the instrument.
     */
    public Instrument(String intrument_type, int quantity, String brand) {
        this.intrument_type = intrument_type;
        this.quantity = quantity;
        this.brand = brand;
    }

    /**
     * Creates an instance of an instrument
     * 
     * @param intrument_type The instrument type.
     * @param quantity       The quantity of the instrument.
     * @param brand          The brand of the instrument.
     * @param rented_by      The student renting
     */
    public Instrument(String intrument_type, int quantity, String brand, List<String> rented_by) {
        this.intrument_type = intrument_type;
        this.quantity = quantity;
        this.brand = brand;
        this.rented_by = rented_by;
    }

    /**
     * get the person renting
     * 
     * @return the person renting
     */
    public List<String> getRentedBy() { return rented_by; }

    /**
     * get the instrument type
     * 
     * @return The instrument type
     */
    public String getInstrumentType() { return intrument_type; }

    /**
     * get the instrument quantity
     * 
     * @return The instrument quantity
     */
    public int getQuantity() { return quantity; }

    /**
     * get the instrument brand
     * 
     * @return The instrument brand
     */
    public String getBrand() { return brand; }

    @Override
    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Instrument: [");
        stringRepresentation.append("type: ");
        stringRepresentation.append(intrument_type);
        stringRepresentation.append(", brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", quantity: ");
        stringRepresentation.append(quantity);
        stringRepresentation.append(", rented by: ");
        stringRepresentation.append(rented_by);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
