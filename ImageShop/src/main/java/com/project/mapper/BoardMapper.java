package com.project.mapper;

import java.util.List;

import com.project.domain.Board;

public interface BoardMapper {

	public int register(Board board) throws Exception;

	public List<Board> list() throws Exception;

	public Board read(int board) throws Exception;

	public int update(Board board) throws Exception;

	public int remove(Board board) throws Exception;

}
