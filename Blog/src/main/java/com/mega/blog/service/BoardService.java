package com.mega.blog.service;

import java.util.List;

import com.mega.blog.vo.BoardVO;
import com.mega.blog.vo.Criteria;

public interface BoardService {
//	글목록
	List<BoardVO> getBoardList(Criteria cri);
	
	int countBoardList();
	
//	글쓰기 insert
	int boardwrite(BoardVO board);
	
//	글내용 read
	BoardVO getBoardDetail(int id);
	
//	조회수+
	void viewsUpdate(int id);
	
	int deleteBoard(int id);
}
