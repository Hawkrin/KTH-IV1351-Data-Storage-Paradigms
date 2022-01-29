package se.kth.iv1351.bankjdbc.model;

import java.util.List;

public interface InstrumentDTO {
    public List<String> getRentedBy();

    public String getInstrumentType();

    public int getQuantity();

    public String getBrand();
}
