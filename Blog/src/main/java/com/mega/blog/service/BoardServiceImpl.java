package com.mega.blog.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mega.blog.vo.BoardVO;
import com.mega.blog.vo.Criteria;
import com.mega.blog.common.FileUtils;
import com.mega.blog.dao.*;


@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	FileUtils fileUtils;
	
 
//	글목록
	@Override
	public List<BoardVO> getBoardList(Criteria cri, Map<String, Object> paramMap) {

		return boardDAO.getBoardList(cri,paramMap);
	}

	// 카운트
	@Override
	public int countBoardList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return boardDAO.countBoardList(paramMap);
	}

//	글 insert
	@Override
	public int boardwrite(BoardVO board, MultipartFile[] file) throws Exception {
		 int result = boardDAO.boardwrite(board);
		if(!file[0].getName().equals(null)) {
		List<Map<String, Object>> fileList = fileUtils.parseFileInfo(board, file);
	    for(int i=0; i<fileList.size(); i++) {
	        boardDAO.insertFile(fileList.get(i));  
	    }  
		}      
	    return result;     
	}

//	글내용 가져오기
	@Override
	public Map<String, Object> getBoardDetail(int id) {
		
		 BoardVO detail = boardDAO.getBoardDetail(id);
	        List<Map<String, Object>> fileDetail = boardDAO.detailFile(id); 
	  
		Map<String, Object> resultBoard = new HashMap<String, Object>();
		resultBoard.put("board", detail);
        resultBoard.put("file", fileDetail);
   
		return resultBoard;
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

	@Override
	public int updateBoard(BoardVO board, MultipartFile[] file) throws Exception {
		List<Map<String, Object>> fileDetail = boardDAO.detailFile(board.getId());
		   for(int i=0; i<fileDetail.size(); i++) {
		       String idx = (String) fileDetail.get(i).get("IDX"); 
		       if(!board.getIDX().containsKey(idx)) { 
		           Map<String, Object> list = fileDetail.get(i);
		           boardDAO.updateDeleteFile(list);
		       }                     
		   }  
		   List<Map<String, Object>> fileList = fileUtils.parseFileInfo(board, file);
		   for(int i=0; i<fileList.size(); i++) {          
		       boardDAO.insertFile(fileList.get(i)); 
		   }
		   
		return boardDAO.updateBoard(board.getId(), board);
		 
	}

}
