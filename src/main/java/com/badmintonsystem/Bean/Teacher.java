package com.badmintonsystem.Bean;

public class Teacher {
    private String teaid;

    private String teaname;

    public String getTeaid() {
        return teaid;
    }

    public void setTeaid(String teaid) {
        this.teaid = teaid == null ? null : teaid.trim();
    }

    public String getTeaname() {
        return teaname;
    }

    public void setTeaname(String teaname) {
        this.teaname = teaname == null ? null : teaname.trim();
    }

    public Teacher() {
    }

    public Teacher(String teaid, String teaname) {
        this.teaid = teaid;
        this.teaname = teaname;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "teaid='" + teaid + '\'' +
                ", teaname='" + teaname + '\'' +
                '}';
    }
}