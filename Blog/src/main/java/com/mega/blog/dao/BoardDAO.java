package com.mega.blog.dao;

import java.util.HashMap;
import java.util.List;

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
	public List<BoardVO> getBoardList(Criteria cri) {

		return sqlSession.selectList("getBoardList", cri);
	}

//	페이징 카운트
	public int countBoardList() {
		return sqlSession.selectOne("countBoardList");
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
}
