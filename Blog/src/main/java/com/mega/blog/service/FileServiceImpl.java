package com.mega.blog.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mega.blog.dao.FileDAO;

@Service("fileService")
public class FileServiceImpl implements FileService {
    
    @Resource(name="fileDao")
    private FileDAO fileDao;
 
    @Override
    public Map<String, Object> selectFile(int id) {
        return fileDao.selectFileInfo(id);
    } 
  
} 
