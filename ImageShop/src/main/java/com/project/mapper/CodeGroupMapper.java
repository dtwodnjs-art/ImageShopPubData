package com.project.mapper;

import java.util.List;

import com.project.domain.CodeGroup;

public interface CodeGroupMapper {
	// 등록 처리 
	public int create(CodeGroup codeGroup) throws Exception; 
	
	// 목록 페이지 
	public List<CodeGroup> list() throws Exception; 
	
	// 상세 페이지 
	public CodeGroup read(CodeGroup codeGroup) throws Exception;
	
	// 삭제 처리 
	public int remove(CodeGroup codeGroup) throws Exception;
	
	// 수정 처리 
	public int modify(CodeGroup codeGroup) throws Exception;
}
