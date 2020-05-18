package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.User;
import com.badmintonsystem.Dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    UserMapper userMapper;
    /**
     * 批量添加用户
     */
    public void AddUserList(List<User> user){
        for (User s:user
             ) {
            userMapper.AddUser(s);
        }
    }
    /**
     * 单个添加用户
     */
    public void AddUser(User user){
        userMapper.AddUser(user);
    }
    /**
     * 将普通学生转为社团学生
     */
    public void UpdateUserToCom(String id){
        userMapper.UpdateUserToCom(id);
    }
    /**
     * 将社团学生转为普通学生
     */
    public void UpdateUserToStu(String id){
        userMapper.UpdateUserToStu(id);
    }
    /**
     * 更改用户状态
     */
    public void UpdateUserState(String id){
        userMapper.UpdateUserState(id);
    }
}
