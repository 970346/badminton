package com.badmintonsystem.Bean;

public class Order {
    private String orid;
    private String uid;
    private Integer sid;
    private Integer stime;
    private String timenterval;
    private Integer stprice;
    private Integer balls;
    private Integer rackets;
    private Integer gdprice;
    private Integer tlprice;
    private String odata;
    private String instructions;
    private String ostate;


    public String getOrid() {
        return orid;
    }

    public void setOrid(String orid) {
        this.orid = orid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getStime() {
        return stime;
    }

    public void setStime(Integer stime) {
        this.stime = stime;
    }

    public String getTimenterval() {
        return timenterval;
    }

    public void setTimenterval(String timenterval) {
        this.timenterval = timenterval;
    }

    public Integer getStprice() {
        return stprice;
    }

    public void setStprice(Integer stprice) {
        this.stprice = stprice;
    }

    public Integer getBalls() {
        return balls;
    }

    public void setBalls(Integer balls) {
        this.balls = balls;
    }

    public Integer getRackets() {
        return rackets;
    }

    public void setRackets(Integer rackets) {
        this.rackets = rackets;
    }

    public Integer getGdprice() {
        return gdprice;
    }

    public void setGdprice(Integer gdprice) {
        this.gdprice = gdprice;
    }

    public Integer getTlprice() {
        return tlprice;
    }

    public void setTlprice(Integer tlprice) {
        this.tlprice = tlprice;
    }

    public String getOdata() {
        return odata;
    }

    public void setOdata(String odata) {
        this.odata = odata;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public String getOstate() {
        return ostate;
    }

    public void setOstate(String ostate) {
        this.ostate = ostate;
    }

    public Order() {
    }

    public Order(String orid, String uid, Integer sid, Integer stime, String timenterval, Integer stprice, Integer balls, Integer rackets, Integer gdprice, Integer tlprice, String odata, String instructions, String ostate) {
        this.orid = orid;
        this.uid = uid;
        this.sid = sid;
        this.stime = stime;
        this.timenterval = timenterval;
        this.stprice = stprice;
        this.balls = balls;
        this.rackets = rackets;
        this.gdprice = gdprice;
        this.tlprice = tlprice;
        this.odata = odata;
        this.instructions = instructions;
        this.ostate = ostate;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orid=" + orid +
                ", uid='" + uid + '\'' +
                ", sid=" + sid +
                ", stime=" + stime +
                ", timenterval='" + timenterval + '\'' +
                ", stprice=" + stprice +
                ", gdprice=" + gdprice +
                ", tlprice=" + tlprice +
                ", odata='" + odata + '\'' +
                ", instructions='" + instructions + '\'' +
                ", ostate='" + ostate + '\'' +
                '}';
    }
}
