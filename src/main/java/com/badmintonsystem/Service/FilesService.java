package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.Files;
import com.badmintonsystem.Dao.FilesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FilesService {
    @Autowired
    FilesMapper filesMapper;

    /**
     * 插入文件
     */
    public void SaveFile(Files file){
        filesMapper.InsertFiles(file);
    }

    /**
     * 查询所有文件
     */
    public List<Files> GetFilesAll(){
        return filesMapper.SelectAllFiles();
    }

    /**
     * 删除文件
     */
    public void DelFiles(String fname) {
        filesMapper.DelFiles(fname);
    }
    /**
     * 根据文件名获取文件路径
     */
    public String GetFilesAddress(String fname){
        return filesMapper.SelectFilesByName(fname);
    }
}
