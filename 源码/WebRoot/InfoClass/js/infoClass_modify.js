$(function () {
	$.ajax({
		url : "InfoClass/" + $("#infoClass_infoClassId_edit").val() + "/update",
		type : "get",
		data : {
			//infoClassId : $("#infoClass_infoClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (infoClass, response, status) {
			$.messager.progress("close");
			if (infoClass) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#infoClassModifyButton").click(function(){ 
		if ($("#infoClassEditForm").form("validate")) {
			$("#infoClassEditForm").form({
			    url:"InfoClass/" +  $("#infoClass_infoClassId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#infoClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
