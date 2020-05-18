package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface InfoMapper {
    //删除用户信息
    void DelUser(String id);
    //导入学生信息
    List<Student> InsertStu(Student student);
    //导入教师信息
    List<Teacher> InsertTea(Teacher teacher);
    //导入社团信息
    List<Community> InsertCom(Community community);

    //根据学号查询学生
    Student SelectStuById(String stuid);
    //查询学生
    List<Student> SelectStuAll(String value);
    //查询所有老师
    List<Teacher> SelectTeaAll(String value);
    //查询社团学生信息
    List<Community> selectByExampleWithStu(CommunityExample example);

    //删除学生信息
    void DelStu(String id);
    //删除对应的社团学生信息
    void DelComStu(String id);

    //删除教师信息
    void DeleTeaById(String id);
    //通过学号和社团名查社团
    Community selectCmobyStu(@Param("stuid") String id,@Param("comname") String name);
    //通过num删除社团学生信息
    void DeleComById(Integer id);

    //模糊查询社团学生信息
    List<Community> SelectCom(String text);

    //新增学生信息
    void AddStu(Student student);
    //新增教师信息
    void AddTea(Teacher teacher);
    //新增社团学生信息
    void AddCom(@Param("comname") String comname,@Param("stuid") String stuid);
    /**
     * 查询一个学号的学生有多少个社团
      */
    Integer seletcomnum(String id);
}
