package com.human.bts.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.bts.dao.*;
import com.human.bts.util.PageUtil;
import com.human.bts.vo.GameVO;
import com.human.bts.vo.MemberVO;

@Controller
public class MainController {
	
	@Autowired
	MemberDao mDao;
	
	@Autowired
	GameDao gmDao;
	
	
	
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
	
	@RequestMapping("/load.bts")
	public String goLoad() {
		
		return "load";
	}
	
	
	
	@RequestMapping("/gamelist.bts")
	public ModelAndView goGmList(HttpSession session, ModelAndView mv, RedirectView rv, PageUtil page) {
		
		
		int nowPage = page.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		
		// 총게시글 갯수 셋팅
		int totalCnt = gmDao.getTotal();
		page.setPage(nowPage, totalCnt);
		mv.addObject("PAGE", page);
		List<GameVO> list = gmDao.getGmList(page);
		mv.addObject("GMLIST", list);
		mv.setViewName("gameList");
		return mv;
	}
	
	@RequestMapping("/detail.bts")
	public ModelAndView showGraph(HttpSession session, ModelAndView mv, RedirectView rv,GameVO gmVO) {
        
		mv.addObject("DATA", gmVO);
		mv.setViewName("detailPassenger");
        return mv;
    }
	
	@RequestMapping("/loadjs.bts")
	public ModelAndView goLoadToJs(HttpSession session, ModelAndView mv, RedirectView rv,GameVO gmVO) {
		
		mv.addObject("DATA", gmVO);
		mv.setViewName("loadToJs");
		return mv;
	}
	
	
}
