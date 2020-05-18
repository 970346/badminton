package com.badmintonsystem.Utils;


import com.badmintonsystem.Bean.*;
import com.badmintonsystem.Service.InfoService;
import com.badmintonsystem.Service.LoginService;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


public class POI {
    //导入学生信息
    public static List<Student> ReadStu(String filename) throws IOException {
        List<Student> stuList = new ArrayList<>();
        XSSFWorkbook xssfSheets = new XSSFWorkbook(filename);
        XSSFSheet sheet = xssfSheets.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum();
        for (int i = 1; i <= lastRowNum; i++) {
            XSSFRow row = sheet.getRow(i);
            if (row != null) {
                List<String> list = new ArrayList<>();
                for (Cell cell : row) {
                    if (cell != null) {
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        String value = cell.getStringCellValue();
                        if (value != null && !"".equals(value)) {
                            list.add(value);
                        }
                    }
                }
                if (list.size() > 0) {
                    Student stu = new Student(list.get(0), list.get(1));
                    stuList.add(stu);
                }
            }
        }
        return stuList;
    }

    //导入教师信息
    public static List<Teacher> ReadTea(String filename) throws IOException {
        List<Teacher> teacherList = new ArrayList<>();
        XSSFWorkbook xssfSheets = new XSSFWorkbook(filename);
        XSSFSheet sheet = xssfSheets.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum();
        for (int i = 1; i <= lastRowNum; i++) {
            XSSFRow row = sheet.getRow(i);
            if (row != null) {
                List<String> list = new ArrayList<>();
                for (Cell cell : row) {
                    if (cell != null) {
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        String value = cell.getStringCellValue();
                        if (value != null && !"".equals(value)) {
                            list.add(value);
                        }
                    }
                }
                if (list.size() > 0) {
                    Teacher teacher = new Teacher(list.get(0), list.get(1));
                    teacherList.add(teacher);
                }
            }
        }
        return teacherList;
    }

    /**
     * 导入社团信息
     */
    public static List<Community> ReadCom(String filename) throws IOException {
        List<Community> communities = new ArrayList<>();
        XSSFWorkbook xssfSheets = new XSSFWorkbook(filename);
        XSSFSheet sheet = xssfSheets.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum();
        for (int i = 1; i <= lastRowNum; i++) {
            XSSFRow row = sheet.getRow(i);
            if (row != null) {
                List<String> list = new ArrayList<>();
                for (Cell cell : row) {
                    if (cell != null) {
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        String value = cell.getStringCellValue();
                        if (value != null && !"".equals(value)) {
                            list.add(value);
                        }
                    }
                }
                if (list.size() > 0) {
                    Community community = new Community(list.get(1), list.get(2));
                    communities.add(community);
                }
            }
        }
        return communities;
    }

    /**
     * 导入赛事信息
     */
    public static List<Competition> ReadCpn(String filename) throws IOException, ParseException {
        List<Competition> competitionList = new ArrayList<>();
        XSSFWorkbook xssfSheets = new XSSFWorkbook(filename);
        XSSFSheet sheet = xssfSheets.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum();
        for (int i = 1; i <= lastRowNum; i++) {
            XSSFRow row = sheet.getRow(i);
            Competition competition=new Competition();
            Iterator<Cell> iterator = row.cellIterator();
            while (iterator.hasNext()){
                Cell cell = iterator.next();
                if (cell.getColumnIndex()==1){
                    Date date = cell.getDateCellValue();
                    competition.setStartime(date);
                }
                if (cell.getColumnIndex()==2){
                    Date date = cell.getDateCellValue();
                    competition.setEndtime(date);
                }
                if (cell.getColumnIndex()==3){
                    cell.setCellType(Cell.CELL_TYPE_STRING);
                    competition.setCpnname(cell.getStringCellValue());
                }
                if (cell.getColumnIndex()==4){
                    cell.setCellType(Cell.CELL_TYPE_STRING);
                    competition.setCpngrade(cell.getStringCellValue());
                }
                if (cell.getColumnIndex()==5){
                    cell.setCellType(Cell.CELL_TYPE_STRING);
                    competition.setCpnaddress(cell.getStringCellValue());
                }
            }
            competitionList.add(competition);
        }
        return competitionList;
    }
    /**
     * 导出每日订单
     */
    public static void OutOrderList(List<Order> OrderList,HttpServletResponse response) throws IOException{
        response.setCharacterEncoding("UTF-8");
        HSSFWorkbook xssfSheets = new HSSFWorkbook();
        HSSFSheet sheet = xssfSheets.createSheet("sheet1");
        HSSFRow row = sheet.createRow(0);
        row.createCell(0).setCellValue("序号");
        row.createCell(1).setCellValue("用户账号");
        row.createCell(2).setCellValue("场地号");
        row.createCell(3).setCellValue("订场时长");
        row.createCell(4).setCellValue("订场区间");
        row.createCell(5).setCellValue("羽毛球拍");
        row.createCell(6).setCellValue("羽毛球");
        row.createCell(7).setCellValue("状态");
        for (int i=0;i<OrderList.size();i++){
            HSSFRow row1 = sheet.createRow(i+1);
            int j = i+1;
            row1.createCell(0).setCellValue(j);
            row1.createCell(1).setCellValue(OrderList.get(i).getUid());
            row1.createCell(2).setCellValue(OrderList.get(i).getSid());
            row1.createCell(3).setCellValue(OrderList.get(i).getStime());
            row1.createCell(4).setCellValue(OrderList.get(i).getTimenterval());
            row1.createCell(5).setCellValue(OrderList.get(i).getRackets());
            row1.createCell(6).setCellValue(OrderList.get(i).getBalls());
            String ostate = OrderList.get(i).getOstate();
            if (OrderList.get(i).getOstate().equals("t")){
                row1.createCell(7).setCellValue("已生效");
            }else{
                row1.createCell(7).setCellValue("已退款");
            }
        }
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String format = df.format(day);
        response.setContentType("application/octet-stream;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="+format
                + new String("订单".getBytes(),"iso-8859-1") + ".xls");
        OutputStream ouputStream = response.getOutputStream();
        xssfSheets.write(ouputStream);
        ouputStream.flush();
        ouputStream.close();
    }
}