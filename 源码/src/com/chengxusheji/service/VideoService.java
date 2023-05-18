package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.InfoClass;
import com.chengxusheji.po.Video;

import com.chengxusheji.mapper.VideoMapper;
@Service
public class VideoService {

	@Resource VideoMapper videoMapper;
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

    /*添加英语视频记录*/
    public void addVideo(Video video) throws Exception {
    	videoMapper.addVideo(video);
    }

    /*按照查询条件分页查询英语视频记录*/
    public ArrayList<Video> queryVideo(InfoClass infoClassObj,String title,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != infoClassObj && infoClassObj.getInfoClassId()!= null && infoClassObj.getInfoClassId()!= 0)  where += " and t_video.infoClassObj=" + infoClassObj.getInfoClassId();
    	if(!title.equals("")) where = where + " and t_video.title like '%" + title + "%'";
    	if(!addTime.equals("")) where = where + " and t_video.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return videoMapper.queryVideo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Video> queryVideo(InfoClass infoClassObj,String title,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != infoClassObj && infoClassObj.getInfoClassId()!= null && infoClassObj.getInfoClassId()!= 0)  where += " and t_video.infoClassObj=" + infoClassObj.getInfoClassId();
    	if(!title.equals("")) where = where + " and t_video.title like '%" + title + "%'";
    	if(!addTime.equals("")) where = where + " and t_video.addTime like '%" + addTime + "%'";
    	return videoMapper.queryVideoList(where);
    }

    /*查询所有英语视频记录*/
    public ArrayList<Video> queryAllVideo()  throws Exception {
        return videoMapper.queryVideoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(InfoClass infoClassObj,String title,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != infoClassObj && infoClassObj.getInfoClassId()!= null && infoClassObj.getInfoClassId()!= 0)  where += " and t_video.infoClassObj=" + infoClassObj.getInfoClassId();
    	if(!title.equals("")) where = where + " and t_video.title like '%" + title + "%'";
    	if(!addTime.equals("")) where = where + " and t_video.addTime like '%" + addTime + "%'";
        recordNumber = videoMapper.queryVideoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取英语视频记录*/
    public Video getVideo(int videoId) throws Exception  {
        Video video = videoMapper.getVideo(videoId);
        return video;
    }

    /*更新英语视频记录*/
    public void updateVideo(Video video) throws Exception {
        videoMapper.updateVideo(video);
    }

    /*删除一条英语视频记录*/
    public void deleteVideo (int videoId) throws Exception {
        videoMapper.deleteVideo(videoId);
    }

    /*删除多条英语视频信息*/
    public int deleteVideos (String videoIds) throws Exception {
    	String _videoIds[] = videoIds.split(",");
    	for(String _videoId: _videoIds) {
    		videoMapper.deleteVideo(Integer.parseInt(_videoId));
    	}
    	return _videoIds.length;
    }
}
