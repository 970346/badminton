package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.User;
import com.badmintonsystem.Dao.LoginMapper;
import com.badmintonsystem.Utils.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
    @Autowired
    LoginMapper mapper;

    /**
     *
     */
    public String getState(String id){
        return mapper.SelectUserById(id).getState();
    }

    /**
     * 判断用户是否存在
     */
    public boolean isUserExist(String id){
        if (mapper.SelectUserById(id)==null){
            return false;
        }else{
            return true;
        }
    }

    /**
     * 根据用户账号拿到密码
     */
    public User getUser(String id,String pwd){
        return mapper.SelectUser(id, pwd);
    }

    /**
     * 添加用户信息
     */
    public void addUser(String uid, String pwd,int rid) {
        User user = new User();
        user.setRid(4);
        user.setUid(uid);
        user.setUpwd(pwd);
        user.setRid(rid);
        mapper.AddUser(user);
    }

    /**
     * 更新用户信息
     */
    public void changepwd(String uid, String upwd){
        User user = new User(uid,upwd);
        mapper.UpdateUser(user);
    }

    /**
     * 判断是否为学生
     */
    public boolean IsStudent(String id){
        if (mapper.SelectStudentById(id)==null){
            return false;
        }
        else{
            return true;
        }
    }

    /**
     * 判断是否为教师
     */
    public boolean IsTeacher(String id){
        if (mapper.SelectTeacherById(id)==null){
            return false;
        }
        else{
            return true;
        }
    }

    /**
     * 判断是否为社团学生
     */
    public boolean IsComStu(String id){
        if (mapper.SelectCommunityById(id)==null){
            return false;
        }
        else{
            return true;
        }
    }

    /**
     * 查询用户级别
     */
    public Integer Rid(String id){
        return mapper.Selectridbyuid(id);
    }
}