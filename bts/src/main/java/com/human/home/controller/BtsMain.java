package com.human.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BtsMain {
	@RequestMapping("/")
	public String getMain() {
		return "main";
	}
}
