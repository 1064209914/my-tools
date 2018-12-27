function selectOne(obj) {
	var objCheckBox = document.getElementsByName("checkbox");
//	document.getElementById("checkboxAll").checked = false;
	for ( var i = 0; i < objCheckBox.length; i++) {
		if (objCheckBox[i] != obj) {
			objCheckBox[i].checked = false;
		} else {
			objCheckBox[i].checked = true;
		}
	} 
	document.getElementById("checkboxID").value=obj.value;
};
function selectAll(obj) {
	var check=document.getElementById("checkboxAll").checked;	
		if (check) {
			document.getElementById("checkboxID").value="";
		} 
};
var path = location.pathname.split("/")[1];
var basePath = location.protocol+"//"+location.host+"/"+path;
//首页提醒功能
function callBackfunction(obj) {
	//新增提醒
	if(obj=="add"){ 
		var start_time=$(window.document).find("#workDiary_add_modal input[name='start_time']").val();
		var end_time=$(window.document).find("#workDiary_add_modal input[name='end_time']").val();
		var title = $(window.document).find("#workDiary_add_modal textarea[name='title']").val();
		var className = $(window.document).find("#workDiary_add_modal select[name='className']").val();
		if(title==null||title==""){
			$(window.document).find("#workDiary_add_modal textarea[name='title']").closest("form").find(".help-block").remove();
			$(window.document).find("#workDiary_add_modal textarea[name='title']").after("<div class=\"help-block red\" >&nbsp;&nbsp;*&nbsp;内容为必填项！");
			$(window.document).find("#workDiary_add_modal textarea[name='title']").focus();
			return false;
		}
		var params ={"start":start_time,"end":end_time,"title":title,"className":className };
		  $.ajax({
			type : "POST",
			url : basePath+"/mvc/addWorkDiary.do",
			data : params,
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == "success"){
					var obj = new Object();
					obj.id = data.id;
					obj.title = title.substr(0,3)+"...";
					obj.content = title;
					obj.start = start_time;
					obj.end = end_time;
					if(className==1){
						obj.className ='label-success';
					}else if(className==2){
						obj.className ='label-danger';
					}else{
						obj.className ='label-info';
					}
					$('#calendar').fullCalendar('renderEvent',obj,true);
					hideModal();
				}else{
					hideModal();
					alert("新增提醒失败:"+data.msg);
				}
			},
			error : function(msg) {
				alert("内部异常  " + msg);
			} 
		});
	}else if(obj=="edit"){//维护提醒
		var id=$(window.document).find("#workDiary_edit_modal input[name='id_1']").val();
		var start_time=$(window.document).find("#workDiary_edit_modal input[name='start_time_1']").val();
		var end_time=$(window.document).find("#workDiary_edit_modal input[name='end_time_1']").val();
		var title = $(window.document).find("#workDiary_edit_modal textarea[name='title_1']").val();
		var className = $(window.document).find("#workDiary_edit_modal select[name='className_1']").val();
		if(title==null||title==""){
			$(window.document).find("#workDiary_edit_modal textarea[name='title_1']").closest("form").find(".help-block").remove();
			$(window.document).find("#workDiary_edit_modal textarea[name='title_1']").after("<div class=\"help-block red\" >&nbsp;&nbsp;*&nbsp;内容为必填项！");
			$(window.document).find("#workDiary_edit_modal textarea[name='title_1']").focus();
			return false;
		}
		var params ={"id":id,"start":start_time,"end":end_time,"title":title,"className":className };
		  $.ajax({
			type : "POST",
			url : basePath+"/mvc/editWorkDiary.do",
			data : params,
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == "success"){
					$('#calendar').fullCalendar('removeEvents');
					getWorkDiary();
					hideModal();
				}else{
					hideModal();
					alert("维护提醒失败:"+data.msg);
				}
			},
			error : function(msg) {
				alert("内部异常  " + msg);
			} 
		});
		
	}else if(obj=="delete"){//删除提醒
		var id=$(window.document).find("#workDiary_edit_modal input[name='id_1']").val();
		var params ={"id":id };
		  $.ajax({
			type : "POST",
			url : basePath+"/mvc/deleteWorkDiary.do",
			data : params,
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == "success"){
					$('#calendar').fullCalendar('removeEvents');
					getWorkDiary();
					hideModal();
				}else{
					hideModal();
					alert("删除提醒失败:"+data.msg);
				}
			},
			error : function(msg) {
				alert("内部异常  " + msg);
			} 
		});
	}
}
//获取工作日记
function getWorkDiary() {
	$.ajax({
		type : "POST",
		url : basePath+"/mvc/queryWorkDiary.do",
		async : false,
		dataType:'json',
		success : function(data) {
			$.each(data,function(index,result){
				var obj = new Object();
				obj.id = result.workdiary_id;
				obj.title = result.title.substr(0,3)+"...";
				obj.content = result.title;
				obj.start = $.fullCalendar.parseDate(result.start_time);
				obj.end = $.fullCalendar.parseDate(result.end_time);
				if(result.class_name==1){
					obj.className ='label-success';
				}else if(result.class_name==2){
					obj.className ='label-danger';
				}else{
					obj.className ='label-info';
				}
				$('#calendar').fullCalendar('renderEvent',obj,true);
			});
		},
		error : function(msg) {
			alert("分配出错  " + msg);
		}
	});	
}

