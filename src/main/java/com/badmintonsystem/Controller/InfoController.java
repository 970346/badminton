package com.badmintonsystem.Controller;

import com.badmintonsystem.Bean.*;
import com.badmintonsystem.Service.*;
import com.badmintonsystem.Utils.MD5;
import com.badmintonsystem.Utils.POI;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 信息管理模块
 */
@Controller
@RequestMapping("/Info")
public class InfoController {
    @Autowired
    LoginService loginservice;
    @Autowired
    InfoService Infoservice;
    @Autowired
    FilesService filesService;
    @Autowired
    HttpServletRequest request;
    @Autowired
    UserService userService;
    @Autowired
    OrderService orderService;
    /**
     * 获取模糊查询学生条件
     */
    @RequestMapping("/GetStuInfo")
    @ResponseBody
    @ApiOperation(value = "模糊查询学生信息",httpMethod = "post",response = Student.class)
    public JSONMsg GetStuInfo(@RequestParam("stuinfo") String info, HttpSession session){
        session.setAttribute("likestuinfo",info);
        return JSONMsg.success();
    }
    /**
     * 查询学生
     */
    @RequestMapping("/ShowStu")
    @ResponseBody
    @ApiOperation(value = "分页显示所有学生信息",httpMethod = "get",response = Student.class)
    public JSONMsg getStus(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpSession session) {
        String info = (String) session.getAttribute("likestuinfo");
        if (info==null){
            info="";
        }
        PageHelper.startPage(pn, 10);
        List<Student> list = Infoservice.GetStuAll(info);
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page);
    }
    /**
     * 获取模糊查询教师条件
     */
    @RequestMapping("/GetTeaInfo")
    @ResponseBody
    @ApiOperation(value = "模糊查询教师信息",httpMethod = "post",response = Teacher.class)
    public JSONMsg GetTeaInfo(@RequestParam("teainfo") String info, HttpSession session){
        session.setAttribute("liketeainfo",info);
        return JSONMsg.success();
    }
    /**
     * 查询所有教师
     */
    @RequestMapping("/ShowTea")
    @ResponseBody
    @ApiOperation(value = "分页显示所有教师信息",httpMethod = "get",response = Teacher.class)
    public JSONMsg getTeas(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpSession session) {
        String info = (String) session.getAttribute("liketeainfo");
        if (info==null){
            info="";
        }
        PageHelper.startPage(pn, 10);
        List<Teacher> list = Infoservice.GetTeaAll(info);
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page);
    }

    /**
     * 查询所有社团学生
     */
    @RequestMapping("/ShowCom")
    @ResponseBody
    @ApiOperation(value = "分页显示所有社团信息",httpMethod = "get",response = Community.class)
    public JSONMsg getComs(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 10);
        List<Community> list = Infoservice.GetComAll();
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page);
    }

    /**
     * 模糊查询社团学生
     */
    @RequestMapping("/ShowPartCom/{pn}")
    @ResponseBody
    @ApiOperation(value = "模糊查询社团信息",httpMethod = "get",response = Community.class)
    public JSONMsg getComs(@PathVariable("pn") Integer pn, String cominfo) {
        PageHelper.startPage(pn, 10);
        List<Community> list = Infoservice.GetCom(cominfo);
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page);
    }
    /**
     * 删除学生信息
     */
    @RequestMapping(value = "/BackMagaDelStu/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    @ApiOperation(value = "删除学生信息",httpMethod = "delete",response = Student.class)
    public JSONMsg deltStus(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            String[] split = ids.split("-");
            for (int i=0;i<split.length;i++){
                //在学生表中删除信息
                Infoservice.DeleStu(split[i]);
                //查询该学生有没有订单，如果有则修改该学生的用户状态，没有则在用户表中删除该学生信息
                if (orderService.GetAllOrdersByUid(split[i]).size()==0){
                    Infoservice.DelUser(split[i]);
                }else {
                    userService.UpdateUserState(split[i]);
                }
            }
        }else
        {
            Infoservice.DeleStu(ids);
            //查询该学生有没有订单，如果有则修改该学生的用户状态，没有则在用户表中删除该学生信息
            if (orderService.GetAllOrdersByUid(ids).size()==0){
                Infoservice.DelUser(ids);
            }else{
                userService.UpdateUserState(ids);
            }
        }
        return JSONMsg.success();
    }
    /**
     * 删除教师信息
     */
    @RequestMapping(value = "/DelTea/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    @ApiOperation(value = "删除教师信息",httpMethod = "delete",response = Teacher.class)
    public JSONMsg delTeas(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            String[] split = ids.split("-");
            for (int i=0;i<split.length;i++){
                Infoservice.DeleTeaById(split[i]);
                if (orderService.GetAllOrdersByUid(split[i]).size()==0){
                    System.out.println("没订单！");
                    Infoservice.DelUser(split[i]);
                }else{
                    System.out.println("有订单！");
                    userService.UpdateUserState(split[i]);
                }
            }
        }else
        {
            String id=String.valueOf(ids);
            Infoservice.DeleTeaById(id);
            if (orderService.GetAllOrdersByUid(id).size()==0){
                System.out.println("没订单！");
                Infoservice.DelUser(id);
            }else {
                System.out.println("有订单！");
                userService.UpdateUserState(id);
            }
        }
        return JSONMsg.success();
    }
    /**
     * 删除社团学生信息
     */
    @RequestMapping(value = "/DelCom/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    @ApiOperation(value = "删除社团学生信息",httpMethod = "delete",response = Community.class)
    public JSONMsg delComs(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            //多个删除
            String[] split = ids.split(",");
            String[] id = split[0].split("-");
            String[] name = split[1].split("=");
            for (int i = 0; i <id.length ; i++) {
                //删除社团学生
                Infoservice.DeleteCom(id[i],name[i]);
                //判断该学生参加了多少个社团，如果为1则在user中修改状态
                if (Infoservice.selectcomnum(id[i])==1) {
                    userService.UpdateUserToStu(id[i]);
                }
            }
        }else {
            //单个删除
            String[] split = ids.split(",");
            Infoservice.DeleteCom(split[0],split[1]);
            if (Infoservice.selectcomnum(split[0])==1) {
                userService.UpdateUserToStu(split[0]);
            }
        }
        return JSONMsg.success();
    }

    /**
     * 文件上传
     */
    public String file(MultipartFile file) throws IOException{
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
        return filename.toString();
    }
    /**
     * 学生信息导入
     */
    @RequestMapping("/GetStu")
    @ApiOperation(value = "学生信息导入",httpMethod = "post",response = Student.class)
    public String GetStuInfo(@RequestParam("file") MultipartFile file) throws IOException {
        String s = file(file);
        //execl表读取
        List<Student> stus = POI.ReadStu(s);
        List<User> userList = new ArrayList<>();
        for (Student stulist :
                stus) {
            userList.add(new User(stulist.getStuid(), MD5.md5("123456"),3,"t"));
        }
        //设置密码
        userService.AddUserList(userList);
        //导入信息
        Infoservice.SaveStu(stus);
        return "Back_StuInfo";
    }
    /**
     * 教师信息导入
     */
    @RequestMapping("/GetTea")
    @ApiOperation(value = "教师信息导入",httpMethod = "post",response = Teacher.class)
    public String GetTeaInfo(@RequestParam("file") MultipartFile file) throws IOException {
        String s = file(file);
        List<Teacher> teachers = POI.ReadTea(s);
        List<User> userList = new ArrayList<>();
        for (Teacher tealist :
                teachers) {
            userList.add(new User(tealist.getTeaid(), MD5.md5("123456"),2,"t"));
        }
        //设置密码
        userService.AddUserList(userList);
        //导入信息
        Infoservice.SaveTea(teachers);
        return "Back_TeaInfo";
    }
    /**
     * 社团学生信息导入
     */
    @RequestMapping("/GetCom")
    @ApiOperation(value = "社团学生信息导入",httpMethod = "post",response = Community.class)
    public String GetComStuInfo(@RequestParam("file") MultipartFile file, Model model) throws IOException {
        String s = file(file);
        List<Community> communities = POI.ReadCom(s);
        for (Community com : communities) {
            if (Infoservice.SelectStu(com.getStuid())==null){
                return "Back_CommunityInfo";
            }else {
                userService.UpdateUserToCom(com.getStuid());
                Infoservice.SaveComStu(communities);
            }
        }
        return "Back_CommunityInfo";
    }


    /***
     * 新增学生信息
     */
    @RequestMapping(value = "/AddStu",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "导入学生信心",httpMethod = "post",response = Student.class)
    public JSONMsg AddStu(Student student){
        Infoservice.Addstu(student);
        userService.AddUser(new User(student.getStuid(), MD5.md5("123456"),3,"t"));
        return JSONMsg.success();
    }
    /**
     * 验证学号是否已经存在
     */
    @RequestMapping("/CheckStu")
    @ResponseBody
    public JSONMsg CheckStu(@RequestParam("stuid") String stuid){
        boolean b = loginservice.IsStudent(stuid);
        if (!b){
            return JSONMsg.success();
        }else{
            return JSONMsg.fail().add("error","学号已存在！");
        }
    }

    /***
     * 新增教师信息
     */
    @RequestMapping(value = "/AddTea",method = RequestMethod.POST)
    @ResponseBody
    public JSONMsg AddTea(Teacher teacher){
        Infoservice.AddTea(teacher);
        userService.AddUser(new User(teacher.getTeaid(), MD5.md5("123456"),2,"t"));
        return JSONMsg.success();
    }
    /**
     * 验证职工号是否已经存在
     */
    @RequestMapping("/CheckTea")
    @ResponseBody
    public JSONMsg CheckTea(@RequestParam("teaid") String teaid){
        boolean b = loginservice.IsTeacher(teaid);
        if (!b){
            return JSONMsg.success();
        }else{
            return JSONMsg.fail();
        }
    }
    /**
     * 新增社团学生
     */
    @RequestMapping(value = "/AddComStu",method = RequestMethod.POST)
    @ResponseBody
    public JSONMsg AddComStu(
            @RequestParam("comname") String comname,
            @RequestParam("stuid") String stuid){
        boolean b = Infoservice.SelectComStu( stuid,comname);
        if (!b){
            return JSONMsg.fail();
        }else {
            Infoservice.addCom(comname,stuid);
            userService.UpdateUserToCom(stuid);
            return JSONMsg.success();
        }
    }
}
