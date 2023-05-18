package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.VideoCommentService;
import com.chengxusheji.po.VideoComment;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.service.VideoService;
import com.chengxusheji.po.Video;

//VideoComment管理控制层
@Controller
@RequestMapping("/VideoComment")
public class VideoCommentController extends BaseController {

    /*业务层对象*/
    @Resource VideoCommentService videoCommentService;

    @Resource UserInfoService userInfoService;
    @Resource VideoService videoService;
	@InitBinder("videoObj")
	public void initBindervideoObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("videoObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("videoComment")
	public void initBinderVideoComment(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("videoComment.");
	}
	/*跳转到添加VideoComment视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new VideoComment());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		/*查询所有的Video信息*/
		List<Video> videoList = videoService.queryAllVideo();
		request.setAttribute("videoList", videoList);
		return "VideoComment_add";
	}

	/*客户端ajax方式提交添加视频评论信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated VideoComment videoComment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        videoCommentService.addVideoComment(videoComment);
        message = "视频评论添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式提交添加视频评论信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(VideoComment videoComment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		String user_name = (String)session.getAttribute("user_name");
		if(user_name == null) {
			message = "请先登录网站！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(user_name);
		
		videoComment.setUserObj(userObj);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		videoComment.setCommentTime(sdf.format(new java.util.Date()));
		
		 
        videoCommentService.addVideoComment(videoComment);
        message = "视频评论添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	
	/*ajax方式按照查询条件分页查询视频评论信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("videoObj") Video videoObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (commentTime == null) commentTime = "";
		if(rows != 0)videoCommentService.setRows(rows);
		List<VideoComment> videoCommentList = videoCommentService.queryVideoComment(videoObj, userObj, commentTime, page);
	    /*计算总的页数和总的记录数*/
	    videoCommentService.queryTotalPageAndRecordNumber(videoObj, userObj, commentTime);
	    /*获取到总的页码数目*/
	    int totalPage = videoCommentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = videoCommentService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(VideoComment videoComment:videoCommentList) {
			JSONObject jsonVideoComment = videoComment.getJsonObject();
			jsonArray.put(jsonVideoComment);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询视频评论信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<VideoComment> videoCommentList = videoCommentService.queryAllVideoComment();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(VideoComment videoComment:videoCommentList) {
			JSONObject jsonVideoComment = new JSONObject();
			jsonVideoComment.accumulate("commentId", videoComment.getCommentId());
			jsonVideoComment.accumulate("content", videoComment.getContent());
			jsonArray.put(jsonVideoComment);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询视频评论信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("videoObj") Video videoObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (commentTime == null) commentTime = "";
		List<VideoComment> videoCommentList = videoCommentService.queryVideoComment(videoObj, userObj, commentTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    videoCommentService.queryTotalPageAndRecordNumber(videoObj, userObj, commentTime);
	    /*获取到总的页码数目*/
	    int totalPage = videoCommentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = videoCommentService.getRecordNumber();
	    request.setAttribute("videoCommentList",  videoCommentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("videoObj", videoObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("commentTime", commentTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
	    List<Video> videoList = videoService.queryAllVideo();
	    request.setAttribute("videoList", videoList);
		return "VideoComment/videoComment_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询视频评论信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("videoObj") Video videoObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (commentTime == null) commentTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<VideoComment> videoCommentList = videoCommentService.queryVideoComment(videoObj, userObj, commentTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    videoCommentService.queryTotalPageAndRecordNumber(videoObj, userObj, commentTime);
	    /*获取到总的页码数目*/
	    int totalPage = videoCommentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = videoCommentService.getRecordNumber();
	    request.setAttribute("videoCommentList",  videoCommentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("videoObj", videoObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("commentTime", commentTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
	    List<Video> videoList = videoService.queryAllVideo();
	    request.setAttribute("videoList", videoList);
		return "VideoComment/videoComment_userFrontquery_result"; 
	}
	
	

     /*前台查询VideoComment信息*/
	@RequestMapping(value="/{commentId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer commentId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键commentId获取VideoComment对象*/
        VideoComment videoComment = videoCommentService.getVideoComment(commentId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        List<Video> videoList = videoService.queryAllVideo();
        request.setAttribute("videoList", videoList);
        request.setAttribute("videoComment",  videoComment);
        return "VideoComment/videoComment_frontshow";
	}

	/*ajax方式显示视频评论修改jsp视图页*/
	@RequestMapping(value="/{commentId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer commentId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键commentId获取VideoComment对象*/
        VideoComment videoComment = videoCommentService.getVideoComment(commentId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonVideoComment = videoComment.getJsonObject();
		out.println(jsonVideoComment.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新视频评论信息*/
	@RequestMapping(value = "/{commentId}/update", method = RequestMethod.POST)
	public void update(@Validated VideoComment videoComment, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			videoCommentService.updateVideoComment(videoComment);
			message = "视频评论更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "视频评论更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除视频评论信息*/
	@RequestMapping(value="/{commentId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer commentId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  videoCommentService.deleteVideoComment(commentId);
	            request.setAttribute("message", "视频评论删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "视频评论删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条视频评论记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String commentIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = videoCommentService.deleteVideoComments(commentIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出视频评论信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("videoObj") Video videoObj,@ModelAttribute("userObj") UserInfo userObj,String commentTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(commentTime == null) commentTime = "";
        List<VideoComment> videoCommentList = videoCommentService.queryVideoComment(videoObj,userObj,commentTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "VideoComment信息记录"; 
        String[] headers = { "评论id","被评视频","评论内容","评论用户","评论时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<videoCommentList.size();i++) {
        	VideoComment videoComment = videoCommentList.get(i); 
        	dataset.add(new String[]{videoComment.getCommentId() + "",videoComment.getVideoObj().getTitle(),videoComment.getContent(),videoComment.getUserObj().getName(),videoComment.getCommentTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"VideoComment.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
