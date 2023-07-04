package com.mega.blog.service;

import java.util.List;
import java.util.Map;

import com.mega.blog.vo.BoardVO;
import com.mega.blog.vo.Criteria;

public interface BoardService {
//	글목록
	List<BoardVO> getBoardList(Criteria cri, Map<String, Object> paramMap);
	
	int countBoardList(Map<String, Object> paramMap);
	
//	글쓰기 insert
	int boardwrite(BoardVO board);
	
//	글내용 read
	BoardVO getBoardDetail(int id);
	
//	조회수+
	void viewsUpdate(int id);
	
	int updateBoard(int id, BoardVO board);
	
	int deleteBoard(int id);
}
