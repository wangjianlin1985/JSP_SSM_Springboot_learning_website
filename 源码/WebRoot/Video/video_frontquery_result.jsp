<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Video" %>
<%@ page import="com.chengxusheji.po.InfoClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Video> videoList = (List<Video>)request.getAttribute("videoList");
    //获取所有的infoClassObj信息
    List<InfoClass> infoClassList = (List<InfoClass>)request.getAttribute("infoClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    InfoClass infoClassObj = (InfoClass)request.getAttribute("infoClassObj");
    String title = (String)request.getAttribute("title"); //视频标题查询关键字
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>英语视频查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Video/frontlist">英语视频信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Video/video_frontAdd.jsp" style="display:none;">添加英语视频</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<videoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Video video = videoList.get(i); //获取到英语视频对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Video/<%=video.getVideoId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=video.getVideoPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field" style="display:none;">
	            		视频id:<%=video.getVideoId() %>
			     	</div>
			     	<div class="field">
	            		知识分类:<%=video.getInfoClassObj().getInfoClassName() %>
			     	</div>
			     	<div class="field">
	            		视频标题:<%=video.getTitle() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		视频文件:<%=video.getVideoFile().equals("")?"暂无文件":"<a href='" + basePath + video.getVideoFile() + "' target='_blank'>" + video.getVideoFile() + "</a>"%>
			     	</div>
			     	<div class="field">
	            		点击率:<%=video.getHitNum() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=video.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Video/<%=video.getVideoId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="videoEdit('<%=video.getVideoId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="videoDelete('<%=video.getVideoId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>英语视频查询</h1>
		</div>
		<form name="videoQueryForm" id="videoQueryForm" action="<%=basePath %>Video/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="infoClassObj_infoClassId">知识分类：</label>
                <select id="infoClassObj_infoClassId" name="infoClassObj.infoClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(InfoClass infoClassTemp:infoClassList) {
	 					String selected = "";
 					if(infoClassObj!=null && infoClassObj.getInfoClassId()!=null && infoClassObj.getInfoClassId().intValue()==infoClassTemp.getInfoClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=infoClassTemp.getInfoClassId() %>" <%=selected %>><%=infoClassTemp.getInfoClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="title">视频标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入视频标题">
			</div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="videoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;英语视频信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="videoEditForm" id="videoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="video_videoId_edit" class="col-md-3 text-right">视频id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="video_videoId_edit" name="video.videoId" class="form-control" placeholder="请输入视频id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="video_infoClassObj_infoClassId_edit" class="col-md-3 text-right">知识分类:</label>
		  	 <div class="col-md-9">
			    <select id="video_infoClassObj_infoClassId_edit" name="video.infoClassObj.infoClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_title_edit" class="col-md-3 text-right">视频标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_title_edit" name="video.title" class="form-control" placeholder="请输入视频标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoPhoto_edit" class="col-md-3 text-right">视频图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="video_videoPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="video_videoPhoto" name="video.videoPhoto"/>
			    <input id="videoPhotoFile" name="videoPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoDesc_edit" class="col-md-3 text-right">视频介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="video.videoDesc" id="video_videoDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_videoFile_edit" class="col-md-3 text-right">视频文件:</label>
		  	 <div class="col-md-9">
			    <a id="video_videoFileA" target="_blank"></a><br/>
			    <input type="hidden" id="video_videoFile" name="video.videoFile"/>
			    <input id="videoFileFile" name="videoFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_hitNum_edit" class="col-md-3 text-right">点击率:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="video_hitNum_edit" name="video.hitNum" class="form-control" placeholder="请输入点击率">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="video_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date video_addTime_edit col-md-12" data-link-field="video_addTime_edit">
                    <input class="form-control" id="video_addTime_edit" name="video.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#videoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxVideoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var video_videoDesc_edit = UE.getEditor('video_videoDesc_edit'); //视频介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.videoQueryForm.currentPage.value = currentPage;
    document.videoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.videoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.videoQueryForm.currentPage.value = pageValue;
    documentvideoQueryForm.submit();
}

/*弹出修改英语视频界面并初始化数据*/
function videoEdit(videoId) {
	$.ajax({
		url :  basePath + "Video/" + videoId + "/update",
		type : "get",
		dataType: "json",
		success : function (video, response, status) {
			if (video) {
				$("#video_videoId_edit").val(video.videoId);
				$.ajax({
					url: basePath + "InfoClass/listAll",
					type: "get",
					success: function(infoClasss,response,status) { 
						$("#video_infoClassObj_infoClassId_edit").empty();
						var html="";
		        		$(infoClasss).each(function(i,infoClass){
		        			html += "<option value='" + infoClass.infoClassId + "'>" + infoClass.infoClassName + "</option>";
		        		});
		        		$("#video_infoClassObj_infoClassId_edit").html(html);
		        		$("#video_infoClassObj_infoClassId_edit").val(video.infoClassObjPri);
					}
				});
				$("#video_title_edit").val(video.title);
				$("#video_videoPhoto").val(video.videoPhoto);
				$("#video_videoPhotoImg").attr("src", basePath +　video.videoPhoto);
				video_videoDesc_edit.setContent(video.videoDesc, false);
				$("#video_videoFile").val(video.videoFile);
				$("#video_videoFileA").text(video.videoFile);
				$("#video_videoFileA").attr("href", basePath +　video.videoFile);
				$("#video_hitNum_edit").val(video.hitNum);
				$("#video_addTime_edit").val(video.addTime);
				$('#videoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除英语视频信息*/
function videoDelete(videoId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Video/deletes",
			data : {
				videoIds : videoId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#videoQueryForm").submit();
					//location.href= basePath + "Video/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交英语视频信息表单给服务器端修改*/
function ajaxVideoModify() {
	$.ajax({
		url :  basePath + "Video/" + $("#video_videoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#videoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#videoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*发布时间组件*/
    $('.video_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

