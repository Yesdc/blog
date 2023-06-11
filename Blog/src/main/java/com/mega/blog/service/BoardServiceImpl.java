package com.mega.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mega.blog.vo.BoardVO;
import com.mega.blog.vo.Criteria;
import com.mega.blog.dao.*;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;

//	글목록
	@Override
	public List<BoardVO> getBoardList(Criteria cri) {

		return boardDAO.getBoardList(cri);
	}

	// 카운트
	@Override
	public int countBoardList() {
		// TODO Auto-generated method stub
		return boardDAO.countBoardList();
	}

//	글 insert
	@Override
	public int boardwrite(BoardVO board) {
		return boardDAO.boardwrite(board);
	}

//	글내용 가져오기
	@Override
	public BoardVO getBoardDetail(int id) {
		return boardDAO.getBoardDetail(id);
	}

//	조회수++
	@Override
	public void viewsUpdate(int id) {
		boardDAO.viewUpdate(id);
	}

//	삭제
	@Override
	public int deleteBoard(int id) {
		return boardDAO.deleteBoard(id);

	}

}