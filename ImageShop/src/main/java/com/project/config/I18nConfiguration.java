package com.project.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class I18nConfiguration {
	@Bean
	MessageSource messageSource() {
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("message.message");
		return messageSource;
	}

	// 사용자의 언어 설정을 HTTP 세션(Session) 영역에 저장.
	@Bean
	LocaleResolver localeResolver() {
		return new SessionLocaleResolver();
	}
}
