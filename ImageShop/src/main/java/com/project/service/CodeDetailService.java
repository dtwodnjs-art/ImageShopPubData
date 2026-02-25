package com.project.service;

import java.util.List;

import com.project.domain.CodeDetail;

public interface CodeDetailService {
	//코드디테일 등록처리요청 추상메소드 
	public int register(CodeDetail codeDetail) throws Exception;

	//코드디테일 목록페이지요청 
	public List<CodeDetail> list() throws Exception;

	//코드디테일 상세 페이지 
	public CodeDetail read(CodeDetail codeDetail) throws Exception;

	//코드디테일 삭제 처리 
	public int remove(CodeDetail codeDetail) throws Exception;

	//코드디테일 수정 처리 
	public int modify(CodeDetail codeDetail) throws Exception;
	
	
}
