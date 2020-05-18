package com.badmintonsystem.Bean;

import net.sf.jsqlparser.statement.select.Top;

public class Sites {
    private Integer sid;

    private String sname;

    private Integer time;

    private String state;

    private Toption toption;

    public Toption getToption() {
        return toption;
    }

    public void setToption(Toption toption) {
        this.toption = toption;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname == null ? null : sname.trim();
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Sites() {
    }

    public Sites(Integer sid, String sname, Integer time, String state) {
        this.sid = sid;
        this.sname = sname;
        this.time = time;
        this.state = state;
    }

    @Override
    public String toString() {
        return "Sites{" +
                "sid=" + sid +
                ", sname='" + sname + '\'' +
                ", time=" + time +
                ", state='" + state + '\'' +
                '}';
    }
}