package se.kth.iv1351.bankjdbc.model;

/**
 * Represents a student
 */
public class Student {
    private Person person;
    private String sibling_person_number;

    /**
     * Create a new instance of a student
     * 
     * @param person the person information
     * @param sibling_person_number the sibling personal number
     */
    public Student(Person person, String sibling_person_number) {
        this.person = person;
        this.sibling_person_number = sibling_person_number;
    }

    /**
     * get the persons information
     * 
     * @return the persons information
     */
    public Person getPerson() { return person; }
    
    /**
     * get the person number of a students sibling
     * 
     * @return the student siblings person number
     */
    public String getSibling_Person_Number() { return sibling_person_number; }

    @Override
    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Student: [");
        stringRepresentation.append("Information: ");
        stringRepresentation.append(person);
        stringRepresentation.append(", Sibling personal number: ");
        stringRepresentation.append(sibling_person_number);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
