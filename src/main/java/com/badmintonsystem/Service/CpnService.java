package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.Competition;
import com.badmintonsystem.Bean.Student;
import com.badmintonsystem.Dao.CpnMapper;
import io.swagger.models.auth.In;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CpnService {
    @Autowired
    CpnMapper cpnMapper;

    /**
     * 导入赛事信息
     */
    public void SaveCpm(List<Competition> competitions){
        for (Competition competition:competitions){
            cpnMapper.Insertcpn(competition);
        }
    }
    /**
     * 查询所有信息
     * @return
     */
    public List<Competition> GetCpnAll() {
        return cpnMapper.SelectCpnAll();
    }
    /**
     * 删除所有赛事信息
     */
    public void DelAll(){
        cpnMapper.DelAll();
    }
    /**
     * 查询离当前日期最近的id
     */
    public Competition FindNearly(String time){
        return cpnMapper.FindNearly(time);
    }
    /**
     * 查询起始时间相同的赛事信息
     */
    public List<Competition> FindStar(Date time){
        return cpnMapper.FindStar(time);
    }
    /**
     * 查询符合赛事日期的赛事
     */
    public List<Competition> FindDays(String startime){
        return cpnMapper.FindDays(startime);
    }
    /**
     * 查找第一条数据的id
     */
    public Integer FindFirst(){
        return cpnMapper.SelectFirst();
    }
}
