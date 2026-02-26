package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.Board;
import com.project.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardMapper mapper;

	@Transactional
	@Override
	public int register(Board board) throws Exception {
		return mapper.register(board);
	}

	@Override
	public List<Board> list() throws Exception {
		
		return mapper.list();
	}

	@Override
	public Board read(int board) throws Exception {
		return mapper.read(board);
	}

	@Override
	public int modify(Board board) throws Exception{
		return mapper.update(board);
	}

	@Override
	public int remove(Board board) throws Exception {
		return mapper.remove(board);
	}

}
