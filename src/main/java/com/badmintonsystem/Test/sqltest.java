package com.badmintonsystem.Test;

import com.badmintonsystem.Bean.*;
import com.badmintonsystem.Dao.*;
import com.badmintonsystem.Service.InfoService;
import com.badmintonsystem.Service.LoginService;
import com.badmintonsystem.Service.OrderService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class sqltest {
    @Autowired
    LoginMapper mapper;

    @Autowired
    LoginService service;

    @Autowired
    InfoService infoService;

    @Autowired
    InfoMapper testmapper;

    @Autowired
    SqlSession sqlSession;

    @Autowired
    InfoMapper infoMapper;

    @Autowired
    FilesMapper filesMapper;

    @Autowired
    SiteMapper siteMapper;

    @Autowired
    CpnMapper cpnMapper;

    @Autowired
    ToptionMapper toptionMapper;

    @Autowired
    RoleMapper roleMapper;
    @Autowired
    LoginService loginService;
    @Autowired
    OrderMapper orderMapper;

    @Autowired
    IncomeMapper incomeMapper;
    @Autowired
    OrderService orderService;

    @Test
    public void test() throws  IOException {
        Competition competition = cpnMapper.FindNearly("2020-05-06");
        System.out.println(competition);
//        System.out.println(infoMapper.seletcomnum("1950801040"));
//        Student student = infoService.SelectStu("1950801005");
//        System.out.println(student);
//        String str = "1234567890111";
//        int n = 4;
//        System.out.println(str.substring(str.length()-n));
//    orderService.OutpuMonth();
//        List<Order> orders = orderMapper.SelectAnyMonth("3");
//        System.out.println(orders);
//        List<Income> incomes = incomeMapper.SelectDays();
//        System.out.println(incomes);
//        Date date = new Date();
//        java.text.SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
//        String s = formatter.format(date);
//        Integer integer = incomeMapper.SelectByDate(s);
//        incomeMapper.UpdateStime(-5,integer);
//        incomeMapper.UpdateStime(1,s);
//        Income income = incomeMapper.SelectByDate(s);
//        System.out.println(income.getInid());
//        incomeMapper.UpdateLgNum(income.getInid());
//        if (income!=null){
//            System.out.println("存在");
//        }else
//            System.out.println("不存在");
//        System.out.println(s);
//        incomeMapper.AddInfo(s);
//        incomeMapper.UpdateLgNum(2,14);
//        List<Order> orders = orderMapper.SelectAllOrderByUid("123");
//        System.out.println(orders);
//        List<Teacher> list = infoMapper.SelectTeaAll();
//        for (Teacher t:list
//             ) {
//            System.out.println(t);
//        }
//        List<Community> list = infoMapper.SelectComAll();
//        for (Community c:list
//             ) {
//            System.out.println(c);
//        }
//        String id="1850801001";
//        Community com = testmapper.SelectComByStuid(id);
//        if (com==null){
//            System.out.println("不存在");
//        }else
//        {
//            System.out.println("存在！");
//        }
//        List<Community> selectComAll = testmapper.selectByExampleWithStu(null);
//        for (Community c:selectComAll
//             ) {
//            System.out.println(c);
//        }
//        infoService.DeleteCom("1850801003","羽毛球社团");
//        Integer integer = infoMapper.selectCmobyStu("1850801003", "羽毛球社团");
//        infoMapper.DeleComById(integer);
//        System.out.println(integer);

//        testmapper.DelStu("1850801007");
//        testmapper.DelComStu("1850801005");
//        Community community=new Community(2003001001,"羽毛球社团","1950801001");
//        testmapper.InsertCom(community);
//        filesMapper.InsertFiles("12313415613");
//        String s = filesMapper.SelectFilesByName("20200228005106tea.xlsx");
//        System.out.println(s);
//        filesMapper.DelFiles();
//        List<Student> students = infoMapper.SelectStu("雷");
//        System.out.println(students);
//        List<Community> list = infoMapper.SelectCom("002");
//        System.out.println(list);
//        infoMapper.AddStu(new Student("1850801011","张三"));
//        int i = mapper.Selectridbyuid("12321135");
//        List<Site> sites = siteMapper.SelectAllSite();
//        System.out.println(sites);
//        String s = siteMapper.Selectsname(1);
//        System.out.println(
//               s
//        );
//        siteMapper.UpdateSites(new Site(1,"一号场地",2,"t"));
//        java.text.SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
//        String s= "2011-07-09 ";
//        Date date =  formatter.parse(s);
//        Date stardate = formatter.parse("2020-09-02");
//        Date enddate = formatter.parse("2019-09-03");
//        System.out.println("stardate------------->"+stardate);
//        System.out.println("enddate------------->"+enddate);
//        cpnMapper.Insertcpn(new Competition(stardate,enddate,"汤尤杯"," ","奥胡斯"));
//        cpnMapper.DelAll();
//        Integer integer = cpnMapper.SelectFirst();
//        System.out.println(integer);
//        List<Competition> list = cpnMapper.FindDays("2020-2-11");
//        Competition competition = cpnMapper.FindNearly("2020-4-20");
//        Date startime = competition.getStartime();
//        List<Competition> list = cpnMapper.FindStar(competition.getStartime());
//        System.out.println(list.size());
//        List<Sites> sites = siteMapper.SelectAllSite(null);
//        System.out.println(sites);
//        List<Community> list = infoMapper.selectByExampleWithStu(null);
//        System.out.println(list);
//        Integer integer = toptionMapper.SelectByInterval("6-7");
//        System.out.println(integer);
//        siteMapper.OpenSite(1,3);
//        Integer integer = siteMapper.SelectTime(3);
//        System.out.println(integer);
//        System.out.println(roleMapper.SelectMo(2));
//        Integer rid = loginService.Rid("123");
//        System.out.println(rid);
//        Integer integer = toptionMapper.SelectTime(2);
//        System.out.println(integer);
//        Date date = new Date();
//        java.text.SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
//        String s = formatter.format(date);
    }

    @Test
    public void test2() {
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = df.format(day);
        System.out.println(format);
        String s = format.replaceAll("[ :-]", "");
        System.out.println(s);
    }
}
