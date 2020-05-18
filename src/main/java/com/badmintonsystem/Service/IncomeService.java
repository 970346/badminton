package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.Income;
import com.badmintonsystem.Dao.IncomeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class IncomeService {
    @Autowired
    IncomeMapper incomeMapper;
    /**
     * 获取当前系统时间
     */
    public String GetDate(){
        Date date = new Date();
        java.text.SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
        return formatter.format(date);
    }
    /**
     *  查询返回主键
     */
    public Integer GetId(){
        return incomeMapper.SelectByDate(GetDate());
    }
    /**
     * 定时插入
     */
    @Scheduled(cron = "0/1 * *  * * ? ")
    public void AddInfo(){
        //先判断是否有今日数据，如果没有就添加一条数据
        if (GetId()==null){
            incomeMapper.AddInfo(GetDate());
        }
    }

    /**
     *登录人数+1
     */
    public void UpdateLgNum(){
        incomeMapper.UpdateLgNum(GetId());
    }

    /**
     * 更新订场时长
     */
    public void UpdateTime(Integer Sitetime){
        incomeMapper.UpdateStime(Sitetime,GetId());
    }

    /**
     * 更新金额
     */
    public void UpdateMoney(Double money){
        incomeMapper.UpdateMoney(money,GetId());
    }
    /**
     * 查询今日数据
     */
    public Income SelectToday(){
        return incomeMapper.SelectToday();
    }
    /**
     * 查询近7天数据
     */
    public List<Income> SelectDays(){
        return incomeMapper.SelectDays();
    }
}
