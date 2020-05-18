package com.badmintonsystem.Utils;

import org.springframework.util.DigestUtils;

public class MD5 {
    public static String md5(String x){
        for (int i=0;i<=1024;i++){
            x= DigestUtils.md5DigestAsHex(x.getBytes());
        }
        return x;
    }

    public static void main(String[] args) {
        String s = md5("123456Zz");
        System.out.println(s);
    }
}
