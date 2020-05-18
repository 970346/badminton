package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.*;
import com.badmintonsystem.Dao.InfoMapper;
import com.badmintonsystem.Dao.LoginMapper;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import io.swagger.models.auth.In;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class InfoService {
    @Autowired
    InfoMapper Infomapper;

    @Autowired
    LoginService loginService;
    /**
     * 根据学号查询学生
     */
    public Student SelectStu(String stuid){
        return Infomapper.SelectStuById(stuid);
    }
    /**
     * 查询学生信息
     */
    public List<Student> GetStuAll(String value){
        return Infomapper.SelectStuAll(value);
    }

    /**
     * 导入学生信息
     */
            public void SaveStu(List<Student> stu){
        for (Student s:stu){
            Infomapper.InsertStu(s);
        }
    }
    /**
     * 删除学生信息
     */
    public void DeleStu(String id) {
        Infomapper.DelComStu(id);
        Infomapper.DelStu(id);
    }
    /***
     * 新增学生信息
     */
    public void Addstu(Student student){
        Infomapper.AddStu(student);
    }

    /**
     * 导入教师信息
     */
    public void SaveTea(List<Teacher> tea){
        for (Teacher t:tea){
            Infomapper.InsertTea(t);
        }
    }
    /**
     * 查询教师信息
     */
    public List<Teacher> GetTeaAll(String value){
        return Infomapper.SelectTeaAll(value);
    }

    /**
     * 删除教师
     */
    public void DeleTeaById(String id) {
        Infomapper.DeleTeaById(id);
    }
    /***
     * 新增学生信息
     */
    public void AddTea(Teacher teacher){
        Infomapper.AddTea(teacher);
    }
    /**
     * 导入社团学生信息
     */
    public void SaveComStu(List<Community> communities){
        for (Community com:communities){
            Infomapper.InsertCom(com);
        }
    }
    /**
     * 查询社团信息
     */
    public List<Community> GetComAll(){
        return Infomapper.selectByExampleWithStu(null);
    }
    /**
     * 模糊查询社团学生信息
     */
    public List<Community> GetCom(String t){
        return Infomapper.SelectCom(t);
    }
    /**
     * 删除社团信息
     */
    public void DeleteCom(String id,String name){
        Integer integer = Infomapper.selectCmobyStu(id, name).getNum();
        Infomapper.DeleComById(integer);
    }

    /**
     * 删除学生
     */
    public void DelUser(String id){
        Infomapper.DelUser(id);
    }

    /**
     * 查询社团学生
     */
    public boolean SelectComStu(String comname,String id){
        Community community = Infomapper.selectCmobyStu(comname, id);
        if (community==null){
            return true;
        }else {
            return false;
        }
    }
    /**
     * 新增社团学生
     */
    public void addCom(String comname, String stuid) {
        Infomapper.AddCom(comname,stuid);
    }
    /**
     * 查询学生参与了多少个社团
     */
    public Integer selectcomnum(String id){
        return Infomapper.seletcomnum(id);
    }
}
