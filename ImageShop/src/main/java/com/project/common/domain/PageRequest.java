package com.project.common.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageRequest {
	// 현재페이지
	private int page;
	// 한페이지당 사이즈
	private int sizePerPage;

	public PageRequest() {
		this.page = 1;
		this.sizePerPage = 10;
	}

	// 현재페이지가 음수이면 1페이지로 셋팅
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	// 한페이지당 사이즈가 음수이거나 100보다 큰 사이즈이면 10으로 셋팅
	public void setSizePerPage(int size) {
		if (size <= 0 || size > 100) {
			this.sizePerPage = 10;
			return;
		}
		this.sizePerPage = size;
	}

	public int getPage() {
		return page;
	}

	// 마이바티스 SQL 매퍼를 위한 메서드 1페이지면 0, 2페이지 10, 3페이지 20
	public int getPageStart() {
		return (this.page - 1) * sizePerPage;
	}

	// 마이바티스 SQL 매퍼를 위한 메서드(한 페이지당 사이즈 10)
	public int getSizePerPage() {
		return this.sizePerPage;
	}

	// 멤버 변수를 활용하여 다양한 형태의 쿼리파라미터를 생성한다.
	// 만약 this.page = 3, this.sizePerPage = 20 이면=> "?page=3&sizePerPage=20"
	public String toUriString() {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", this.page)
				.queryParam("sizePerPage", this.sizePerPage).build();
		return uriComponents.toUriString();
	}

}
