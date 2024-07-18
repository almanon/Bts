package com.human.bts.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.bts.util.PageUtil;
import com.human.bts.vo.GameVO;


public class GameDao {


	@Autowired
	SqlSessionTemplate session;

    public List<GameVO> getGmList(PageUtil page) {
    	
        return session.selectList("gmSQL.getGameList",page);
        
    }
    
	public int getTotal() {
		
		return session.selectOne("gmSQL.getTotal");
	}

}
