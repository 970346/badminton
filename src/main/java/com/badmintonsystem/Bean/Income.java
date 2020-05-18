package com.badmintonsystem.Bean;

import java.util.Date;

public class Income {
    private Integer inid;
    private Integer lgnum;
    private Integer stime;
    private Double money;
    private Date datess;

    public Integer getInid() {
        return inid;
    }

    public void setInid(Integer inid) {
        this.inid = inid;
    }

    public Integer getLgnum() {
        return lgnum;
    }

    public void setLgnum(Integer lgnum) {
        this.lgnum = lgnum;
    }

    public Integer getStime() {
        return stime;
    }

    public void setStime(Integer stime) {
        this.stime = stime;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Date getDatess() {
        return datess;
    }

    public void setDatess(Date datess) {
        this.datess = datess;
    }

    @Override
    public String toString() {
        return "Income{" +
                "inid=" + inid +
                ", lgnum=" + lgnum +
                ", stime=" + stime +
                ", money=" + money +
                ", datess=" + datess +
                '}';
    }
}
