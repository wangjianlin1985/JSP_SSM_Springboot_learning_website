package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.InfoClass;

public interface InfoClassMapper {
	/*添加知识分类信息*/
	public void addInfoClass(InfoClass infoClass) throws Exception;

	/*按照查询条件分页查询知识分类记录*/
	public ArrayList<InfoClass> queryInfoClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有知识分类记录*/
	public ArrayList<InfoClass> queryInfoClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的知识分类记录数*/
	public int queryInfoClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条知识分类记录*/
	public InfoClass getInfoClass(int infoClassId) throws Exception;

	/*更新知识分类记录*/
	public void updateInfoClass(InfoClass infoClass) throws Exception;

	/*删除知识分类记录*/
	public void deleteInfoClass(int infoClassId) throws Exception;

}
