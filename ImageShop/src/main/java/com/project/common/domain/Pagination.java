package com.project.common.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class Pagination {
	private int totalCount; // 전체 게시글 수
	private int startPage; // 시작 페이지
	private int endPage; // 끝 페이지
	private boolean prev; // 이전글 목록
	private boolean next; // 다음글 목록
	private int displayPageNum = 10; // 보여줄 페이지수
	private PageRequest pageRequest;// 현재페이지,한페이지사이즈(1페이지 10개 보일것)

	public void setPageRequest(PageRequest pageRequest) {
		this.pageRequest = pageRequest;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	private void calcData() {
		// endPage = (ceil(12 / 10)) * 10 => 20page
		// 현재페이지 12페이지이면 시작페이지는 11페이지고 끝페이지는 20페이지 이다.
		endPage = (int) (Math.ceil(pageRequest.getPage() / (double) displayPageNum) * displayPageNum);
		// 시작페이지는 현재페이지가 12페이지이면 끝페이지는 20페이지다
		// 시작페이지는 20페이지 - 10페이지 + 1 계산으로 11페이지이다
		startPage = (endPage - displayPageNum) + 1;
		// 567 / 10(한페이지에 보여질 수) => ceil(56.7) =>57페이지
		int tempEndPage = (int) (Math.ceil(totalCount / (double) pageRequest.getSizePerPage()));
		// 계산된 끝페이지보다 실제 끝페이보다 크면 치환한다.
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		// 현재페이지 12페이지이면 startPage = 11 , endPage=20

		prev = startPage == 1 ? false : true;
		next = endPage * pageRequest.getSizePerPage() >= totalCount ? false : true;
			
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public PageRequest getPageRequest() {
		return pageRequest;
	}

	// 만약 this.page = 3, this.sizePerPage = 20 이면=> "?page=3&sizePerPage=20"
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("sizePerPage", pageRequest.getSizePerPage()).build();
		return uriComponents.toUriString();
	}

}
