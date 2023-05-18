package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Video;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.VideoComment;

import com.chengxusheji.mapper.VideoCommentMapper;
@Service
public class VideoCommentService {

	@Resource VideoCommentMapper videoCommentMapper;
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

    /*添加视频评论记录*/
    public void addVideoComment(VideoComment videoComment) throws Exception {
    	videoCommentMapper.addVideoComment(videoComment);
    }

    /*按照查询条件分页查询视频评论记录*/
    public ArrayList<VideoComment> queryVideoComment(Video videoObj,UserInfo userObj,String commentTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != videoObj && videoObj.getVideoId()!= null && videoObj.getVideoId()!= 0)  where += " and t_videoComment.videoObj=" + videoObj.getVideoId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_videoComment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_videoComment.commentTime like '%" + commentTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return videoCommentMapper.queryVideoComment(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<VideoComment> queryVideoComment(Video videoObj,UserInfo userObj,String commentTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != videoObj && videoObj.getVideoId()!= null && videoObj.getVideoId()!= 0)  where += " and t_videoComment.videoObj=" + videoObj.getVideoId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_videoComment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_videoComment.commentTime like '%" + commentTime + "%'";
    	return videoCommentMapper.queryVideoCommentList(where);
    }

    /*查询所有视频评论记录*/
    public ArrayList<VideoComment> queryAllVideoComment()  throws Exception {
        return videoCommentMapper.queryVideoCommentList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Video videoObj,UserInfo userObj,String commentTime) throws Exception {
     	String where = "where 1=1";
    	if(null != videoObj && videoObj.getVideoId()!= null && videoObj.getVideoId()!= 0)  where += " and t_videoComment.videoObj=" + videoObj.getVideoId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_videoComment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_videoComment.commentTime like '%" + commentTime + "%'";
        recordNumber = videoCommentMapper.queryVideoCommentCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取视频评论记录*/
    public VideoComment getVideoComment(int commentId) throws Exception  {
        VideoComment videoComment = videoCommentMapper.getVideoComment(commentId);
        return videoComment;
    }

    /*更新视频评论记录*/
    public void updateVideoComment(VideoComment videoComment) throws Exception {
        videoCommentMapper.updateVideoComment(videoComment);
    }

    /*删除一条视频评论记录*/
    public void deleteVideoComment (int commentId) throws Exception {
        videoCommentMapper.deleteVideoComment(commentId);
    }

    /*删除多条视频评论信息*/
    public int deleteVideoComments (String commentIds) throws Exception {
    	String _commentIds[] = commentIds.split(",");
    	for(String _commentId: _commentIds) {
    		videoCommentMapper.deleteVideoComment(Integer.parseInt(_commentId));
    	}
    	return _commentIds.length;
    }
}
