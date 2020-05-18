package com.badmintonsystem.Controller;

import com.badmintonsystem.Bean.Files;
import com.badmintonsystem.Bean.JSONMsg;
import com.badmintonsystem.Service.FilesService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/Files")
public class FilesController {
    @Autowired
    FilesService filesService;
    @Autowired
    HttpServletRequest request;

    /**
     * 查询所有文件
     */
    @RequestMapping("/ShowFiles")
    @ResponseBody
    @ApiOperation(value = "分页显示所有文件信息",httpMethod = "get",response = Files.class)
    public JSONMsg GetFiles(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 10);
        List<Files> list = filesService.GetFilesAll();
        PageInfo page = new PageInfo(list, 5);
        return JSONMsg.success().add("pageInfo", page);
    }

    /**
     * 删除文件
     */
    @RequestMapping(value = "/DelFiles/{filename}", method = RequestMethod.DELETE)
    @ResponseBody
    @ApiOperation(value = "删除文件信息",httpMethod = "delete",response = Files.class)
    public JSONMsg DelFiles(@PathVariable("filename") String filename) {
        if (filename.contains("-")) {
            String[] split = filename.split("-");
            List<String> list = new ArrayList<>();
            for (String str : split) {
                String d=str+".xlsx";
                list.add(d);
            }
            for (String s : list) {
                File files1 = new File(filesService.GetFilesAddress(s));
                files1.delete();
                filesService.DelFiles(s);
            }
        } else {
            String fname = filename + ".xlsx";
            File files1 = new File(filesService.GetFilesAddress(fname));
            files1.delete();
            filesService.DelFiles(fname);
        }
        return JSONMsg.success();
    }
}