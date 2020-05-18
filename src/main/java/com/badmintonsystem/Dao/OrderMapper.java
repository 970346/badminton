package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Order;

import java.util.List;

public interface OrderMapper {
    //添加信息
    void AddOrder(Order order);
    //查询所有订单
    List<Order> SelectAllOrder();
    //根据uid查询订单
    List<Order> SelectAllOrderByUid(String uid);
    //更新订单
    void UpdateOrder(String id);
    //根据订单号查询订单
    Order SelectAllOrderByOrid(String id);
    //查询今日订单
    List<Order> SelectAllToday();
    //按照月份查询
    List<Order> SelectAnyMonth(String month);
    //根据uid删除信息
    void Delete(String uid);

    List<Order> SelectLikeOrders(String orderinfo);
}
