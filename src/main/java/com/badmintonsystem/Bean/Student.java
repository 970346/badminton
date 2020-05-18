package com.badmintonsystem.Bean;

public class Student {
    private String stuid;

    private String stuname;

    public String getStuid() {
        return stuid;
    }

    public void setStuid(String stuid) {
        this.stuid = stuid == null ? null : stuid.trim();
    }

    public String getStuname() {
        return stuname;
    }

    public void setStuname(String stuname) {
        this.stuname = stuname == null ? null : stuname.trim();
    }

    public Student() {
    }

    public Student(String stuid, String stuname) {
        this.stuid = stuid;
        this.stuname = stuname;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuid='" + stuid + '\'' +
                ", stuname='" + stuname + '\'' +
                '}';
    }
}