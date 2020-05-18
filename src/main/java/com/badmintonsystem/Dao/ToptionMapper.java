package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Toption;

public interface ToptionMapper {
    //根据营业时间查询id
    Toption SelectByInterval(String time);

    //根据id查询time
    Integer SelectTime(Integer id);

}
