package com.badmintonsystem.Controller;

import com.badmintonsystem.Bean.Income;
import com.badmintonsystem.Bean.JSONMsg;
import com.badmintonsystem.Service.IncomeService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("Income")
public class IncomeController {
    @Autowired
    IncomeService incomeService;

    /**
     * 查询今日数据
     */
    @ResponseBody
    @ApiOperation(value = "查询今日数据",httpMethod = "GET",response = Income.class)
    @RequestMapping("SearchNowData")
    public JSONMsg SearchNowData(){
        Income income = incomeService.SelectToday();
        return JSONMsg.success().add("in",income);
    }
    /**
     * 查询近七天的数据
     */
    @ResponseBody
    @ApiOperation(value = "查询近七天的数据",httpMethod = "GET",response = Income.class)
    @RequestMapping("SearchNearlyWeekData")
    public JSONMsg SearchWeekData(){
        List<Income> incomes = incomeService.SelectDays();
        return JSONMsg.success().add("list",incomes);
    }

}
