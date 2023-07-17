package com.mega.blog.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String dashboard(Model model, Criteria cri, @RequestParam Map<String, Object> paramMap) {
		String searchKey = (String) paramMap.get("searchKey");
		String sname = (String) paramMap.get("sname");
		
		List<BoardVO> result = boardService.getBoardList(cri,paramMap);
		System.out.println(paramMap);

//		ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result); 
		PageMaker pageMaker = new PageMaker();

		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.countBoardList(paramMap));
		int getPage;
		getPage = cri.getPage();
//		System.out.println(getPage);
//		System.out.println(pageMaker.getTotalCount());
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("result", result);
		model.addAttribute("getPage", getPage);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("sname", sname);


		return "Login/dashboard"; 
	}
	
//	게시판 메인화면
	@RequestMapping("Login/dashBoardSearch")
	public String  dashBoardSearch(Model model, Criteria cri, @RequestParam Map<String, Object> paramMap) {
		
		List<BoardVO> result = boardService.getBoardList(cri,paramMap);
//		System.out.println(result);

//		ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result); 
		PageMaker pageMaker = new PageMaker();

		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.countBoardList(paramMap));
		int set;
		
		int getPage;
		
		
		getPage = cri.getPage();
		
		System.out.println(paramMap);
		
		System.out.println(pageMaker.getTotalCount());
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("result", result);
		model.addAttribute("getPage", getPage);

		return "Login/dashBoardList";
		
	} 
	
//	게시판 메인화면
	@RequestMapping("Login/paging")
	public String  paging(Model model, Criteria cri, @RequestParam Map<String, Object> paramMap) {
		String searchKey = (String) paramMap.get("searchKey");
		String sname = (String) paramMap.get("sname");
		
		List<BoardVO> result = boardService.getBoardList(cri,paramMap);
//		System.out.println(result); 
		
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result); 
		PageMaker pageMaker = new PageMaker();

		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.countBoardList(paramMap));
		int set;
		
		int getPage;
		getPage = cri.getPage();
		
//		System.out.println(paramMap);
		
//		System.out.println(pageMaker.getTotalCount());
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("result", result);
		model.addAttribute("getPage", getPage);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("sname", sname);

		return "Login/paging";
		
	} 
		

	
	
	
//	글쓰기 페이지
	@RequestMapping("Login/boardwrite")
	public String boardwrite() {

		return "Login/boardwrite";
	}

//	글쓰기 insert
//	 @RequestParam("file") MultipartFile[] file
	@RequestMapping(value = "/Login/boardinsert", method = RequestMethod.POST)
	@ResponseBody
	public int boardinsert(BoardVO board,MultipartFile[] file) throws Exception {
	    int result = 0;
	  
	    // 글쓰기 로직
	    result = boardService.boardwrite(board,file);
	    // paramMap을 출력하거나 사용할 수도 있습니다. 
	    System.out.println("board : " + board);
	     
	    System.out.println(file.length);
	    for(int i=0; i<file.length; i++) {
	        System.out.println("================== file start ==================");
	        System.out.println("파일 이름: "+file[i].getName());
	        System.out.println("파일 실제 이름: "+file[i].getOriginalFilename());
	        System.out.println("파일 크기: "+file[i].getSize());
	        System.out.println("content type: "+file[i].getContentType());
	        System.out.println("================== file   END ==================");

	    }         
             
           
	    // 파일 업로드 처리 로직
	                   
	    return result;
	}
 

	
//	글보기
	@RequestMapping("Login/boardDetail")
	public String boardDetail(int id, Criteria cri, Model model) {
//		조회수 ++
		boardService.viewsUpdate(id);
//		글내용 가져오기
		 Map<String, Object> result = boardService.getBoardDetail(id);

		model.addAttribute("result", result.get("board"));
		model.addAttribute("file", result.get("file"));
		
		    
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		model.addAttribute("pageMaker", pageMaker);
		// ModelAndView mav = new ModelAndView();
//		mav.addObject("result",result);
		System.out.println(result);  
		return "Login/boardDetail";
	}
 
//	글수정 페이지
	@RequestMapping("Login/boardModify")
	
	public String boardModify(int id, Criteria cri, Model model) {
		Map<String, Object> result = boardService.getBoardDetail(id);
		System.out.println(result.get("board"));
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		model.addAttribute("pageMaker", pageMaker);
		
		model.addAttribute("result", result.get("board"));
		model.addAttribute("file", result.get("file")); 

		return "Login/boardModify"; 
	}

//	글수정 update
	@RequestMapping("Login/updateBoard")
	@ResponseBody
	public int upadateBoard(BoardVO board,MultipartFile[] file) throws Exception{
		System.out.println("board: "+board);
		
		int result = 0;
		result = boardService.updateBoard(board, file); 
		return result;
	}

//	글삭제  
	@RequestMapping(value = "Login/deleteBoard")
	@ResponseBody
	public int deleteBoard(int id, Criteria cri, RedirectAttributes redAttr, Model model) {
		int result = 0;
//		글쓰기
		result = boardService.deleteBoard(id);
		

		redAttr.addAttribute("page", cri.getPage());
		redAttr.addAttribute("perPagNum", cri.getPerPageNum());
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
	public int login(MembersVO members, HttpSession session) {
		int result = 0;
		String col = null;
		col = "userId";
		System.out.println(members);
		MembersVO userIdCheck = userService.getUserOne(members.getUserId(), col);
		if (userIdCheck == null) {
			result = 2;
		} else {

			if (members.getUserId().equals(userIdCheck.getUserId())) {
				// ID OK
				if (members.getPassword().equals(userIdCheck.getPassword())) {
					// PW OK
					session.setAttribute("loginUser", userIdCheck);

					result = 3;
				} else {
					result = 2;
				}

			} else {
				// ID not OK
				result = 2;
			}
		}

		return result;
	}

//	회원가입
	@RequestMapping(value = "Login/signUp", method = RequestMethod.POST)
	@ResponseBody
	public int signUp(MembersVO members) {
		int result = 0;
		String col = "";

		col = "userId";
		System.out.println(members);

		MembersVO userIdCheck = userService.getUserOne(members.getUserId(), col);

		if (userIdCheck != null) {
			result = 2;
		}

		col = "nickname";
		MembersVO userNicknameCheck = userService.getUserOne(members.getNickname(), col);
		if (userNicknameCheck != null) {
			result = 3;
		}

		if (result < 2) {

			result = userService.userJoin(members);
		}

		return result;
	}

}
