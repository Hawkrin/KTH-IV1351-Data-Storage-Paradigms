package se.kth.iv1351.bankjdbc.model;

/**
 * Represents a person
 */
public class Person {
    private int person_id;
    private int age;
    private String first_name;
    private String last_name;
    private String person_number;

    /**
     * creates an instance of a person
     * 
     * @param person_id     the id number in the database
     * @param age           the age of the person
     * @param first_name    the first name of the person
     * @param last_name     the last name of the person
     * @param person_number the personal number of the person
     */
    public Person(int person_id, int age, String first_name, String last_name, String person_number) {
        this.person_id = person_id;
        this.age = age;
        this.first_name = first_name;
        this.last_name = last_name;
        this.person_number = person_number;
    }

    /**
     * get the person id
     * 
     * @return The person id.
     */
    public int getId() { return person_id; }
    
    /**
     * get the person age
     * 
     * @return The person age.
     */
    public int getAge() { return age; }

    /**
     * get the persons first name
     * 
     * @return The persons first name.
     */
    public String getFirstName() { return first_name; }

    /**
     * get the persons last name
     * 
     * @return The persons last name.
     */
    public String getLastName() { return last_name; }

    /**
     * get the persons person number
     * 
     * @return The persons person number.
     */
    public String getPersonNumber() { return person_number; }

    @Override
    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Person: [");
        stringRepresentation.append("First name: ");
        stringRepresentation.append(first_name);
        stringRepresentation.append(", Last name: ");
        stringRepresentation.append(last_name);
        stringRepresentation.append(", Age: ");
        stringRepresentation.append(age);
        stringRepresentation.append(", Person number: ");
        stringRepresentation.append(person_number);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
