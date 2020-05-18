package com.badmintonsystem.Bean;

public class User {
    private String uid;
    private String upwd;
    private int rid;
    private String state;

    public User(String uid, String upwd) {
        this.uid = uid;
        this.upwd = upwd;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public User() {
    }

    public User(String uid, String upwd, int rid, String state) {
        this.uid = uid;
        this.upwd = upwd;
        this.rid = rid;
        this.state = state;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid='" + uid + '\'' +
                ", upwd='" + upwd + '\'' +
                ", rid=" + rid +
                ", state='" + state + '\'' +
                '}';
    }
}
