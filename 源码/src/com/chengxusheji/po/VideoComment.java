package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class VideoComment {
    /*评论id*/
    private Integer commentId;
    public Integer getCommentId(){
        return commentId;
    }
    public void setCommentId(Integer commentId){
        this.commentId = commentId;
    }

    /*被评视频*/
    private Video videoObj;
    public Video getVideoObj() {
        return videoObj;
    }
    public void setVideoObj(Video videoObj) {
        this.videoObj = videoObj;
    }

    /*评论内容*/
    @NotEmpty(message="评论内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*评论用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*评论时间*/
    private String commentTime;
    public String getCommentTime() {
        return commentTime;
    }
    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonVideoComment=new JSONObject(); 
		jsonVideoComment.accumulate("commentId", this.getCommentId());
		jsonVideoComment.accumulate("videoObj", this.getVideoObj().getTitle());
		jsonVideoComment.accumulate("videoObjPri", this.getVideoObj().getVideoId());
		jsonVideoComment.accumulate("content", this.getContent());
		jsonVideoComment.accumulate("userObj", this.getUserObj().getName());
		jsonVideoComment.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonVideoComment.accumulate("commentTime", this.getCommentTime());
		return jsonVideoComment;
    }}