package com.badmintonsystem.Bean;

public class Community {
    private Integer num;

//    private Integer comid;

    private String comname;

    private String stuid;

    private Student student;

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

//    public Integer getComid() {
//        return comid;
//    }
//
//    public void setComid(Integer comid) {
//        this.comid = comid;
//    }

    public String getComname() {
        return comname;
    }

    public void setComname(String comname) {
        this.comname = comname == null ? null : comname.trim();
    }

    public String getStuid() {
        return stuid;
    }

    public void setStuid(String stuid) {
        this.stuid = stuid == null ? null : stuid.trim();
    }

    public Community() {
    }

//    public Community(Integer comid, String comname, String stuid) {
//        this.comid = comid;
//        this.comname = comname;
//        this.stuid = stuid;
//    }

    public Community(String comname, String stuid) {
        this.comname = comname;
        this.stuid = stuid;
    }

    @Override
    public String toString() {
        return "Community{" +
                "num=" + num +
//                ", comid=" + comid +
                ", comname='" + comname + '\'' +
                ", stuid='" + stuid + '\'' +
                '}';
    }
}