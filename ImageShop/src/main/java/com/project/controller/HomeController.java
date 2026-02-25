package com.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	@GetMapping("/")
	public String home(Locale locale, Model model) {

		log.info("환영합니다. 지역은 "+ locale);
		Date date = new Date(); 
		//시간날짜형식form
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formatterDate = dateFormat.format(date);

		model.addAttribute("serverTime", formatterDate); 
		return "home"; 
	}

}








