package com.mega.blog.service;

import com.mega.blog.vo.MembersVO;


public interface UserService {
	MembersVO getUserOne(String common, String col);

	int userJoin(MembersVO members);
}
