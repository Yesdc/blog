package com.mega.blog.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
    
//	현재 페이지 번호
    private Criteria cri;
//    총 게시글 수
    private int totalCount;
    private int startPage;
    
//    화면에 보여질 마지막 페이지 번호, 끝 페이지 번호
    private int endPage;
    private boolean prev;
    private boolean next;
    private int displayPageNum = 5;
    
    public Criteria getCri() {
        return cri;
    }
    public void setCri(Criteria cri) {
        this.cri = cri;
    }
    public int getTotalCount() {
        return totalCount;
    }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }
    
    private void calcData() {
        
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
 
        startPage = (endPage - displayPageNum) + 1;
        if(startPage <= 0) startPage = 1;
        
        int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }
 
        prev = startPage == 1 ? false : true;
        next = endPage * cri.getPerPageNum() < totalCount ? true : false;
        
    }
    
    public int getStartPage() {
        return startPage;
    }
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
    public int getEndPage() {
        return endPage;
    }
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
    public boolean isPrev() {
        return prev;
    }
    public void setPrev(boolean prev) {
        this.prev = prev;
    }
    public boolean isNext() {
        return next;
    }
    public void setNext(boolean next) {
        this.next = next;
    }
    public int getDisplayPageNum() {
        return displayPageNum;
    }
    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }
    public String makeQueryPage(int page) {
        UriComponents uri = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .build();
        return uri.toUriString();
    }
    
    public String makeQueryPage(int id, int page) {
        UriComponents uri = UriComponentsBuilder.newInstance()
                .queryParam("id", id)
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .build();
        return uri.toUriString();
    }
    public String makeQueryPage(String key, String val, int page) {
        UriComponents uri = UriComponentsBuilder.newInstance()
        		.queryParam("searchKey", key)
                .queryParam("sname", val)
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .build();
        return uri.toUriString();
    }
}
