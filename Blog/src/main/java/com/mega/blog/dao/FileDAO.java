package com.mega.blog.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("fileDao")
public class FileDAO extends BoardDAO{
    
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectFileInfo(int id) {
        return (Map<String, Object>) sqlSession.selectOne("selectFileInfo", id);
    } 
   
} 
        