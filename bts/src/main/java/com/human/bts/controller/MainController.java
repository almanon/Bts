package com.human.bts.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.bts.dao.*;
import com.human.bts.vo.MemberVO;

@Controller
public class MainController {
	
	@Autowired
	MemberDao mDao;
	
	
	@RequestMapping("/main.bts")
	public String getMain() {
		return "main";
	}
	
	@RequestMapping("/join.bts")
	public String getJoin() {
		return "join";
	}
	
	@RequestMapping("/loginProc.bts")
	public ModelAndView loginProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		System.out.print(mVO);
		
		String view = "/bts/main.bts";
		
		if(session.getAttribute("SID") != null) {
			rv.setUrl(view);
			mv.setView(rv);
			return mv;
		}
		
		int cnt = mDao.getLogin(mVO);
		
		if(cnt != 1) {
			view = "/bts/main.bts";
		} else {
			session.setAttribute("SID", mVO.getId());
		}
		
		rv.setUrl(view);
		mv.setView(rv);
		return mv;
	}
	
	@RequestMapping("/joinProc.bts")
	public ModelAndView joinProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		
		if(session.getAttribute("SID") != null) {
			rv.setUrl("/bts/main.bts");
			mv.setView(rv);
		} else {
		
		int cnt = mDao.addMemb(mVO);
		if(cnt ==1 ) {
			session.setAttribute("SID", mVO.getId());
			rv.setUrl("/bts/main.bts");
		}else {
			rv.setUrl("/bts/join.bts");
		}
		
		mv.setView(rv);
		}
		return mv;
	}
	
	@RequestMapping("/logout.bts")
	public ModelAndView logout(HttpSession session, ModelAndView mv, RedirectView rv) {
		String view = "/bts/main.bts";
		if(session.getAttribute("SID") != null) {
			session.removeAttribute("SID");
		}
		rv.setUrl(view);
		mv.setView(rv);
		return mv;
	}
}
