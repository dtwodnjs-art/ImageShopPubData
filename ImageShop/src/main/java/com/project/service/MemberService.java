package com.project.service;

import java.util.List;

import com.project.domain.Member;

public interface MemberService {

	public int register(Member member) throws Exception;

	public List<Member> list() throws Exception;

	public Member read(Member member) throws Exception;

	public int modify(Member member) throws Exception;

	public int remove(Member member) throws Exception;

	public int countAll() throws Exception;

	public void setupAdmin(Member member) throws Exception;

}
