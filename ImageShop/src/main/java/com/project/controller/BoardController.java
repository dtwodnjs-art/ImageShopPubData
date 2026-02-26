package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.common.security.domain.CustomUser;
import com.project.domain.Board;
import com.project.domain.Member;
import com.project.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService service;

	// 게시글 등록 페이지
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public void registerForm(Model model, Authentication authentication) throws Exception {
		// 로그인한 사용자 정보 획득
		User user = (User) authentication.getPrincipal();
		CustomUser customUser = (CustomUser) user;
		Member member = customUser.getMember();

		Board board = new Board();
		// 로그인한 사용자 아이디를 등록 페이지에 표시
		board.setWriter(member.getUserId());

		model.addAttribute(board);
	}

	// 게시글 등록 처리
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String register(Board board, RedirectAttributes rttr) throws Exception {

		int count = service.register(board);
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/board/list";
	}

	// 게시글 목록 페이지
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		model.addAttribute("list", service.list());
	}

	// 게시글 상세 페이지
	@GetMapping("/read")
	public void read(int boardNo, Model model) throws Exception {
		model.addAttribute(service.read(boardNo));
	}

	// 게시글 수정 페이지
	@GetMapping("/modify")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public void modifyForm(int boardNo, Model model) throws Exception {
		model.addAttribute(service.read(boardNo));
	}

	// 게시글 수정 처리
	@PostMapping("/modify")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String modify(Board board, RedirectAttributes rttr) throws Exception {
		int count = service.modify(board);
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}

		return "redirect:/board/list";
	}

	// 게시글 삭제 처리
	@GetMapping("/remove")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String remove(Board board, RedirectAttributes rttr) throws Exception {
		int count=service.remove(board);
		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		
		return "redirect:/board/list";
	}

}
