<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Xiti" %>
<%@ page import="com.chengxusheji.po.InfoClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Xiti> xitiList = (List<Xiti>)request.getAttribute("xitiList");
    //获取所有的infoClassObj信息
    List<InfoClass> infoClassList = (List<InfoClass>)request.getAttribute("infoClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    InfoClass infoClassObj = (InfoClass)request.getAttribute("infoClassObj");
    String title = (String)request.getAttribute("title"); //习题标题查询关键字
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>习题查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#xitiListPanel" aria-controls="xitiListPanel" role="tab" data-toggle="tab">习题列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Xiti/xiti_frontAdd.jsp" style="display:none;">添加习题</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="xitiListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>习题id</td><td>知识分类</td><td>习题标题</td><td>分值</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<xitiList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Xiti xiti = xitiList.get(i); //获取到习题对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=xiti.getXitiId() %></td>
 											<td><%=xiti.getInfoClassObj().getInfoClassName() %></td>
 											<td><%=xiti.getTitle() %></td>
 											<td><%=xiti.getScore() %></td>
 											<td><%=xiti.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Xiti/<%=xiti.getXitiId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="xitiEdit('<%=xiti.getXitiId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="xitiDelete('<%=xiti.getXitiId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>习题查询</h1>
		</div>
		<form name="xitiQueryForm" id="xitiQueryForm" action="<%=basePath %>Xiti/frontlist" class="mar_t15" method="post">
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
				<label for="title">习题标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入习题标题">
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
<div id="xitiEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;习题信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="xitiEditForm" id="xitiEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="xiti_xitiId_edit" class="col-md-3 text-right">习题id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="xiti_xitiId_edit" name="xiti.xitiId" class="form-control" placeholder="请输入习题id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="xiti_infoClassObj_infoClassId_edit" class="col-md-3 text-right">知识分类:</label>
		  	 <div class="col-md-9">
			    <select id="xiti_infoClassObj_infoClassId_edit" name="xiti.infoClassObj.infoClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiti_title_edit" class="col-md-3 text-right">习题标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xiti_title_edit" name="xiti.title" class="form-control" placeholder="请输入习题标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiti_score_edit" class="col-md-3 text-right">分值:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xiti_score_edit" name="xiti.score" class="form-control" placeholder="请输入分值">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiti_content_edit" class="col-md-3 text-right">习题内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="xiti.content" id="xiti_content_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiti_analysis_edit" class="col-md-3 text-right">习题解析:</label>
		  	 <div class="col-md-9">
			 	<textarea name="xiti.analysis" id="xiti_analysis_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiti_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date xiti_addTime_edit col-md-12" data-link-field="xiti_addTime_edit">
                    <input class="form-control" id="xiti_addTime_edit" name="xiti.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#xitiEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxXitiModify();">提交</button>
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
var xiti_content_edit = UE.getEditor('xiti_content_edit'); //习题内容编辑器
var xiti_analysis_edit = UE.getEditor('xiti_analysis_edit'); //习题解析编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.xitiQueryForm.currentPage.value = currentPage;
    document.xitiQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.xitiQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.xitiQueryForm.currentPage.value = pageValue;
    documentxitiQueryForm.submit();
}

/*弹出修改习题界面并初始化数据*/
function xitiEdit(xitiId) {
	$.ajax({
		url :  basePath + "Xiti/" + xitiId + "/update",
		type : "get",
		dataType: "json",
		success : function (xiti, response, status) {
			if (xiti) {
				$("#xiti_xitiId_edit").val(xiti.xitiId);
				$.ajax({
					url: basePath + "InfoClass/listAll",
					type: "get",
					success: function(infoClasss,response,status) { 
						$("#xiti_infoClassObj_infoClassId_edit").empty();
						var html="";
		        		$(infoClasss).each(function(i,infoClass){
		        			html += "<option value='" + infoClass.infoClassId + "'>" + infoClass.infoClassName + "</option>";
		        		});
		        		$("#xiti_infoClassObj_infoClassId_edit").html(html);
		        		$("#xiti_infoClassObj_infoClassId_edit").val(xiti.infoClassObjPri);
					}
				});
				$("#xiti_title_edit").val(xiti.title);
				$("#xiti_score_edit").val(xiti.score);
				xiti_content_edit.setContent(xiti.content, false);
				xiti_analysis_edit.setContent(xiti.analysis, false);
				$("#xiti_addTime_edit").val(xiti.addTime);
				$('#xitiEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除习题信息*/
function xitiDelete(xitiId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Xiti/deletes",
			data : {
				xitiIds : xitiId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#xitiQueryForm").submit();
					//location.href= basePath + "Xiti/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交习题信息表单给服务器端修改*/
function ajaxXitiModify() {
	$.ajax({
		url :  basePath + "Xiti/" + $("#xiti_xitiId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#xitiEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#xitiQueryForm").submit();
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
    $('.xiti_addTime_edit').datetimepicker({
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

