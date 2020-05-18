package com.badmintonsystem.Bean;

public class Files {
    private String fname;
    private String faddress;

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getFaddress() {
        return faddress;
    }

    public void setFaddress(String faddress) {
        this.faddress = faddress;
    }

    public Files() {
    }

    public Files(String fname, String faddress) {
        this.fname = fname;
        this.faddress = faddress;
    }
}
