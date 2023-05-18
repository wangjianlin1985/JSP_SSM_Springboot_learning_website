package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class InfoClass {
    /*知识分类id*/
    private Integer infoClassId;
    public Integer getInfoClassId(){
        return infoClassId;
    }
    public void setInfoClassId(Integer infoClassId){
        this.infoClassId = infoClassId;
    }

    /*知识分类名称*/
    @NotEmpty(message="知识分类名称不能为空")
    private String infoClassName;
    public String getInfoClassName() {
        return infoClassName;
    }
    public void setInfoClassName(String infoClassName) {
        this.infoClassName = infoClassName;
    }

    /*知识分类说明*/
    private String classDesc;
    public String getClassDesc() {
        return classDesc;
    }
    public void setClassDesc(String classDesc) {
        this.classDesc = classDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonInfoClass=new JSONObject(); 
		jsonInfoClass.accumulate("infoClassId", this.getInfoClassId());
		jsonInfoClass.accumulate("infoClassName", this.getInfoClassName());
		jsonInfoClass.accumulate("classDesc", this.getClassDesc());
		return jsonInfoClass;
    }}