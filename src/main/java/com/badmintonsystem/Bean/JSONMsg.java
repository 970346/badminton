package com.badmintonsystem.Bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用返回的类(用于返回JSON数据)
 */
public class JSONMsg {
    private int code;//状态码100---成功，200---失败
    private String msg;//提示信息
    //用户要返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<String, Object>();
    public static JSONMsg success() {
        JSONMsg result = new JSONMsg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }
    public static JSONMsg fail() {
        JSONMsg result = new JSONMsg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }
    public JSONMsg add(String key, Object value) {
        this.getExtend().put(key, value);
        return this;
    }
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }
    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