//查询公告信息
function getIndustryInfo() {
	$.ajax( {
		type : "POST",
		url : basePath+"/mvc/industry_getList_homePage.do",
		async : false,
		success : function(data) {
			$.each(data,function(index,result) {
				/* var tr = $('<tr></tr>');
				tr.appendTo($("#industry_list_group"));
					var td = $('<td><a onclick="industryView(\''+result.ID+'\')" style="cursor:pointer">'+result.TITLE+'</a></td>');
					td.appendTo(tr);*/						
					
				var tr = $('<div class="profile-activity clearfix"> </div>');
				tr.appendTo($("#industry_list_group"));
					var td = $('<span class="pull-left"><a onclick="industryView(\''+result.industry_id+'\')" style="cursor:pointer">'+result.industry_title+'</a></span>');
					var td1 = $('<span class="pull-right time"><i class="icon-time bigger-110"></i>'+result.start_time+'</span>');
					td.appendTo(tr);
					td1.appendTo(tr);
			});
			setHash('${pageContext.request.contextPath}');
		},
		error: function(msg) {
			alert("分配出错  " + msg);
		}
	});
}

//行业动态信息点击事件
function industryView(id) {
	showModal($("#industry_modal"));
	param={};
	param["id"]=id;
	$.ajax( {
		type : "POST",
		url : basePath+"/mvc/industry_get_homePage.do",
		data : param,
		async : false,
		success : function(obj) {
			$(window.document).find("#industry_modal h4[id='title']").html(obj.title);
			$(window.document).find("#industry_modal div[id='content']").html(obj.content);
		},
		error : function(msg) {
			alert("获取数据失败: " + msg);
		}
	});
}
//跳转页面
function toPage(menuId,systerm_id) {
	var url="";
	 $.ajax({
		type : "POST",
		url : basePath+"/mvc/getURL.do",
		async : false,
		data:{"menu_id":menuId,"systerm_id":systerm_id},
		dataType:'json',
		success : function(data) {
			if(data.msg == "success"){
				url=data.url;
			}else{
				alert("获取菜单失败,"+data.msg);
			}
		},
		error : function(msg) {
			alert("系统异常，请联系管理员! " + msg);
		}
	});
	var mainObj = parent.document.getElementById("loadMainContent");
	mainObj.src = url;
};
//待办事项跳转
function to_daiBanRenWu(menuId,systerm_id){
	toPage(menuId,systerm_id)
};