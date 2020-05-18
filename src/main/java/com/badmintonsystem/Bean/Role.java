package com.badmintonsystem.Bean;

public class Role {
    private Integer rid;
    private String rname;
    private Integer mo;

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public Integer getMo() {
        return mo;
    }

    public void setMo(Integer mo) {
        this.mo = mo;
    }

    public Role() {
    }

    public Role(Integer rid, String rname, Integer mo) {
        this.rid = rid;
        this.rname = rname;
        this.mo = mo;
    }
}
