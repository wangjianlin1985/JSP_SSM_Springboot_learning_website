package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.InfoClass;

import com.chengxusheji.mapper.InfoClassMapper;
@Service
public class InfoClassService {

	@Resource InfoClassMapper infoClassMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加知识分类记录*/
    public void addInfoClass(InfoClass infoClass) throws Exception {
    	infoClassMapper.addInfoClass(infoClass);
    }

    /*按照查询条件分页查询知识分类记录*/
    public ArrayList<InfoClass> queryInfoClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return infoClassMapper.queryInfoClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<InfoClass> queryInfoClass() throws Exception  { 
     	String where = "where 1=1";
    	return infoClassMapper.queryInfoClassList(where);
    }

    /*查询所有知识分类记录*/
    public ArrayList<InfoClass> queryAllInfoClass()  throws Exception {
        return infoClassMapper.queryInfoClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = infoClassMapper.queryInfoClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取知识分类记录*/
    public InfoClass getInfoClass(int infoClassId) throws Exception  {
        InfoClass infoClass = infoClassMapper.getInfoClass(infoClassId);
        return infoClass;
    }

    /*更新知识分类记录*/
    public void updateInfoClass(InfoClass infoClass) throws Exception {
        infoClassMapper.updateInfoClass(infoClass);
    }

    /*删除一条知识分类记录*/
    public void deleteInfoClass (int infoClassId) throws Exception {
        infoClassMapper.deleteInfoClass(infoClassId);
    }

    /*删除多条知识分类信息*/
    public int deleteInfoClasss (String infoClassIds) throws Exception {
    	String _infoClassIds[] = infoClassIds.split(",");
    	for(String _infoClassId: _infoClassIds) {
    		infoClassMapper.deleteInfoClass(Integer.parseInt(_infoClassId));
    	}
    	return _infoClassIds.length;
    }
}
