package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.Order;
import com.badmintonsystem.Dao.OrderMapper;
import com.badmintonsystem.Utils.POI;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class OrderService {
    @Autowired
    OrderMapper orderMapper;
    /**
     * 插入信息
     */
    public void Add(Order order){
        orderMapper.AddOrder(order);
    }

    /**
     * 查询所有订单信息
     */
    public List<Order> GetAllOrders(){
        return orderMapper.SelectAllOrder();
    }

    /**
     * 查询个人账单
     */
    public List<Order> GetAllOrdersByUid(String uid){
        return orderMapper.SelectAllOrderByUid(uid);
    }
    /**
     * 更新订单信息
     */
    public void UpdateOrder(String id){
        orderMapper.UpdateOrder(id);
    }
    /**
     * 根据订单号查询订单
     */
    public Order GetAllOrdersByOrid(String id){
        return orderMapper.SelectAllOrderByOrid(id);
    }
    /**
     * 查询今日订单
     */
    public List<Order> SelectAllToday(){
        return orderMapper.SelectAllToday();
    }
    /**
     * 查询当月账单
     */
    public List<Order> SelectThisMonth(String month){
        return orderMapper.SelectAnyMonth(month);
    }
    /**
     * 导出今日订单
     */
    public void OutputToday(HttpServletResponse response) throws IOException {
        List<Order> orders = orderMapper.SelectAllToday();
        POI.OutOrderList(orders,response);
    }
    /**
     * 根据uid删除订单信息
     */
    public void delete(String uid){
        orderMapper.Delete(uid);
    }
    /**
     * 导出月订单
     */
    public List<Order> OutputMonth(String month) {
        return orderMapper.SelectAnyMonth(month);
    }

    public List<Order> SelectLikeOrders(String orderinfo) {
        return orderMapper.SelectLikeOrders(orderinfo);
    }
}
