package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Competition;

import java.util.Date;
import java.util.List;

public interface CpnMapper {
    List<Competition> Insertcpn(Competition competition);

    List<Competition> SelectCpnAll();

    void DelAll();

    //查询符合赛事信息的日期
    List<Competition> FindDays(String time);

    //查询离当前日期最近的赛事信息
    Competition FindNearly(String time);

    //查询起始时间相同的赛事信息
    List<Competition> FindStar(Date time);

    //返回第一条记录的序号
    Integer SelectFirst();
}
