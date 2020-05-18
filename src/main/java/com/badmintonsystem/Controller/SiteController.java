package com.badmintonsystem.Controller;
import com.badmintonsystem.Bean.*;
import com.badmintonsystem.Service.*;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/Sites")
public class SiteController {
    @Autowired
    SiteService siteService;

    @Autowired
    ToptionService toptionService;

    @Autowired
    LoginService loginService;

    @Autowired
    RoleService roleService;

    @Autowired
    OrderService orderService;

    @Autowired
    IncomeService incomeService;
    /**
     * 查询得到所有场地信息
     */
    @RequestMapping("GetSites")
    @ResponseBody
    @ApiOperation(value = "显示所有场地信息",httpMethod = "get",response = Sites.class)
    public JSONMsg GetSites(){
        List<Sites> sites = siteService.SelectAllSite();
        return JSONMsg.success().add("pageInfo", sites);
    }
    /**
     * 关闭所有场地
     */
    @RequestMapping("CloseSites")
    @ResponseBody
    @ApiOperation(value = "闭馆操作",response = Sites.class)
    public JSONMsg CloseSites(){
        siteService.CloseAllSite();
        return JSONMsg.success();
    }
    /**
     * 打开所有场地
     */
    @RequestMapping("OpenSites")
    @ApiOperation(value = "开馆操作",response = Sites.class)
    @ResponseBody
    public JSONMsg OpenSites(){
        siteService.OpenAllSite();
        return JSONMsg.success();
    }
    /**
     * 获取场地名
     */
    @RequestMapping(value = "/Getsname/{backSiteid}",method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "根据场地id获取场地相关信息",httpMethod = "get",response = Sites.class)
    public JSONMsg BackSiteGetname(@PathVariable("backSiteid") String sid){
        //获取场地名
        String sname = siteService.Getsname(Integer.valueOf(sid));
        //获取time
        Integer integer = siteService.GetTime(Integer.valueOf(sid));
        Integer duration = 0;
        List<String> IntervalList = new ArrayList<>();
        switch (integer){
            case 1:
                IntervalList.clear();
                duration=1;
                IntervalList.add("6-7");
                break;
            case 2:
                IntervalList.clear();
                duration=1;
                IntervalList.add("7-8");
                break;
            case 3:
                IntervalList.clear();
                duration=2;
                IntervalList.add("6-7");
                IntervalList.add("7-8");
                IntervalList.add("6-8");
                break;
            case 4:
                IntervalList.clear();
                duration=1;
                IntervalList.add("8-9");
                break;
            case 5:
                IntervalList.clear();
                duration=2;
                IntervalList.add("6-7");
                IntervalList.add("8-9");
                IntervalList.add("6-7,8-9");
                break;
            case 6:
                IntervalList.clear();
                duration=2;
                IntervalList.add("7-8");
                IntervalList.add("8-9");
                IntervalList.add("7-9");
                break;
            case 7:
                IntervalList.clear();
                duration=3;
                IntervalList.add("6-7");
                IntervalList.add("7-8");
                IntervalList.add("8-9");
                IntervalList.add("6-8");
                IntervalList.add("7-9");
                IntervalList.add("6-9");
                IntervalList.add("6-7,8-9");
                break;
        }
        return JSONMsg.success().add("name",sname).add("time",duration).add("list",IntervalList);
    }

    /**
     * 获取预定信息
     */
    @ResponseBody
    @ApiOperation(value = "获取预定的场地信息",httpMethod = "post",response = Sites.class)
    @RequestMapping(value = "/GetFrontSitesInfo/{FrontSiteId}",method = RequestMethod.POST)
    public JSONMsg GetSites(
            @PathVariable("FrontSiteId") Integer FrontSiteId,
            @RequestParam("FrontSitetime") String FrontSitetime,
            @RequestParam("FrontSiterackets") String FrontSiterackets,
            @RequestParam("FrontSiteball") String FrontSiteball,
            HttpSession session){
        String uids = session.getAttribute("uid").toString();
        //查询级别
        int i = loginService.Rid(uids);
        Integer mo = roleService.SelectMo(i);
        //根据预定时间段查询预定了几个小时
        Toption toption = toptionService.SelectId(FrontSitetime);
        Integer times=toption.getTime();
        //计算金额
        int stprice = times*mo;
        int gdprice=Integer.parseInt(FrontSiteball)*6+Integer.parseInt(FrontSiterackets)*5;
        int money=gdprice+stprice;
        return JSONMsg.success().add("sid",FrontSiteId).add("data",FrontSitetime).add("rackets",FrontSiterackets).add("balls",FrontSiteball).add("money",money);
    }

    /**
     * 后台更新场地信息
     */
    @RequestMapping(value = "/UpdateSites/{id}",method = RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(value = "后台更新场地信息",httpMethod = "put")
    public JSONMsg BackMagaUpdateSites(
            @PathVariable("id") Integer id,
            @RequestParam("state") String state,
            @RequestParam("time") String time
            ){
        if (state.equals("f")){
            siteService.CloseSite(id);
        }else {
            Integer tid = toptionService.SelectId(time).getId();
            siteService.OpenSite(id,tid);
        }
        return JSONMsg.success();
    }

    /**
     *预定成功后后更新场地信息
     */
    @RequestMapping(value = "/UpdateSitesInfo",method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "前端预定后更新场地信息",httpMethod = "get")
    public JSONMsg UpdateSites(
            HttpSession session,
            @RequestParam("sid") String sid,
            @RequestParam("time") String time,
            @RequestParam("racket") String rackets,
            @RequestParam("ball") String ball,
            @RequestParam("money") String money
    ){
        //获取用户id
        String Uid = (String) session.getAttribute("uid");
        //判断用户状态
        if (loginService.getState(Uid).equals("f")){
            return JSONMsg.fail();
        }else{
            int i = loginService.Rid(Uid);
            Integer mo = roleService.SelectMo(i);
            //根据场地号查询场地开放时间
            Integer Sites_time = siteService.GetTime(Integer.valueOf(sid));
            Integer Time = toptionService.SelectTime(Sites_time);
            //根据时间查询预定时长
            Toption toption = toptionService.SelectId(time);
            Integer Ttime = toption.getTime();
            //更新场地信息
            if ((Time-Ttime)==0){
                siteService.CloseSite(Integer.parseInt(sid));
            }else {
                Integer is = Sites_time - toption.getId();
                siteService.OpenSite(Integer.valueOf(sid),is);
            }
            Integer stprice=mo*Ttime;
            Integer gdprice=Integer.parseInt(rackets)*5+Integer.parseInt(ball)*6;
            Date date = new Date();
            SimpleDateFormat Todaytime = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
            String s = Todaytime.format(date);
            String text=s+"预定了"+sid+"号场地"+Ttime+"小时（"+time+"），且租了"+rackets+"把球拍，买了"+ball+"个球";
            String state="t";
            String s1 = Todaytime.format(new Date());
            String orid = s1.replaceAll("[- :]", "");
            orid+=Uid.substring(Uid.length()-4);
            Order order = new Order(orid,Uid,Integer.valueOf(sid),Ttime,time,stprice,Integer.parseInt(ball),Integer.parseInt(rackets),gdprice,Integer.valueOf(money),s,text,state);
            orderService.Add(order);
            incomeService.UpdateTime(Ttime);
            incomeService.UpdateMoney(Double.valueOf(money));
            return JSONMsg.success();
        }
    }
}
