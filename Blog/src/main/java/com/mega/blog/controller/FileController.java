package com.mega.blog.controller;


    
import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.mega.blog.service.FileService;
import com.mega.blog.vo.BoardVO;
 
@Controller
public class FileController {
    
    @Resource(name="uploadPath")
    String uploadPath;
    
    @Resource(name="fileService")
    private FileService fileService;
    
    @RequestMapping(value="/filedownload")
    public void downloadFile(BoardVO boardVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
         
        Map<String, Object> file = fileService.selectFile(boardVO.getIDX());   
         
            String saveFileName = (String)file.get("SAVE_FILE_NAME");
            String originalFileName = (String)file.get("ORG_FILE_NAME");
            
            File downloadFile = new File(uploadPath + saveFileName);
            
            byte fileByte[] = FileUtils.readFileToByteArray(downloadFile);
            
            response.setContentType("application/octet-stream");
            response.setContentLength(fileByte.length);
            
            response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8") +"\";");
            response.setHeader("Content-Transfer-Encoding", "binary");
            
            response.getOutputStream().write(fileByte); 
            response.getOutputStream().flush();
            response.getOutputStream().close();
        
    }
    
}