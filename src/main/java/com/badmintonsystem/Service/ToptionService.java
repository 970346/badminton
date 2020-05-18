package com.badmintonsystem.Service;

import com.badmintonsystem.Bean.Toption;
import com.badmintonsystem.Dao.ToptionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ToptionService {
    @Autowired
    ToptionMapper toptionMapper;

    public Toption SelectId(String time){
        return toptionMapper.SelectByInterval(time);
    }

    public Integer SelectTime(Integer id){ return toptionMapper.SelectTime(id);}
}
