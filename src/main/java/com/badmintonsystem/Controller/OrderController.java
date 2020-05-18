package com.badmintonsystem.Controller;

import com.badmintonsystem.Bean.JSONMsg;
import com.badmintonsystem.Bean.Order;
import com.badmintonsystem.Bean.Toption;
import com.badmintonsystem.Service.IncomeService;
import com.badmintonsystem.Service.OrderService;
import com.badmintonsystem.Service.SiteService;
import com.badmintonsystem.Service.ToptionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiOperation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/Orders")
public class OrderController {
    @Autowired
    ToptionService toptionService;
    @Autowired
    SiteService siteService;
    @Autowired
    OrderService orderService;
    @Autowired
    IncomeService incomeService;
    /**
     * 后台查询所有订单
     */
    @RequestMapping("/ShowFiles")
    @ResponseBody
    @ApiOperation(value = "后台分页显示所有订单信息",httpMethod = "get",response = Order.class)
    public JSONMsg GetFiles(@RequestParam(value = "pn", defaultValue = "1") Integer pn, @RequestParam("month") String month, @RequestParam("info") String orderinfo) {
        PageHelper.startPage(pn, 10);
        List<Order> list = new ArrayList<Order>();
        if (orderinfo==""){
            list = orderService.SelectThisMonth(month);
        }else{
            list = orderService.SelectLikeOrders(orderinfo);
        }
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page);
    }
    /**
     * 查询个人账单
     */
    @RequestMapping(value = "/PersonalOrders",method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "后台分页显示个人所有订单信息",httpMethod = "get",response = Order.class)
    public JSONMsg GetPersonalFiles(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpSession session) {
        String uid = (String) session.getAttribute("uid");
        PageHelper.startPage(pn, 10);
        List<Order> list = orderService.GetAllOrdersByUid(uid);
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pagepersonalInfo", page);
    }
    /**
     * 取消订单
     */
    @RequestMapping(value = "/PersonalOrders",method = RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(value = "用户取消订单",httpMethod = "PUT",response = Order.class)
    public JSONMsg UpdateOrdes(
            @RequestParam("id") String id,
            @RequestParam("state") String state
            ){
        Order orders = orderService.GetAllOrdersByOrid(id);
        //计算违约金
        double penal_sum=orders.getStprice();
        if (state.equals("t")){
            Integer stprice = orders.getStprice();
            penal_sum = stprice * 0.95;
        }
        //查询当前场地的营业时间对应的id
        Integer getTime = siteService.GetTime(orders.getSid());
        Toption toption = toptionService.SelectId(orders.getTimenterval());
        Integer ids=0;
        if (getTime==8){
            ids=getTime-toption.getId();
        }else{
            ids=getTime+toption.getId();
        }
        siteService.OpenSite(orders.getSid(),ids);
        orderService.UpdateOrder(id);
        incomeService.UpdateMoney(-penal_sum);
        incomeService.UpdateTime(-orders.getStime());
        return JSONMsg.success();
    }
    /**
     * 查询今日订单
     */
    @RequestMapping("/SelectToday")
    @ResponseBody
    @ApiOperation(value = "后台分页显示今日所有订单信息",httpMethod = "get",response = Order.class)
    public JSONMsg SelectNowDaysOrders(@RequestParam(value = "BDPagepn", defaultValue = "1") Integer BNDPpn) {
        PageHelper.startPage(BNDPpn, 10);
        List<Order> ABNDOList = orderService.SelectAllToday();
        PageInfo ABNDOPageinfo = new PageInfo(ABNDOList, 5);
        return JSONMsg.success().add("ABNDOrders", ABNDOPageinfo);
    }


    /**
     *  订单退款
     */
    @RequestMapping("/refund")
    @ResponseBody
    @ApiOperation(value = "后台订单退款",httpMethod = "PUT",response = Order.class)
    public JSONMsg UpdateTOrdes(@RequestParam("orid") String id){
        //更改订单状态
        Order order = orderService.GetAllOrdersByOrid(id);
        orderService.UpdateOrder(id);
        //更新场地信息
        Toption toption = toptionService.SelectId(order.getTimenterval());
        Integer getTime = siteService.GetTime(order.getSid());
        Integer ids=0;
        if (getTime==8){
            ids=getTime-toption.getId();
        }else{
            ids=getTime+toption.getId();
        }
        siteService.OpenSite(order.getSid(),ids);
        incomeService.UpdateTime(-order.getStime());
        incomeService.UpdateMoney(-Double.valueOf(order.getTlprice()));
        return JSONMsg.success();
    }
    /**
     * 导出今日订单
     */
    @RequestMapping("/save")
    @ApiOperation(value = "导出今日订单")
    public void save(HttpServletResponse response) throws IOException {
        orderService.OutputToday(response);
    }
    /**
     * 获取月份
     */
    @RequestMapping("/GetMonth")
    @ResponseBody
    public void GetMonth(@RequestParam("month") String month,HttpSession session) {
        System.out.println(month);
        session.setAttribute("month",month);
    }
    /**
     * 导出月订单 monthsave
     */
    @RequestMapping(value = "/monthsave",method = RequestMethod.GET)
    @ApiOperation(value = "导出月订单",httpMethod = "get",response = Order.class)
    public void monthsave(HttpServletResponse response, HttpSession session) throws IOException {
        String month = (String) session.getAttribute("month");
        List<Order> OrderList = orderService.OutputMonth(month);
        HSSFWorkbook xssfSheets = new HSSFWorkbook();
        HSSFSheet sheet = xssfSheets.createSheet("sheet1");
        HSSFRow row = sheet.createRow(0);
        row.createCell(0).setCellValue("订单号");
        row.createCell(1).setCellValue("用户账号");
        row.createCell(2).setCellValue("场地号");
        row.createCell(3).setCellValue("订场时长");
        row.createCell(4).setCellValue("订场区间");
        row.createCell(5).setCellValue("场地费");
        row.createCell(6).setCellValue("商品消费");
        row.createCell(7).setCellValue("日期");
        row.createCell(8).setCellValue("说明");
        row.createCell(9).setCellValue("状态");
        for (int i=0;i<OrderList.size();i++){
            HSSFRow row1 = sheet.createRow(i+1);
            row1.createCell(0).setCellValue(OrderList.get(i).getOrid());
            row1.createCell(1).setCellValue(OrderList.get(i).getUid());
            row1.createCell(2).setCellValue(OrderList.get(i).getSid());
            row1.createCell(3).setCellValue(OrderList.get(i).getStime());
            row1.createCell(4).setCellValue(OrderList.get(i).getTimenterval());
            row1.createCell(5).setCellValue(OrderList.get(i).getStprice());
            row1.createCell(6).setCellValue(OrderList.get(i).getGdprice());
            row1.createCell(7).setCellValue(OrderList.get(i).getOdata());
            row1.createCell(8).setCellValue(OrderList.get(i).getInstructions());
            row1.createCell(9).setCellValue(OrderList.get(i).getOstate());
        }response.setContentType("application/octet-stream;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="
                + new String(month.getBytes(),"iso-8859-1")
                + new String("月订单".getBytes(),"iso-8859-1") + ".xls");
        OutputStream ouputStream = response.getOutputStream();
        xssfSheets.write(ouputStream);
        ouputStream.flush();
        ouputStream.close();
    }
}

