package com.human.bts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@RequestMapping("/main.bts")
	public String getMain() {
		return "main";
	}
	
	@RequestMapping("/join.bts")
	public String getJoin() {
		return "join";
	}
}
