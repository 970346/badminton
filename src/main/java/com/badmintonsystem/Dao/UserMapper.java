package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.User;

import java.util.List;

public interface UserMapper {
    List<User> AddUser(User user);

    //将普通学生转变为社团学生
    void UpdateUserToCom(String id);

    //更改用户状态
    void UpdateUserState(String id);

    //将社团学生转变为普通学生
    void UpdateUserToStu(String id);
}
