package com.mega.blog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mega.blog.service.BoardService;
import com.mega.blog.service.UserService;
import com.mega.blog.vo.BoardVO;
import com.mega.blog.vo.Criteria;
import com.mega.blog.vo.MembersVO;
import com.mega.blog.vo.PageMaker;

@Controller
@RequestMapping("Login/*")
public class LoginController {
	@Autowired
	BoardService boardService;
	
	@Autowired
	UserService userService;


	
	
	
	
//	게시판 메인화면
	@RequestMapping("Login/dashboard")
	public String dashboard(Model model, Criteria cri) {
		List<BoardVO> result = boardService.getBoardList(cri);
		System.out.println(result);
		
		
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result); 
		PageMaker pageMaker = new PageMaker();
		
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(boardService.countBoardList());
	    int getPage;
		getPage=cri.getPage();
	
	    model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("result", result);
		model.addAttribute("getPage", getPage);
		
		return "Login/dashboard";
	}
	
	
	
	
	
//	글쓰기 페이지
	@RequestMapping("Login/boardwrite")
	public String boardwrite() {

		return "Login/boardwrite";
	}

//	글쓰기 insert
	@RequestMapping(value = "Login/boardinsert")
	@ResponseBody
	public int boardwrite(BoardVO board) {
		int result = 0;
//		글쓰기
		result = boardService.boardwrite(board);
		return result;
	}

//	글보기
	@RequestMapping("Login/boardDetail")
	public String boardDetail(int id, Model model) {
//		조회수 ++
		boardService.viewsUpdate(id);
//		글내용 가져오기
		BoardVO result = boardService.getBoardDetail(id);
		
		model.addAttribute("result", result);
		
		// ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result);
		System.out.println(result);
		return "Login/boardDetail";
	}
	
	
//	글삭제 
	@RequestMapping(value = "Login/deleteBoard")
	@ResponseBody
	public int deleteBoard(int id) {
		int result = 0;
//		글쓰기
		result = boardService.deleteBoard(id);;
		return result;
	}

	
//	로그인페이지
	@RequestMapping("Login/loginPage")
	public String login() {
		
		return "Login/loginPage";
	}
	
//	회원가입 페이지
	@RequestMapping("Login/signUpPage")
	public String signUp() {
		
		return "Login/signUpPage";
	}
	
//	로그아웃
	@RequestMapping("Login/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "/Login/loginPage";
	}
	
//	로그인                              
	@RequestMapping("Login/login")
	@ResponseBody
	public int login(MembersVO members,HttpSession session) {
		int result = 0; 
		String col = null;
		col = "userId";
		System.out.println(members);
		MembersVO userIdCheck = userService.getUserOne(members.getUserId(),col);
		if(userIdCheck == null) {
			result = 2;
		}else {
		
		if(members.getUserId().equals(userIdCheck.getUserId())) {
			//ID OK
			if(members.getPassword().equals(userIdCheck.getPassword())) {
				//PW OK 
				session.setAttribute("loginUser", userIdCheck);

				result = 3;
			}else {
				result = 2;
			}
			
		}else {
			//ID not OK
			result = 2;
		}
		}
		
		return result;
	}
	
//	회원가입
	@RequestMapping(value="Login/signUp",method = RequestMethod.POST)
	@ResponseBody
	public int signUp(MembersVO members) {
		int result = 0; 
		String col = "";
	
		col = "userId";
		System.out.println(members);
		
		
		MembersVO userIdCheck = userService.getUserOne(members.getUserId(),col);
		
		if(userIdCheck != null) {
		result = 2; 
		}
		
		col = "nickname";
		MembersVO userNicknameCheck = userService.getUserOne(members.getNickname(),col);
		if(userNicknameCheck != null) { result = 3; }	
		
		if(result < 2) {
		
		result = userService.userJoin(members);	
		}
		
		
		return result;
	}
	
}
