var path=document.getElementById("path").value;	
//日历
	var calendar = $('#calendar').fullCalendar({
		 buttonText: {
			prev: '<i class="icon-chevron-left"></i>',
			next: '<i class="icon-chevron-right"></i>'
		},
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		buttonText: {
			today: "今天",
			//prev:"前一月",
			//next:"后一月",
			month: '月',
			week: '周',
			day: '日'
		},
		monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
		monthNamesShort: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
		dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
		dayNamesShort: ['日', '一', '二', '三', '四', '五', '六'],
		firstDay: 1,
		editable: true,//拖拽和改变大小
		droppable: true, // this allows things to be dropped onto the calendar !!!
		eventDrop:function(event){//拖拽
			//修改用户工作日记
			showModal($("#workDiary_edit_modal"));
			var id = calEvent.id;
			var start_time = $.fullCalendar.formatDate(calEvent.start,"yyyy-MM-dd");
			var end_time = $.fullCalendar.formatDate(calEvent.end,"yyyy-MM-dd");
			if(end_time==null || end_time=="") end_time = start_time;
			var title = calEvent.title;
			var className ="" ;
			if(calEvent.className=="label-success"){
				className ='1';
			}else if(calEvent.className=="label-danger"){
				className ='2';
			}else{
				className='0';
			}
			$(window.document).find("#workDiary_edit_modal input[id='id_1']").val(id);
			$(window.document).find("#workDiary_edit_modal input[id='start_time_1']").val(start_time);
			$(window.document).find("#workDiary_edit_modal input[id='end_time_1']").val(end_time);
			$(window.document).find("#workDiary_edit_modal select[id='className_1']").val(className);
			$(window.document).find("#workDiary_edit_modal textarea[id='title_1']").val(title);
		}
		,
		eventResize:function(event){//改变大小
			//修改用户工作日记
			showModal($("#workDiary_edit_modal"));
			var id = calEvent.id;
			var start_time = $.fullCalendar.formatDate(calEvent.start,"yyyy-MM-dd");
			var end_time = $.fullCalendar.formatDate(calEvent.end,"yyyy-MM-dd");
			if(end_time==null || end_time=="") end_time = start_time;
			var title = calEvent.title;
			var className ="" ;
			if(calEvent.className=="label-success"){
				className ='1';
			}else if(calEvent.className=="label-danger"){
				className ='2';
			}else{
				className='0';
			}
			$(window.document).find("#workDiary_edit_modal input[id='id_1']").val(id);
			$(window.document).find("#workDiary_edit_modal input[id='start_time_1']").val(start_time);
			$(window.document).find("#workDiary_edit_modal input[id='end_time_1']").val(end_time);
			$(window.document).find("#workDiary_edit_modal select[id='className_1']").val(className);
			$(window.document).find("#workDiary_edit_modal textarea[id='title_1']").val(title);
		}
		,
		selectable: true,
		selectHelper: true,
		select: function(start, end, allDay) {//选择某一天进行新增日记
			showModal($("#workDiary_add_modal"));
			var start_time = $.fullCalendar.formatDate(start,"yyyy-MM-dd");
			var end_time = $.fullCalendar.formatDate(end,"yyyy-MM-dd");
			$(window.document).find("#workDiary_add_modal input[name='start_time']").val(start_time);
			$(window.document).find("#workDiary_add_modal input[name='end_time']").val(end_time);
			calendar.fullCalendar('unselect');
		}
		,
		eventClick: function(calEvent, jsEvent, view) {
			showModal($("#workDiary_edit_modal"));
			var id = calEvent.id;
			var start_time = $.fullCalendar.formatDate(calEvent.start,"yyyy-MM-dd");
			var end_time = $.fullCalendar.formatDate(calEvent.end,"yyyy-MM-dd");
			if(end_time==null || end_time=="") end_time = start_time;
			var title = calEvent.title;
			var className ="" ;
			if(calEvent.className=="label-success"){
				className ='1';
			}else if(calEvent.className=="label-danger"){
				className ='2';
			}else{
				className='0';
			}
			$(window.document).find("#workDiary_edit_modal input[id='id_1']").val(id);
			$(window.document).find("#workDiary_edit_modal input[id='start_time_1']").val(start_time);
			$(window.document).find("#workDiary_edit_modal input[id='end_time_1']").val(end_time);
			$(window.document).find("#workDiary_edit_modal select[id='className_1']").val(className);
			$(window.document).find("#workDiary_edit_modal textarea[id='title_1']").val(title);
		}
	});
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
				url : path+"/mvc/addWorkDiary.do",
				data : params,
				async : false,
				dataType:'json',
				success : function(data) {
					if(data.msg == "success"){
						var obj = new Object();
						obj.id = data.id;
						obj.title = title;
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
				url : path+"/mvc/editWorkDiary.do",
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
				url : path+"/mvc/deleteWorkDiary.do",
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
		var path=document.getElementById("path").value;
		$.ajax({
			type : "POST",
			url : path+"/mvc/queryWorkDiary.do",
			async : false,
			dataType:'json',
			success : function(data) {
				$.each(data,function(index,result){
					var obj = new Object();
					obj.id = result.ID;
					obj.title = result.TITLE;
					obj.start = $.fullCalendar.parseDate(result.START_TIME);
					obj.end = $.fullCalendar.parseDate(result.END_TIME);
					if(result.CLASS_NAME==1){
						obj.className ='label-success';
					}else if(result.CLASS_NAME==2){
						obj.className ='label-danger';
					}else{
						obj.className ='label-info';
					}
					$('#calendar').fullCalendar('renderEvent',obj,true);
				});
			},
			error : function(msg) {
				alert("内部异常  " + msg);
			}
		});	
	}
	
	//查询行业动态信息
	function getIndustryInfo() {
		$.ajax( {
			type : "POST",
			url :  path+"/mvc/industry_getList_homePage.do",
			async : false,
			success : function(data) {
				$.each(data,function(index,result) {
					/* var tr = $('<tr></tr>');
					tr.appendTo($("#industry_list_group"));
						var td = $('<td><a onclick="industryView(\''+result.ID+'\')" style="cursor:pointer">'+result.TITLE+'</a></td>');
						td.appendTo(tr);*/						
						
					var tr = $('<div class="profile-activity clearfix"> </div>');
					tr.appendTo($("#industry_list_group"));
						var td = $('<div><a onclick="industryView(\''+result.ID+'\')" style="cursor:pointer">'+result.TITLE+'</a></div>');
						td.appendTo(tr);
				});
				setHash(path);
			},
			error: function(msg) {
				alert("内部异常  " + msg);
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
			url : path+"/mvc/industry_get_homePage.do",
			data : param,
			async : false,
			success : function(obj) {
				$(window.document).find("#industry_modal input[name='title']").val(obj.title);
				$(window.document).find("#industry_modal input[name='time']").val(obj.start_time);
				$(window.document).find("#industry_modal div[id='content']").html(obj.content);
			},
			error : function(msg) {
				alert("获取行业动态数据失败: " + msg);
			}
		});
	}
	//菜单跳转到任务管理,页面跳转到具体任务处理页面
	function toPage(url) {
		//var url =encodeURIComponent(url);
		 $.ajax({
			type : "POST",
			url :  path+"/mvc/getURL.do",
			data:{"url":url},
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == "success"){
					url=data.url;
				}else{
					alert("访问出错,"+data.msg);
				}
			},
			error : function(msg) {
				alert("内部异常  " + msg);
			}
		});
		var mainObj = document.getElementById("loadMainContent");
		mainObj.src = url;
	}