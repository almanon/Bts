package com.human.bts.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import com.human.bts.vo.FacilityVO;


public class FacilityDao {


	@Autowired
	SqlSessionTemplate session;

    public List<FacilityVO> getFcList() {
        return session.selectList("fcSQL.getAllFacilities");
    }

}
