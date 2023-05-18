package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Xiti {
    /*习题id*/
    private Integer xitiId;
    public Integer getXitiId(){
        return xitiId;
    }
    public void setXitiId(Integer xitiId){
        this.xitiId = xitiId;
    }

    /*知识分类*/
    private InfoClass infoClassObj;
    public InfoClass getInfoClassObj() {
        return infoClassObj;
    }
    public void setInfoClassObj(InfoClass infoClassObj) {
        this.infoClassObj = infoClassObj;
    }

    /*习题标题*/
    @NotEmpty(message="习题标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*分值*/
    @NotNull(message="必须输入分值")
    private Float score;
    public Float getScore() {
        return score;
    }
    public void setScore(Float score) {
        this.score = score;
    }

    /*习题内容*/
    @NotEmpty(message="习题内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*习题解析*/
    @NotEmpty(message="习题解析不能为空")
    private String analysis;
    public String getAnalysis() {
        return analysis;
    }
    public void setAnalysis(String analysis) {
        this.analysis = analysis;
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
    	JSONObject jsonXiti=new JSONObject(); 
		jsonXiti.accumulate("xitiId", this.getXitiId());
		jsonXiti.accumulate("infoClassObj", this.getInfoClassObj().getInfoClassName());
		jsonXiti.accumulate("infoClassObjPri", this.getInfoClassObj().getInfoClassId());
		jsonXiti.accumulate("title", this.getTitle());
		jsonXiti.accumulate("score", this.getScore());
		jsonXiti.accumulate("content", this.getContent());
		jsonXiti.accumulate("analysis", this.getAnalysis());
		jsonXiti.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonXiti;
    }}