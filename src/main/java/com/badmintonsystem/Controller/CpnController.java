package com.badmintonsystem.Controller;

import com.badmintonsystem.Bean.Competition;
import com.badmintonsystem.Bean.Files;
import com.badmintonsystem.Bean.JSONMsg;
import com.badmintonsystem.Service.CpnService;
import com.badmintonsystem.Service.FilesService;
import com.badmintonsystem.Utils.POI;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/Cpn")
public class CpnController {
    @Autowired
    CpnService cpnService;
    @Autowired
    FilesService filesService;
    @Autowired
    HttpServletRequest request;
    /**
     * 分页查询
     */
    @RequestMapping("/ShowCpn")
    @ResponseBody
    @ApiOperation(value = "分页显示所有赛事信息",httpMethod = "get",response = Competition.class)
    public JSONMsg getCpns(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                           @RequestParam(value = "pages") Integer pages,
                           @RequestParam(value = "ln") Integer ln,
                           @RequestParam(value = "ls") Integer ls) {
        PageHelper.startPage(pn, 10);
        List<Competition> list = cpnService.GetCpnAll();
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page).add("pages",pages);
    }
    /**
     * 查询离当前日期最近的比赛信息在第几页
     */
    @RequestMapping(value = "/FindNearly/{startime}",method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "显示赛事信息",httpMethod = "get",response = Competition.class)
    public JSONMsg FindNearly(@PathVariable("startime") String startime){
        //获取数据库里的第一条信息的id,用于计算页数
        Integer firstid = cpnService.FindFirst();
        //定义变量，用于记录第几页、是当前页的第几条数据、符合条件的有多少个、状态
        Integer page = 0,litsnum = 0,size = 0,State = 0;
        //判断当前日期是否有比赛
        List<Competition> list = cpnService.FindDays(startime);
        if (list.size()==0){
            //没有比赛则查询离当前日期最近的赛事信息
            Competition competition = cpnService.FindNearly(startime);
            List<Competition> competitionList = cpnService.FindStar(competition.getStartime());
            //判断是否还有相同起始时间的赛事信息
            if (competitionList.size()==0){
                //没有
                size=1;
            }else {
                //有
                size=competitionList.size();
            }
            //计算在第几页
            page = (competition.getId()-firstid)/10+1;
            if ((competition.getId()-firstid)>10){
                litsnum = (competition.getId()-firstid) - 10*(page-1);
            }else {
                litsnum = (competition.getId()-firstid);
            }
            return JSONMsg.success().add("pageid",page).add("listnum",litsnum).add("listsize",size).add("state",State);
        }else{
            State = 1;
            //有比赛，则获取第一条赛事信息的id
            Integer id = list.get(0).getId();
            System.out.println("有比赛！");
            //有比赛则计算比赛信息在第几页
            page = ((id-firstid)/10)+1;
            //计算是当前页面的第几条数据
            if ((id - firstid)>10){
                litsnum = id - firstid - 10*(page-1);
            }else
            {
                litsnum = id - firstid;
            }
            size=list.size();
            return JSONMsg.success().add ("pageid",page).add("listnum",litsnum).add("listsize",size).add("state",State);
        }
    }
    /**
     * 后台分页查询
     */
    @RequestMapping("/GetCpn")
    @ResponseBody
    @ApiOperation(value = "显示所有赛事信息",httpMethod = "get",response = Competition.class)
    public JSONMsg BackMagaShowAllCpnsInfo(@RequestParam(value = "Cpnspagepn", defaultValue = "1") Integer Cpnspn) {
        PageHelper.startPage(Cpnspn, 10);
        List<Competition> ShowAllEventsInfoList = cpnService.GetCpnAll();
        PageInfo BackMagaEventsInfo= new PageInfo(ShowAllEventsInfoList, 5);
        return JSONMsg.success().add("pageInfo", BackMagaEventsInfo);
    }

    /**
     * 赛事信息导入
     */
    @RequestMapping("/InputCpn")
    @ResponseBody
    @ApiOperation(value = "导入赛事信息",httpMethod = "post",response = Competition.class)
    public JSONMsg GetStuInfo(@RequestParam("file") MultipartFile file) throws IOException, ParseException {
        //删除去年的赛事信息
        cpnService.DelAll();
        //获取文件名
        String name = file.getOriginalFilename();
        //获取服务器地址
        String path = request.getSession().getServletContext().getRealPath("/files")+"/";
        if(!new File(path).exists()){
            new File(path).mkdir();
        }
        //获取当前时间
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = df.format(day);
        String s = format.replaceAll("[ :-]", "");
        //组装文件名
        File filename=new File(path+s+name);
        //将文件信息写入数据库
        Files files = new Files(s+name,filename.toString());
        filesService.SaveFile(files);
        //上传文件
        file.transferTo(filename);
        List<Competition> competitionList = POI.ReadCpn(filename.toString());
        cpnService.SaveCpm(competitionList);
        return JSONMsg.success();
    }
}
