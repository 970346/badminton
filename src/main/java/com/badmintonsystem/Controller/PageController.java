package com.badmintonsystem.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

/**
 * 页面跳转
 */
@Controller
@RequestMapping("/Pages")
public class PageController {
    @Autowired
    HttpSession session;

    //跳转至登录页面
    @RequestMapping("/ToLogin")
    public String ToLogin() {
        return "Login";
    }

    //跳转至注册页面
    @RequestMapping("/ToReg")
    public String ToReg() {
        return "Reg";
    }

    //跳转至修改密码页面
    @RequestMapping("/ToChange")
    public String Tochange() {
        return "Changepwd";
    }

    @RequestMapping("/mage")
    public String Tomang() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_Index";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/welcome")
    public String Towelcome() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "welcome";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToStuInfo")
    public String ToStuInfo() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_StuInfo";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToTeaInfo")
    public String ToTeaInfo() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_TeaInfo";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToCommunityInfo")
    public String ToComInfo() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_CommunityInfo";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToFiles")
    public String ToFilesInfo() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_Files";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToSites")
    public String ToSites() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_SitesInfo";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToComp")
    public String ToCpns() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_CompInfo";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToCpns")
    public String ToCopns() {
        if (session.getAttribute("uid") != null && !session.getAttribute("uid").equals("admin")) {
            return "Front_CompInfo";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToReserve")
    public String ToReserve() {
        if (session.getAttribute("uid") != null && !session.getAttribute("uid").equals("admin")) {
            return "Front_ReserveSites";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToHome")
    public String ToHome() {
        if (session.getAttribute("uid") != null && !session.getAttribute("uid").equals("admin")) {
            return "Front_Index";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToPersonBills")
    public String ToPersonBills() {
        if (session.getAttribute("uid") != null && !session.getAttribute("uid").equals("admin")) {
            return "Front_PersonBills";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToOrders")
    public String ToOrders() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_Orders";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToToday")
    public String ToToday() {
        if (session.getAttribute("uid") != null && session.getAttribute("uid").equals("admin")) {
            return "Back_Today";
        } else {
            return "Login";
        }
    }

    @RequestMapping("/ToBackchange")
    public String ToChanges() {
        return "Back_Changes";
    }
}
