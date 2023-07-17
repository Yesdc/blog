package com.mega.blog.common;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
 
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.mega.blog.vo.BoardVO;
 
@Component
public class FileUtils {
     
	
	  private Log log = LogFactory.getLog(this.getClass());
	
    @Resource(name="uploadPath")
    String uploadPath;
 
    public List<Map<String, Object>> parseFileInfo(BoardVO board, MultipartFile[] file) throws Exception {
    	
        String boardIDX = String.valueOf(board.getId());
      
        List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
 
        File target = new File(uploadPath);
        if(!target.exists()) target.mkdirs();
        
        for(int i=0; i<file.length; i++) {
 
            String orgFileName = file[i].getOriginalFilename();
            String orgFileExtension = orgFileName.substring(orgFileName.lastIndexOf("."));
            String saveFileName = UUID.randomUUID().toString().replaceAll("-", "") + orgFileExtension;
            Long saveFileSize = file[i].getSize();
            
            log.debug("================== file start ==================");
            log.debug("파일 실제 이름: "+orgFileName);
            log.debug("파일 저장 이름: "+saveFileName);
            log.debug("파일 크기: "+saveFileSize);
            log.debug("content type: "+file[i].getContentType());
            log.debug("================== file   END ==================");
 
            target = new File(uploadPath, saveFileName);
            file[i].transferTo(target); 
            
            Map<String, Object> fileInfo = new HashMap<String, Object>();
 
            fileInfo.put("BOARD_IDX", boardIDX);
            fileInfo.put("ORG_FILE_NAME", orgFileName);
            fileInfo.put("SAVE_FILE_NAME", saveFileName);
            fileInfo.put("FILE_SIZE", saveFileSize);
  
            fileList.add(fileInfo);
            
        }
        return fileList;
    }
}