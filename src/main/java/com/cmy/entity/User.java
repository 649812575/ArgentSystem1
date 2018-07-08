package com.cmy.entity;

import java.util.Date;

/**
    * user 实体类
    * @author liangzz
    * @date2018-06-24 02:06 
    */ 

public class User{
	 /****/
	private Long id;
	 /****/
	private String userCode;
	 /****/
	private String userName;
	 /****/
	private String userPassword;
	 /****/
	private Long sex;
	 /****/
	private Long age;
	 /****/
	private Date entryDate;
	 /****/
	private Date dismissionDate;
	 /****/
	private String phoneTel;
	 /****/
	private String email;
	 /****/
	private Date creationTime;
	 /****/
	private Date lastLoginTime;
	 /****/
	private String createBy;
	 /****/
	private Date lastUpdatetime;
	 /****/
	private Long userStatus;

	public void setId(Long id){
		this.id=id;
	}

	public Long getId(){
		return id;
	}

	public void setUserCode(String userCode){
		this.userCode=userCode;
	}

	public String getUserCode(){
		return userCode;
	}

	public void setUserName(String userName){
		this.userName=userName;
	}

	public String getUserName(){
		return userName;
	}

	public void setUserPassword(String userPassword){
		this.userPassword=userPassword;
	}

	public String getUserPassword(){
		return userPassword;
	}

	public void setSex(Long sex){
		this.sex=sex;
	}

	public Long getSex(){
		return sex;
	}

	public void setAge(Long age){
		this.age=age;
	}

	public Long getAge(){
		return age;
	}

	public void setEntryDate(Date entryDate){
		this.entryDate=entryDate;
	}

	public Date getEntryDate(){
		return entryDate;
	}

	public void setDismissionDate(Date dismissionDate){
		this.dismissionDate=dismissionDate;
	}

	public Date getDismissionDate(){
		return dismissionDate;
	}

	public void setPhoneTel(String phoneTel){
		this.phoneTel=phoneTel;
	}

	public String getPhoneTel(){
		return phoneTel;
	}

	public void setEmail(String email){
		this.email=email;
	}

	public String getEmail(){
		return email;
	}

	public void setCreationTime(Date creationTime){
		this.creationTime=creationTime;
	}

	public Date getCreationTime(){
		return creationTime;
	}

	public void setLastLoginTime(Date lastLoginTime){
		this.lastLoginTime=lastLoginTime;
	}

	public Date getLastLoginTime(){
		return lastLoginTime;
	}

	public void setCreateBy(String createBy){
		this.createBy=createBy;
	}

	public String getCreateBy(){
		return createBy;
	}

	public void setLastUpdatetime(Date lastUpdatetime){
		this.lastUpdatetime=lastUpdatetime;
	}

	public Date getLastUpdatetime(){
		return lastUpdatetime;
	}

	public void setUserStatus(Long userStatus){
		this.userStatus=userStatus;
	}

	public Long getUserStatus(){
		return userStatus;
	}
}

