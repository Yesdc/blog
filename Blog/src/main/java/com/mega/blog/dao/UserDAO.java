package com.mega.blog.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.mega.blog.vo.MembersVO;

@Repository
public class UserDAO {

	@Autowired
	public SqlSession sqlSession;

	public MembersVO getUserOne(String common, String col) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(col.equals("userId")) {
			map.put("userId",common);
		}else if(col.equals("nickname")) {
			map.put("nickname",common);
		}
		return sqlSession.selectOne("getUserOne",map);
	}

	public int userJoin(MembersVO members) {
		return sqlSession.insert("userJoin",members);
	}
	
}