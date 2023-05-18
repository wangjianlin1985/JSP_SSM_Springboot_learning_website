package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Video {
    /*视频id*/
    private Integer videoId;
    public Integer getVideoId(){
        return videoId;
    }
    public void setVideoId(Integer videoId){
        this.videoId = videoId;
    }

    /*知识分类*/
    private InfoClass infoClassObj;
    public InfoClass getInfoClassObj() {
        return infoClassObj;
    }
    public void setInfoClassObj(InfoClass infoClassObj) {
        this.infoClassObj = infoClassObj;
    }

    /*视频标题*/
    @NotEmpty(message="视频标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*视频图片*/
    private String videoPhoto;
    public String getVideoPhoto() {
        return videoPhoto;
    }
    public void setVideoPhoto(String videoPhoto) {
        this.videoPhoto = videoPhoto;
    }

    /*视频介绍*/
    @NotEmpty(message="视频介绍不能为空")
    private String videoDesc;
    public String getVideoDesc() {
        return videoDesc;
    }
    public void setVideoDesc(String videoDesc) {
        this.videoDesc = videoDesc;
    }

    /*视频文件*/
    private String videoFile;
    public String getVideoFile() {
        return videoFile;
    }
    public void setVideoFile(String videoFile) {
        this.videoFile = videoFile;
    }

    /*点击率*/
    @NotNull(message="必须输入点击率")
    private Integer hitNum;
    public Integer getHitNum() {
        return hitNum;
    }
    public void setHitNum(Integer hitNum) {
        this.hitNum = hitNum;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonVideo=new JSONObject(); 
		jsonVideo.accumulate("videoId", this.getVideoId());
		jsonVideo.accumulate("infoClassObj", this.getInfoClassObj().getInfoClassName());
		jsonVideo.accumulate("infoClassObjPri", this.getInfoClassObj().getInfoClassId());
		jsonVideo.accumulate("title", this.getTitle());
		jsonVideo.accumulate("videoPhoto", this.getVideoPhoto());
		jsonVideo.accumulate("videoDesc", this.getVideoDesc());
		jsonVideo.accumulate("videoFile", this.getVideoFile());
		jsonVideo.accumulate("hitNum", this.getHitNum());
		jsonVideo.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonVideo;
    }}