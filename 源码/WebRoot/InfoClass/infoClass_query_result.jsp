<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/infoClass.css" /> 

<div id="infoClass_manage"></div>
<div id="infoClass_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="infoClass_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="infoClass_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="infoClass_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="infoClass_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="infoClass_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="infoClassQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="infoClassEditDiv">
	<form id="infoClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">知识分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="infoClass_infoClassId_edit" name="infoClass.infoClassId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">知识分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="infoClass_infoClassName_edit" name="infoClass.infoClassName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">知识分类说明:</span>
			<span class="inputControl">
				<textarea id="infoClass_classDesc_edit" name="infoClass.classDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="InfoClass/js/infoClass_manage.js"></script> 
