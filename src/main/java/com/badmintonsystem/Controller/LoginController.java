package com.badmintonsystem.Controller;

import com.badmintonsystem.Bean.Files;
import com.badmintonsystem.Bean.JSONMsg;
import com.badmintonsystem.Bean.User;
import com.badmintonsystem.Service.IncomeService;
import com.badmintonsystem.Service.LoginService;
import com.badmintonsystem.Utils.MD5;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * 登录注册模块
 */
@Controller
@RequestMapping("/Login")
public class LoginController {
    @Autowired
    LoginService loginService;
    @Autowired
    IncomeService incomeService;
    @Autowired
    HttpSession session;

    /**
     * 登录
     */
    @RequestMapping(value = "/SystemAdminPagelogin", method = RequestMethod.POST)
    @ApiOperation(value = "登录验证",httpMethod = "post",response = User.class)
    public String login(@RequestParam("uid") String uid, @RequestParam("upwd") String upwd, HttpSession session, Model model) {
        if (loginService.isUserExist(uid) == false) {
            model.addAttribute("error", "用户不存在！");
            return "Login";
        } else if (loginService.getUser(uid, MD5.md5(upwd)) == null) {
            model.addAttribute("errors", "密码错误！");
            return "Login";
        } else {
            if (uid.equals("admin")) {
                session.setAttribute("uid", uid);
                return "Back_Index";
            } else {
                session.setAttribute("uid", uid);
                incomeService.UpdateLgNum();
                return "Front_Index";
            }
        }
    }

    /**
     * 登录界面修改密码
     */
    @RequestMapping(value = "/changes", method = RequestMethod.POST)
    public String changes(@RequestParam("uid") String uid, @RequestParam("upwd") String upwd) {
        loginService.changepwd(uid, MD5.md5(upwd));
        return "Login";
    }

    /**
     * 前台页面修改密码
     */
    @RequestMapping(value = "/fchanges", method = RequestMethod.POST)
    public String Frontchanges(@RequestParam("upwd") String upwd) {
        String uid = (String) session.getAttribute("uid");
        loginService.changepwd(uid, MD5.md5(upwd));
        return "Front_Index";
    }

    /**
     * 用户注册
     */
    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    public String reg(@RequestParam("uid") String uid, @RequestParam("upwd") String upwd) {
        loginService.addUser(uid, MD5.md5(upwd), 4);
        return "Login";
    }

    /**
     * 检查用户是否存在
     */
    @RequestMapping("checkuser")
    @ResponseBody
    @ApiOperation(value = "检查用户是否存在", httpMethod = "post", response = Files.class)
    public JSONMsg checkuser(String uid) {
        if (loginService.isUserExist(uid) == false) {
            return JSONMsg.fail().add("errormsg", "用户不存在！");
        } else {
            return JSONMsg.success();
        }
    }
}
