package com.badmintonsystem.Service;

import com.badmintonsystem.Dao.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleService {
    @Autowired
    RoleMapper roleMapper;
    /**
     * 根据rid查询mo
     */
    public Integer SelectMo(Integer id){
        return roleMapper.SelectMo(id);
    }
}
