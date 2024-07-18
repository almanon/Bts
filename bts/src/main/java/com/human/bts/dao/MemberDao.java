package com.human.bts.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.bts.vo.*;

public class MemberDao {
	@Autowired
	SqlSessionTemplate session;
	
	public int getLogin(MemberVO mVO) {
		
		return session.selectOne("mSQL.login", mVO);
	}
	
	
	public int addMemb(MemberVO mVO) {
		return session.insert("mSQL.addMember", mVO);
	}
}
