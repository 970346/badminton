package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.Order;
import com.badmintonsystem.Bean.Sites;
import com.badmintonsystem.Dao.SiteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SiteService {

    @Autowired
    SiteMapper siteMapper;
    @Autowired
    OrderService orderServicel;
    @Autowired
    IncomeService incomeService;

    /**
     * 查所有的场地
     */
    public List<Sites> SelectAllSite() {
        return siteMapper.SelectAllSite(null);
    }

    /**
     * 关闭所有场地
     */
    public void CloseAllSite() {
        siteMapper.CloseSites();
        siteMapper.CloseSitess();
        List<Order> orders = orderServicel.SelectAllToday();
        for (Order s : orders) {
            if (s.getOstate().equals("t")){
//                System.out.println("退款的订单号："+s.getOrid());
                orderServicel.UpdateOrder(s.getOrid());
//                System.out.println("金额-"+s.getTlprice());
                incomeService.UpdateMoney(-Double.valueOf(s.getTlprice()));
//                System.out.println("时间-"+s.getStime());
                incomeService.UpdateTime(-s.getStime());
            }
        }
    }
    /**
     * 自动打开所有场地
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void AutomaticOpenAllSite() {
        siteMapper.OpenSites();
        siteMapper.OpenSitess();
    }
    /**
     * 手动打开所有场地
     */
    public void OpenAllSite() {
        siteMapper.OpenSites();
        siteMapper.OpenSitess();
    }
    /**
     * 通过序号查询场地
     */
    public String Getsname(Integer id){
        return siteMapper.Selectsname(id);
    }
    /**
     * 关闭单个场地
     */
    public void CloseSite(Integer id){
        siteMapper.CloseSite(id);
    }
    /**
     * 打开单个场地
     */
    public void OpenSite(Integer sid,Integer time){
        siteMapper.OpenSite(sid,time);
    }
    /**
     * 返回time
     */
    public Integer GetTime(Integer id){
        return siteMapper.SelectTime(id);
    }
}
