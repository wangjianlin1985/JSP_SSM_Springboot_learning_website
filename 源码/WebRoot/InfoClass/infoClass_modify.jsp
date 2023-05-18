<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/infoClass.css" />
<div id="infoClass_editDiv">
	<form id="infoClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">知识分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="infoClass_infoClassId_edit" name="infoClass.infoClassId" value="<%=request.getParameter("infoClassId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="infoClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/InfoClass/js/infoClass_modify.js"></script> 
