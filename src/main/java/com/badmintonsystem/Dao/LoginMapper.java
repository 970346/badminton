package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Community;
import com.badmintonsystem.Bean.Student;
import com.badmintonsystem.Bean.Teacher;
import com.badmintonsystem.Bean.User;
import org.apache.ibatis.annotations.Param;

public interface LoginMapper {
    User SelectUser(@Param("uid") String id,@Param("upwd") String pwd);
    //根据id查询用户信息
    User SelectUserById(String id);
    //添加用户
    void AddUser(User user);
    //更新用户信息
    void UpdateUser(User user);
    //根据学号查询学生
    Student SelectStudentById(String stuid);
    //根据职工号查询教师
    Teacher SelectTeacherById(String teaid);
    //根据学号查询社团学生
    Community SelectCommunityById(String stuid);
    //根据用户账号查级别
    int Selectridbyuid(String id);
}
