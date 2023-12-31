package com.mega.blog.vo;
import java.util.Date;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO { 

private int id; 
private String subject; 
private String context; 
private String attachments; 
private int likes;  
private int views; 
private Date create_time; 
private Date update_time;
private String searchKey; 
private String sname;
Map<String, Integer> IDX;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getContext() {
	return context;
}
public void setContext(String context) {
	this.context = context;
}
public String getAttachments() {
	return attachments;
}
public void setAttachments(String attachments) {
	this.attachments = attachments;
}
public int getLikes() {
	return likes;
}
public void setLikes(int likes) {
	this.likes = likes;
}
public int getViews() {
	return views;
}
public void setViews(int views) {
	this.views = views;
}
public Date getCreate_time() {
	return create_time;
}
public void setCreate_time(Date create_time) {
	this.create_time = create_time;
}
public Date getUpdate_time() {
	return update_time;
}
public void setUpdate_time(Date update_time) {
	this.update_time = update_time;
}
public String getSearchKey() {
	return searchKey;
}
public void setSearchKey(String searchKey) {
	this.searchKey = searchKey;
}
public String getSname() {
	return sname;
}
public void setSname(String sname) {
	this.sname = sname;
}
public Map<String, Integer> getIDX() {
	return IDX;
}
public void setIDX(Map<String, Integer> iDX) {
	IDX = iDX;
}
@Override
public String toString() {
	return "BoardVO [id=" + id + ", subject=" + subject + ", context=" + context + ", attachments=" + attachments
			+ ", likes=" + likes + ", views=" + views + ", create_time=" + create_time + ", update_time=" + update_time
			+ ", searchKey=" + searchKey + ", sname=" + sname + ", IDX=" + IDX + "]";
}

  
}