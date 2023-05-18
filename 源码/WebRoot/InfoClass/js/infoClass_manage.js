var infoClass_manage_tool = null; 
$(function () { 
	initInfoClassManageTool(); //建立InfoClass管理对象
	infoClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#infoClass_manage").datagrid({
		url : 'InfoClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "infoClassId",
		sortOrder : "desc",
		toolbar : "#infoClass_manage_tool",
		columns : [[
			{
				field : "infoClassId",
				title : "知识分类id",
				width : 70,
			},
			{
				field : "infoClassName",
				title : "知识分类名称",
				width : 140,
			},
		]],
	});

	$("#infoClassEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#infoClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#infoClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#infoClassEditForm").form({
						    url:"InfoClass/" + $("#infoClass_infoClassId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#infoClassEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#infoClassEditDiv").dialog("close");
			                        infoClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#infoClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#infoClassEditDiv").dialog("close");
				$("#infoClassEditForm").form("reset"); 
			},
		}],
	});
});

function initInfoClassManageTool() {
	infoClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#infoClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#infoClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#infoClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#infoClassQueryForm").form({
			    url:"InfoClass/OutToExcel",
			});
			//提交表单
			$("#infoClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#infoClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var infoClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							infoClassIds.push(rows[i].infoClassId);
						}
						$.ajax({
							type : "POST",
							url : "InfoClass/deletes",
							data : {
								infoClassIds : infoClassIds.join(","),
							},
							beforeSend : function () {
								$("#infoClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#infoClass_manage").datagrid("loaded");
									$("#infoClass_manage").datagrid("load");
									$("#infoClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#infoClass_manage").datagrid("loaded");
									$("#infoClass_manage").datagrid("load");
									$("#infoClass_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#infoClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "InfoClass/" + rows[0].infoClassId +  "/update",
					type : "get",
					data : {
						//infoClassId : rows[0].infoClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (infoClass, response, status) {
						$.messager.progress("close");
						if (infoClass) { 
							$("#infoClassEditDiv").dialog("open");
							$("#infoClass_infoClassId_edit").val(infoClass.infoClassId);
							$("#infoClass_infoClassId_edit").validatebox({
								required : true,
								missingMessage : "请输入知识分类id",
								editable: false
							});
							$("#infoClass_infoClassName_edit").val(infoClass.infoClassName);
							$("#infoClass_infoClassName_edit").validatebox({
								required : true,
								missingMessage : "请输入知识分类名称",
							});
							$("#infoClass_classDesc_edit").val(infoClass.classDesc);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
