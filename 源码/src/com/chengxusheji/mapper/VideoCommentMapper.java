package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.VideoComment;

public interface VideoCommentMapper {
	/*添加视频评论信息*/
	public void addVideoComment(VideoComment videoComment) throws Exception;

	/*按照查询条件分页查询视频评论记录*/
	public ArrayList<VideoComment> queryVideoComment(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有视频评论记录*/
	public ArrayList<VideoComment> queryVideoCommentList(@Param("where") String where) throws Exception;

	/*按照查询条件的视频评论记录数*/
	public int queryVideoCommentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条视频评论记录*/
	public VideoComment getVideoComment(int commentId) throws Exception;

	/*更新视频评论记录*/
	public void updateVideoComment(VideoComment videoComment) throws Exception;

	/*删除视频评论记录*/
	public void deleteVideoComment(int commentId) throws Exception;

}
