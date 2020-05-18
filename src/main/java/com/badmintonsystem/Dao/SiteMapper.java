package com.badmintonsystem.Dao;

import com.badmintonsystem.Bean.Sites;
import com.badmintonsystem.Bean.SitesExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SiteMapper {
    List<Sites> SelectAllSite(SitesExample sitesExample);

    //关闭场馆
    void CloseSites();
    void CloseSitess();

    //开启场馆
    void OpenSites();
    void OpenSitess();

    String Selectsname(Integer id);

    //打开单个场地
    void OpenSite(@Param("sid") Integer sid,@Param("time") Integer time);

    //关闭单个场地
    void CloseSite(Integer id);

    //根据id查询time
    Integer SelectTime(Integer id);

}
