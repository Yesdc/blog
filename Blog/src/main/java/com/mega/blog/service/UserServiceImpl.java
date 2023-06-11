package com.mega.blog.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mega.blog.dao.UserDAO;
import com.mega.blog.vo.MembersVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;

//	확인
	@Override
	public MembersVO getUserOne(String common,String col) {
		System.out.println("hi");
		return userDAO.getUserOne(common,col);
	}

//	가입
	@Override
	public int userJoin(MembersVO members) {
		return userDAO.userJoin(members);
	}
}
