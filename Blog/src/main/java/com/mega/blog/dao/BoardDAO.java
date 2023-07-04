package com.mega.blog.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mega.blog.vo.BoardVO;
import com.mega.blog.vo.Criteria;

@Repository
public class BoardDAO {
	@Autowired
	public SqlSession sqlSession;

//	글목록
	public List<BoardVO> getBoardList(Criteria cri, Map<String, Object> paramMap) {
		paramMap.put("cri", cri);
		
		return sqlSession.selectList("getBoardList", paramMap);
	}

//	페이징 카운트
	public int countBoardList(Map<String, Object> paramMap) {
		return sqlSession.selectOne("countBoardList",paramMap);
	}

//	글쓰기
	public int boardwrite(BoardVO board) {
		return sqlSession.insert("boardwrite", board);
	}

//	글내용 가져오기
	public BoardVO getBoardDetail(int id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		return sqlSession.selectOne("getBoardDetail", map);
	}

//	조회수++
	public void viewUpdate(int id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		sqlSession.update("viewUpdate", map);
	}
	
	public int deleteBoard(int id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		return sqlSession.delete("deleteBoard", map);
	}
	
//	글수정++
	public int updateBoard(int id, BoardVO board) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("subject", board);
		
		return sqlSession.update("updateBoard", board);
	}
}
