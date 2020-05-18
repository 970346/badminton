package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Files;

import java.util.List;

/**
 * 文件操作
 */
public interface FilesMapper {
    //插入文件
    void InsertFiles(Files file);
    //查询所有文件
    List<Files> SelectAllFiles();
    //删除文件
    void DelFiles(String fname);
    //根据文件名查文件地址
    String SelectFilesByName(String fname);
}
