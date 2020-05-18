package com.badmintonsystem.Bean;

public class Toption {
    private Integer id;

    private Integer time;

    private String tinterval;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    public String getInterval() {
        return tinterval;
    }

    public void setInterval(String interval) {
        this.tinterval = interval == null ? null : interval.trim();
    }

}