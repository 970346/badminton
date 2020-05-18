package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Income;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IncomeMapper {
    //根据日期查询主键
    Integer SelectByDate(String date);
    //自动插入数据
    void AddInfo(String date);
    //更新访问人数
    void UpdateLgNum(@Param("inid") Integer inid);
    //更新订场时长
    void UpdateStime(@Param("time") Integer time,@Param("inid") Integer inid);
    //更新订场金额
    void UpdateMoney(@Param("money") double money,@Param("inid") Integer inid);
    //查询今日数据
    Income SelectToday();
    //查询近七天的数据
    List<Income> SelectDays();
}
