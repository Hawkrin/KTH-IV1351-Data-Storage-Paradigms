package se.kth.iv1351.bankjdbc.model;

public class RentedBy implements RentedByDTO {
    private String first_name;
    private String last_name;
    private String type;
    private String brand;
    private int quantity;

    public RentedBy(String first_name, String last_name, String type, String brand, int quantity) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.type = type;
        this.brand = brand;
        this.quantity = quantity;
    }

    public String getFirstName() {
        return this.first_name;
    }

    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Rented Information: ");
        stringRepresentation.append("First name: ");
        stringRepresentation.append(first_name);
        stringRepresentation.append(", Last name: ");
        stringRepresentation.append(last_name);
        stringRepresentation.append(", type: ");
        stringRepresentation.append(type);
        stringRepresentation.append(", brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", quantity: ");
        stringRepresentation.append(quantity);
        return stringRepresentation.toString();
    }
}
