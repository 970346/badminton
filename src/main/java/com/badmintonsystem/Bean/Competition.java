package com.badmintonsystem.Bean;

import java.util.Date;

public class Competition {
    private Integer id;
    private Date startime;
    private Date endtime;
    private String cpnname;
    private String cpngrade;
    private String cpnaddress;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getStartime() {
        return startime;
    }

    public void setStartime(Date startime) {
        this.startime = startime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public String getCpnname() {
        return cpnname;
    }

    public void setCpnname(String cpnname) {
        this.cpnname = cpnname;
    }

    public String getCpngrade() {
        return cpngrade;
    }

    public void setCpngrade(String cpngrade) {
        this.cpngrade = cpngrade;
    }

    public String getCpnaddress() {
        return cpnaddress;
    }

    public void setCpnaddress(String cpnaddress) {
        this.cpnaddress = cpnaddress;
    }

    public Competition() {
    }

    public Competition(Date startime, Date endtime, String cpnname, String cpngrade, String cpnaddress) {
        this.startime = startime;
        this.endtime = endtime;
        this.cpnname = cpnname;
        this.cpngrade = cpngrade;
        this.cpnaddress = cpnaddress;
    }

    @Override
    public String toString() {
        return "Competition{" +
                "id=" + id +
                ", startime=" + startime +
                ", endtime=" + endtime +
                ", cpnname='" + cpnname + '\'' +
                ", cpngrade='" + cpngrade + '\'' +
                ", cpnaddress='" + cpnaddress + '\'' +
                '}';
    }
}