package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Video;

public interface VideoMapper {
	/*添加英语视频信息*/
	public void addVideo(Video video) throws Exception;

	/*按照查询条件分页查询英语视频记录*/
	public ArrayList<Video> queryVideo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有英语视频记录*/
	public ArrayList<Video> queryVideoList(@Param("where") String where) throws Exception;

	/*按照查询条件的英语视频记录数*/
	public int queryVideoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条英语视频记录*/
	public Video getVideo(int videoId) throws Exception;

	/*更新英语视频记录*/
	public void updateVideo(Video video) throws Exception;

	/*删除英语视频记录*/
	public void deleteVideo(int videoId) throws Exception;

}
