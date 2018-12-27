
var localObj = window.location;
var pathUrl = $('#clientURl').text();
var skillCo=null;//签入技能
var skillNamePortal=null;    //技能名称
var sillId=null;
var suffix=null;
//控制iframe高度
function setHeight(obj){
	var className = obj.className;
	height=$(window).height()-120;
	$("."+className).css("height",height);
}

//根据条线是否加载座席工作台首页
$(".tempWrap ul li").each(function(){
	if($(".tempWrap ul li").size == '1') return;
	if($(this).attr('id') == "P00006"){
		$("#mainJsp").removeClass("hidden");
		var url = pathUrl+"/mvc/querySeatInfoMain.do";
    	 $("#contents").append("<iframe id='loadMainContent 020_content' class='020_content' name='首页_iframe' frameborder='0'" +
  				"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
		$("#imgIs").addClass("hidden");
	}
	return;
});

//禁用F5刷新
$(document).ready(function(){ 
	$(document).bind("keydown",function(e){   
		var e=window.event||e;   
		if(e.keyCode==116){    
			e.keyCode = 0;    
		return false;   
		}  
	}); 
});

//个人信息下拉隐藏显示事件
$(".showPersonList").click(function(){
	if($(".dropdown-menu").hasClass("hidden")){
		$(".dropdown-menu").removeClass("hidden");
	}else{
		$(".dropdown-menu").addClass("hidden");
	}
});

var timeOutOfMain = null;
var timeoutNotice=null;
var noticeIds = Array();
var noticeTitles = Array();


/* 接收通知  */
var path = pathUrl;
var webSocketServerUrl=pathUrl+"/wsk/WebSocket";
var stompClient = null;
//建立与服务器连接
//connect();
/*采用新的方法*/
testWs();
function testWs(){
	var websocket;
    websocket = new SockJS(pathUrl+"/wsk/webSocketIMServer");
    websocket.onopen = function (evnt) {
    	console.log('onopen');
    };
    websocket.onmessage = function (evnt) {
   	websocket.send(userId);
   	if((evnt.data)=="恭喜你，登录成功！"){
       	console.log(evnt.data);
   	 }
   	 
   	 var tempStr = evnt.data.substring(0,4);
       if(tempStr=='Msg#') {
    	   noticeWarn(evnt.data.substring(4,evnt.data.length));
    	   return;
       }
	 if(evnt.data!="logout"&&evnt.data!="恭喜你，登录成功！"){ 
		 
	  	 var datas=JSON.parse(evnt.data);
	  	 var reciNos = datas.reciNo;
	  	 var ids = datas.ids;
	  	 var userIds = datas.reciNo.split(",");
	  	 var id;
	  	 for(var i=0;i<ids.length;i++){
		   if(userIds[i]==userId){
			   id=ids[i];
		   }
	  	 }
		   
		 setTimeout(function(){
			noticeOfMain(id,datas.title);
			newNotice(id,datas.title);
			noticeTell();
		 },1000);
		   
		 if(timeOutOfMain != null){
			clearTimeout(timeOutOfMain);
		 }
		 if(timeoutNotice!=null){
			   clearTimeout(timeoutNotice);
			   timeoutNotice=null;
		 } 
		 timeoutNotice = setTimeout(function(){
			$("#bell").removeAttr("style");
			$("#bell2").attr("style","display: none;");
		 },10000);
	}else if(evnt.data!="恭喜你，登录成功！"){
		
	    	if(agentBar){
	    		agentBar.logout();
	    	}
	    	f_back("您以被强制离线",function(){
	    		$.ajax({
					type : "POST",
					url : pathUrl+"/mvc/logOut.do",
					async : false,
					success : function(data) {
						if(data.msg == "success"){
							window.location = data.address;
						}else{
							f_alert("退出失败,请刷新界面或重启浏览器");
						}
					},
					error : function(msg) {
						landingPage(msg);
					}
				});
	    	});
       }
    };
    
    websocket.onerror = function (evnt) {
   	 console.log('onerror');
    };
    websocket.onclose = function (evnt) {
   	 console.log('onclose');
    }
}

function connect() {
    var socket = new SockJS(webSocketServerUrl);
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
    	console.log("消息WS server连接成功");
    	//连接成功
       	//订阅自己的消息
	    stompClient.subscribe("/topic/"+userId, function(dataObj){
	       console.log("消息WS 收到消息");
	       console.log(dataObj);
	       //提醒信息
		   var tempStr = dataObj.body.substring(0,4);
	       if(tempStr=='Msg#') {
	    	   noticeWarn(dataObj.body.substring(4,dataObj.body.length));
	    	   return;
	       }
	       
	       var datas=JSON.parse(dataObj.body);
	       console.log("消息WS END");

 		   var reciNos = datas.reciNo;
 		
		   var ids = datas.ids;
		   var userIds = datas.reciNo.split(",");
		   var id;
		   for(var i=0;i<ids.length;i++){
			   if(userIds[i]==userId){
				   id=ids[i];
			   }
		   }
		   if(timeOutOfMain != null){
				clearTimeout(timeOutOfMain);
			}
		   
		   setTimeout(function(){
			   newNotice(id,datas.title);
			   noticeOfMain(id,datas.title);
			   noticeTell();
			   },1000);
		   if(timeoutNotice!=null){
			   clearTimeout(timeoutNotice);
			   timeoutNotice=null;
		   } 
		   timeoutNotice = setTimeout(function(){
			   $("#bell").removeAttr("style");
				$("#bell2").attr("style","display: none;");
				},10000);
        });
    	
	    stompClient.subscribe("/logout/"+userId, function(dataObj){
	    	
	    	if(agentBar){
	    		agentBar.logout();
	    	}
	    	f_back("您以被强制离线",function(){
	    		$.ajax({
					type : "POST",
					url : pathUrl+"/mvc/logOut.do",
					async : false,
					success : function(data) {
						if(data.msg == "success"){
							window.location = data.address;
						}else{
							f_alert("退出失败,请刷新界面或重启浏览器");
						}
					},
					error : function(msg) {
						landingPage(msg);
					}
				});
	    	});
	    });
    });
}

//调用公告通知方法
function noticeTell(){
	
	if(document.getElementById("loadMainContent 020_content")!=null){
		document.getElementById("loadMainContent 020_content").contentWindow.noticeFor();
	}
}

//调用电销主页，公告通知方法
function homePageNotice(){
	
	if(document.getElementById("loadMainContent 021_content")!=null){
		document.getElementById("loadMainContent 021_content").contentWindow.homePageForNotice();
	}
}

//调用催收主页，公告通知方法
function csMainNotice(){
	
	if(document.getElementById("loadMainContent 022_content")!=null){
		document.getElementById("loadMainContent 022_content").contentWindow.noticeFor();
	}
}

	 //调用备忘录方法
function haveMemoFor(date){
		if(document.getElementById("loadMainContent 020_content")!=null){
		document.getElementById("loadMainContent 020_content").contentWindow.haveMemoTo(date);
	}else{
		haveMemoTo(date);
	}
}
	 	 
 //调用今日工作小结方法
function tWorkConclude(){
	if(document.getElementById("loadMainContent 020_content")!=null){
		document.getElementById("loadMainContent 020_content").contentWindow.tWorkConcludeFor();
	}
}

//小铃铛提醒
var flag;
function newNotice(id,title){
	/* $("#notices").removeAttr("style").attr("style","position: fixed;top: 74px;left: 100%;margin-left: -278px;width: 180px;"); */
		$("#bell").attr("style","display: none;");
		$("#bell2").removeAttr("style");
		if(type==1){
			$.post("noticeList.do",function(result) {			
				$("#noticeList").html(result).hide();
				$("#noticeList").fadeIn('fast');
				setHash('${pageContext.request.contextPath}');
				showNotice();
				showNotice();
			});
			
		} 
		haveNotice();
}

//通知弹框
function noticeOfMain(id,titleOfMain) { 
	
	$("#noticeContentOfMain").attr('onclick','viewEntity('+id+');');
	if(titleOfMain.length > 10 && titleOfMain.length <= 20){
		var title1 = titleOfMain.substring(0,(titleOfMain.length/2));
		$("#noticeContentOfMain").html($("<div style='height:15px'>"+title1+"</div>"));
		var title2 = titleOfMain.substring((titleOfMain.length/2),titleOfMain.length);
		$("#noticeContentOfMain").append($("<div class='rowOfNotice' style='height:15px'>"+title2+"</div>"));
	}else if(titleOfMain.length > 20 ){
		var title1 = titleOfMain.substring(0,(titleOfMain.length/3));
		$("#noticeContentOfMain").html($("<div style='height:15px'>"+title1+"</div>"));
		var title2 = titleOfMain.substring((titleOfMain.length/3),(titleOfMain.length)*2/3);
		$("#noticeContentOfMain").append($("<div class='rowOfNotice' style='height:15px'>"+title2+"</div>"));
		var title3 = titleOfMain.substring((titleOfMain.length)*2/3,titleOfMain.length);
		$("#noticeContentOfMain").append($("<div class='rowOfNotice' style='height:15px'>"+title2+"</div>"));
	}else{
		$("#noticeContentOfMain").html(titleOfMain);
	}
	setTimeout(function () { 
		$("#noticeBottomad").css({botton:"0px"}); 
		$('.noticeBotts').css('word-wrap','break-word');
		$('.noticeBotts').css('overflow-y','auto');
		$("#noticeBottomad").animate({botton:"0px" }); 
		$(".noticeBotk").css("display","block").animate({height:"122px"},500);
		$(".noticeBotk").addClass("noticeExist");
	},500);
	$("#adclose").click( function () { 
		/* $(".noticeBotk").hide(); */
		$(".noticeBotk").animate({height:"0px"},500);
		$(".noticeBotk").removeClass("noticeExist");
		$(".rowOfNotice").remove();
	}); 
		timeOutOfMain = setTimeout(function () { 
			/* $(".noticeBotk").hide(); */
			$(".noticeBotk").animate({height:"0px"},500);
			$(".noticeBotk").removeClass("noticeExist");
			$(".rowOfNotice").remove();
		},60000);
}

//通知弹框(预警)
function noticeWarn(title,time) {
	if(time == null){
		time = 10000;
	}
		if(timeOutOfMain!=null){
			clearTimeout(timeOutOfMain);
		}if($(".noticeBotk").hasClass("noticeExist")){
			$(".noticeBotk").animate({height:"0px"},500);
			$(".noticeBotk").removeClass("noticeExist");
		}
		setTimeout(function () { 
			$("#noticeBottomad").html(title);
			$("#noticeBottomad").css({botton:"0px"}); 
			$('.noticeBotts').css('word-wrap','break-word');
			$('.noticeBotts').css('overflow-y','auto');
			$("#noticeBottomad").animate({botton:"0px" }); 
			$(".noticeBotk").css("display","block").animate({height:"122px"},500);
			$(".noticeBotk").addClass("noticeExist");
		},500);
		$("#adclose").click( function () { 
			/* $(".noticeBotk").hide(); */
			$(".noticeBotk").animate({height:"0px"},500);
			$(".noticeBotk").removeClass("noticeExist");
			$("#noticeBottomad").html('<a id="noticeContentOfMain" href="javascript:void(0)" style="font-color:#428bca" onclick="viewEntity()"></a>');
		}); 
		timeOutOfMain = setTimeout(function () { 
			/* $(".noticeBotk").hide(); */
			$(".noticeBotk").animate({height:"0px"},500);
			$(".noticeBotk").removeClass("noticeExist");
			$("#noticeBottomad").html('<a id="noticeContentOfMain" href="javascript:void(0)" style="font-color:#428bca" onclick="viewEntity()"></a>');
		},time);
}

function haveNotice(){
	$.post("pubRecipientsList.do",function(result) {
		$("#newNotice").text("("+result.newNotice+"条未读)");
		$("#bells").attr("title",result.newNotice+"条未读消息通知");
	});  
}

function viewEntity(id){
	var url = pathUrl+'/mvc/notice_edit.do?id='+id+'&viewOrEdit=B'
	 $.post(url,function(content){
		 openDialogTwo(content,900,null,null);	 
	 });
}

var type = 0;
function showNotice(){
	if(type!=1){
		$.post("noticeList.do",function(result) {			
			$("#noticeList").html(result).hide();
			$("#noticeList").fadeIn('fast');
			setHash(pathUrl);
			$(".notice").attr("style","display:none");
			if($(".noticeId").eq(0).val()!=null&&$(".noticeId").eq(0).val()!=""){
				$(".notice").eq(0).removeAttr("style");
			}
			if($(".noticeId").eq(1).val()!=null&&$(".noticeId").eq(1).val()!=""){
				$(".notice").eq(1).removeAttr("style");
			}
			if($(".noticeId").eq(2).val()!=null&&$(".noticeId").eq(2).val()!=""){
				$(".notice").eq(2).removeAttr("style");
			}
			if($(".noticeId").eq(3).val()==null||$(".noticeId").eq(3).val()==""){
				$(".otherNotice").attr("style","display:none");
			}
			if($(".noticeId").eq(0).val()==null||$(".noticeId").eq(0).val()==""){
				$(".otherNotice").attr("style","display:none");
			}else{
				type=1;
			}
		});
	$("#notices").removeAttr("style").attr("style","position: fixed;top: 74px;left: 100%;margin-left: -278px;width: 180px;");
	}else{
		$("#notices").attr("style","display:none");
		$(".notice").attr("style","display:none");
 		$(".otherNotice").removeAttr("style").attr("style","float: none;padding: 0px;");
		type=0;
	}
	$("#bell").removeAttr("style");
	$("#bell2").attr("style","display: none;");
}

//排班信息
function queryScheduling(){
	var url = pathUrl+'/mvc/querySchedulingList.do';
	 $.post(url,function(content){
		
		 openInfoDialog("排班信息",content,700,null,function saveScheduling(){
				for(var m=0;m<count;m++){
				if (!IsYYYYMMDD($(".date").eq(m).val())) {
					f_alert("日期格式错误");
					return false;
				}
				}
				$("#sample-table-2 select").removeAttr("disabled");
				$.ajax({
					type : "POST",
					url : pathUrl+"/mvc/schedulingSave.do",
					data : $("#sub_form2").serialize(),
					async : false,
					dataType:'json',
					success : function(data){
						if(data.msg != null){
							 $("#errorss").text(data.msg);
						}
					}
				});
				 setTimeout(function(){
					 changeMain();
					 },500);
				},null);
	 });
}

function goNotices(){
	$(".notice").removeAttr("style").attr("style","float: none");
	if($(".noticeId").eq(0).val()==null||$(".noticeId").eq(0).val()==""){
		$(".notice").eq(0).attr("style","display:none");
	}
	if($(".noticeId").eq(1).val()==null||$(".noticeId").eq(1).val()==""){
		$(".notice").eq(1).attr("style","display:none");
	}
	if($(".noticeId").eq(2).val()==null||$(".noticeId").eq(2).val()==""){
		$(".notice").eq(2).attr("style","display:none");
	}
		$(".otherNotice").attr("style","display:none");
}

function getNotice(the){
	showNotice();
	var id = the.find("input").eq(0).val();
	var url = pathUrl+'/mvc/notice_edit.do?id='+id+'&viewOrEdit=B' 
	 $.post(url,function(content){
		 openDialogTwo(content,900,null,null);	 
	 }); 
}

function changeMain(){
	if(document.getElementById("loadMainContent 020_content")!=null){
			if(document.getElementById("loadMainContent 020_content").contentWindow.scheduling!=null){
				document.getElementById("loadMainContent 020_content").contentWindow.scheduling();
		}
	}
}


/* 个人首页 */
function mainFile(){
	$("#main_Content").find("*").remove();
	$("#main_Content").append("<div id='imgIs'>"+
			"<img src='../images/back_disabled1.png' class='image' /></div>"+
			"<div id='mainJsp' class='hidden'>"+
			"<div class='main-contentJsp'><ul id='tabs' class='breadcrumbs_tab'>"+
			"<li class='current home'><a class='tab' id='020' href='#' rel='首页'>导航页</a>"+
			"<div class='line'></div></li></ul><div id='contents'></div></div></div>");
	
	$(".tempWrap ul li").each(function(){
		if($(this).find("a").hasClass("bgColor")){
			$(this).find("a").removeClass("bgColor");
		}
		if($(this).attr('id') == "P00006"){
			$("#mainJsp").removeClass("hidden");
			var url = pathUrl+"/mvc/querySeatInfoMain.do";
        	 $("#contents").append("<iframe id='loadMainContent 020_content' class='020_content' name='首页_iframe' frameborder='0'" +
      				"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
			$("#imgIs").addClass("hidden");
		}
		return;
	});
	/* window.location.reload(true); */
}

//修改密码
function updatePWD(){
	/* showModal($("#update_pwd")); */
	var url = pathUrl+'/mvc/user_updatepwd.do';
	$.post(url,function(content){
		openInfoDialog("修改密码",content,500,null,function save(){
			if (!checkData('pwd_old', '原始密码 ', 'inputNull')) {
				return false;
			}
			if (!checkData('pwd_new', '最新密码 ', 'inputNull')) {
				return false;
			}
			if(!checkData('pwd_new','最新密码','pinLength')){
				return false;
			}
			if(!checkData('pwd_new','最新密码','pwd')){
				return false;
			}
			if($("#pwd_old").val() == $("#pwd_new").val()){
				$("#pwd_new").after("<div class=\"help-block red\" style='color:#e6a59a !important'>&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;新密码不能与旧密码一样");
				return false;
			}
			$.ajax({
				type : "POST",
				url : pathUrl+"/mvc/user_updatepwdSave.do",
				data : $("#sub_form").serialize(),
				async : false,
				dataType:'json',
				success : function(data) {
					if(data.msg == "success"){
						f_alert("success","forwardMain.do");
					}else{
						f_alert("保存失败:"+data.msg);
					}
				},
				error : function(msg) {
					f_alert("系统异常，请刷新重试！");
				}
			});
	});
	
});
}

//注销
function logOut(){
	var text = document.getElementById("checkin").innerText;
	//判断软电话当前是否签入
	if(text == "签出"){
		f_alert("当前软电话正在使用,请您先将软电话签出后再退出");
		return;
	}
	
	f_confirm("是否退出系统？",function cellback(){
		$.ajax({
			type : "POST",
			url : pathUrl+"/mvc/logOut.do",
			async : false,
			success : function(data) {
				if(data.msg == "success"){
					window.location = data.address;
				}else{
					f_alert("退出失败,请刷新界面或重启浏览器");
				}
			},
			error : function(msg) {
				landingPage(msg);
			}
		});
	});
}

/* 个人信息 */
function personalInfo(){
	$.ajax({
		type : "POST",
		url : pathUrl+"/mvc/queryPersonalInfo.do",
		async : false,
		success : function(data) {
			backDialog("个人信息",data,600,400,function save(){
			});
		},
		error : function(msg) {
			landingPage(msg);
		}
	}); 
}

/* 调转至登录页 */
function landingPage(msg){
	var url = $('#client_address_url').val();
//	var url = $('#client_address_url').text();
	var status = msg.readyState;
	if(status == "0"){
		window.location.href  = url;
		return;
	}
	if(status == "4"){
		$("#readyState").html(msg.responseText);
		var loginSubmit = $("#readyState").find(".login_submit").text();
		if(loginSubmit.length > 0){
			window.location.href  = url;
			return;
		}
	}
};

//标签页
function addTab(link,url,menuId,menuName) {
	if ($("." + menuId + "_content").length != 0){
	  var tab = $('#tabs a#'+menuId);
     $("#contents iframe").hide();
     $("#tabs li").removeClass("current");
  	  $("." + menuId + "_content").remove();
     $("#contents").append("<iframe id='loadMainContent  "+ menuId +"_content'  class='"+ menuId +"_content' name='"+menuName+"_iframe' frameborder='0'" +
				"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
         tab.parent().addClass("current");
     return;
   }
     $("#tabs li").removeClass("current");
     $("#contents iframe").hide();
     $("#tabs").append("<li class='current'><a class='tab' id='" +
          menuId + "' href='#' rel='" + menuName + "'>" + menuName + 
          "</a><a href='#' class='remove'>x</a><div class='line'></div></li>");
      //add new iframe
	 $("#contents").append("<iframe id='loadMainContent  "+ menuId +"_content'  class='"+ menuId +"_content' name='"+menuName+"_iframe' frameborder='0'" +
	"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
    
     //切换标签
	 $('#tabs a.tab').click(function(e){
	    // Get the tab name
        var contentname = $(this).attr("id") + "_content";
        // hide all other tabs
        $("#contents iframe").hide();
        $("#tabs li").removeClass("current");
      	// show current tab
        $("." + contentname).show();
        $(this).parent().addClass("current");
        
      });
      $('#tabs a.remove').on('click', function() {
           // Get the tab name
           var tabid = $(this).parent().find(".tab").attr("id");
           var index = $(this).parent("li").index()-1;
           // remove tab and related content
           var contentname = tabid + "_content";
           $("." + contentname).remove();
           $(this).parent().remove();
           // if there is no current tab and if there are still tabs left, show the first one
           if ($("#tabs li.current").length == 0 && $("#tabs li").length > 0) {
               // find the first tab
               var firsttab = $("#tabs li").eq(index);
              
               if($("#tabs li.home").hasClass("hidden")){
            	   if(index == 0){
        			   firsttab = $("#tabs li").eq(1);
        		   }
               }
              firsttab.addClass("current");
              // get its link name and show related content
              var firsttabid = $(firsttab).find("a.tab").attr("id");
              $("." + firsttabid + "_content").show();
        }
   	});
}

//关闭当前页(无提示)
function cloTable(){
	var $li = $("#tabs li.current");
	var index = $li.index()-1;
	var tabid = $li.find(".tab").attr("id");
	var contentname = tabid + "_content";
	$("." + contentname).remove();
	$li.remove();
	if ($("#tabs li.current").length == 0 && $("#tabs li").length > 0) {
        // find the first tab 
        var firsttab = $("#tabs li").eq(index);
        firsttab.addClass("current");
        // get its link name and show related content
        var firsttabid = $(firsttab).find("a.tab").attr("id");
        $("." + firsttabid + "_content").show();
 }
}


var pobBoxIsClose = true;
//自定义-模态框 url为请求地址，title为标题
function customModel(url,title,height){
	if(height == null){
		height=$(window).height()-120;
	}
    $.post(url,function(content){
    	openDialogNobutton(title,content,"94%",height,'','',function(){
    		if(!pobBoxIsClose){
    			f_alert("通话状态窗口不可关闭！");
    		}
    		return pobBoxIsClose;
    	},true);
	}); 
};

var agentBar=null;                                              //ipcc软电话客户端对象；
var agentClient=null;
var loginCondition=true;
var monitorStatusData=null;
var ipccurl=$("#fmtipccurl").text();
var agentCheckStatus=0;
window.toPortal = {
	init:function(id,name,sign){
		to_portal(id,name,sign);
	}
};
	/************点击条线跳转***************/
	function to_portal(portal_id,portal_name,portal_sign){
		var $currentA = $("#"+portal_id).find("a");
		if($currentA.hasClass("bgColor")) return;
		var param={};
		param['portalId']=portal_id;
		param['portalName']=portal_name;
		var iframeParame=param;
		var iframeurl=null;
		var classNm=null;
		var idNm=null;
		var pageName=null;
		var portalId=null;
		 $.post(pathUrl+'/mvc/getIpccRole.do',param,function(content){
			 if(agentCheckStatus==content||content==4){
				
			 }else{
				 if(agentBar){
					 agentBar.logout()
				 }
				 ipccConnectWeb();
				 agentCheckStatus=content;
				 //外呼
				 if(content==1){
							var buttonObject={
									checkin:0,//签入
									notReady:0,//置忙
									answerCall:0,//挂机
									makeCall:0,//拨号弹框按钮
									sendDTMF:0,//二次拨号弹框按钮
									holdCall:1,//保持
									conferenceCall:1,//会议
									consultCall:1,//咨询
									transferCall:1,//转接
									survey:1,//满意度
									cue:0,//状态
									txtStatus:0,//置忙后所选状态
									statusTime:0,//置忙后所选状态时间
									listenCall:1,//监听
									insertCall:1,//强插
									forceHangupCall:1,//强拆
									forceLogout:1//强制签出
							}
							//按钮权限控制
							phoneNotUse(buttonObject);
							monitorIframe(iframeParame);
				 	}
				 //外呼+呼入
				 if(content==2){
						var buttonObject={
								checkin:0,
								notReady:0,
								answerCall:0,
								makeCall:0,
								sendDTMF:0,
								holdCall:0,
								conferenceCall:0,
								consultCall:0,
								transferCall:0,
								survey:0,
								cue:0,
								txtStatus:0,
								statusTime:0,
								listenCall:1,
								insertCall:1,
								forceHangupCall:1,
								forceLogout:1
						}
						//按钮权限控制
						phoneNotUse(buttonObject);
						monitorIframe(iframeParame);
			 	}
				 //监听
				 if(content==3){
						var buttonObject={
								checkin:0,
								notReady:1,
								answerCall:0,
								makeCall:1,
								sendDTMF:1,
								holdCall:1,
								conferenceCall:1,
								consultCall:1,
								transferCall:1,
								survey:1,
								cue:0,
								txtStatus:0,
								statusTime:0,
								listenCall:0,
								insertCall:0,
								forceHangupCall:0,
								forceLogout:0
						}
						//按钮权限控制
						phoneNotUse(buttonObject);
						monitorIframe(iframeParame);
			 	}
				 //无权限
				 if(content!=1&&content!=2&&content!=3){
						var buttonObject={
								checkin:1,
								notReady:0,
								answerCall:0,
								makeCall:0,
								sendDTMF:0,
								holdCall:0,
								conferenceCall:0,
								consultCall:0,
								transferCall:0,
								survey:0,
								cue:0,
								txtStatus:0,
								statusTime:0,
								listenCall:1,
								insertCall:1,
								forceHangupCall:1,
								forceLogout:1
						}
						//按钮权限控制
						phoneNotUse(buttonObject);
						monitorIframe(iframeParame);
			 	}
			 }
		 });
		$currentA.addClass("bgColor");
		$currentA.parent("li").siblings("li").find("a").removeClass("bgColor");
		
		document.getElementById("desktop").innerHTML=portal_name;
		var ps = document.getElementById("portalSign").innerHTML=portal_sign;
		if(ps == "1"){

			$("#checkin").attr("disabled",false);  //去掉disable  
		}
		if(ps == "0"){
			if($("#checkin").prop("disable")){
				$("#checkin").attr("disabled",true); 
			}
		}
		$("ul").find("#"+portal_id).find("#span").attr("style","display: none;");
		var	param={};
		param["portal_id"]=portal_id;
		$.post(pathUrl+"/mvc/forwardIndex.do", param, function(result) {
			if(result.indexOf('login_submit')>-1){
				parent.parent.window.location.href=cPh+'/';//session超时
				return false;
			}
			$("#main_Content").html(result).hide().fadeIn('fast');
			$(".information_down li:eq(0)>a:eq(0)").attr("class","checkin");
			$("[data-toggle='popover']").popover('hide'); 
			if(portal_name=="现场管理"){
				$.post(pathUrl+"/mvc/queryPower.do", param, function(data) {
					if(data.msg!=null){
						f_alert(data.msg);
						$("#menuTree").html("");
						return;
					}else{
						$(window).resize(function() {
							setHash('${pageContext.request.contextPath}');
						});
					}
				})
			}else{
				$(window).resize(function() {
					setHash('${pageContext.request.contextPath}');
				});
				}
			$(window).resize(function() {
				setHash('${pageContext.request.contextPath}');
			});
			});
		};
		
	$("#checkin").on('click',function(e){
		var param=[];
		btnName=$(this).text();
		checkin(btnName);
	});
		
	function checkin(btnName){
		console.log(btnName);
		if(btnName=="签入"){
			 loginIn();
		}
		if(btnName=="签出"){
			skillNameDesktop="";
			skillNamePortal="";
			var condition=$("#txtStatus").text();
			if(condition == '空闲'||condition==null||condition=="网络异常"||condition==""||condition=="网络正常"||condition=="签出"){
				agentBar.logout();
				//签出方法；
				f_success("您已签出！！！");
				$(".suffix_login").find("span").text("");
				skillChange(skillNe,"签出");
				return;
			}else{
				f_alert("工作状态无法签出,请置闲后再签出");
			}
		}
	}
	

	 //ip电话签入：技能未选、取消签入及签入状态有异，提示重新签入；
 	function loginIn(){              
 		//签入异常标识打开，若有错误，会提示；
 		setAgentData(true);     
 		initIPCC();
		 var url=pathUrl+'/mvc/queryIpccUserInfo.do';
		 var param={};
		 param["jobNumber"]=ipccParameterObj.userNu;
		 $.post(url,param,function(content){
			 var contentNu=$(content).find("#selectValue tbody tr");
			 if(contentNu!="0"){
				 loginIpccDialog("签入技能组选择",content, 400,600,function setIpccOption(){
					 setAgentBarOption(skillCo,userNu,userNm,suffix);              //签入，属性：技能，坐席工号，坐席分机号，坐席姓名；
					 setAgentOption('${ipccCfgUrlInfo[0].ivrDn}','123456','${ipccCfgUrlInfo[0].dialPrefix}','${ipccCfgUrlInfo[0].answerUrl}','${ipccCfgUrlInfo[0].hangupUrl}');
					 skillNamePortal=null;
				 });
			 }else{
				 f_alert("技能组获取失败，请刷新页面后再签入");
			 }
		 }); 
	};   
	
	//获取非通话中休息原因；
	function makeBusy(buttontype){
		 var url=pathUrl+'/mvc/ipccBusygetList.do';
		 $.post(url,function(content){
			 openIpccDialog("置忙原因",content,400,600,function setBusy(){
				 setCustBusy(busy);//设置坐席忙碌原因,置忙原因包括：忙碌及初始化置忙原因，忙碌的编码为11，其他编码根据原因初始化的顺序；busy为数字；
				}
			);
		 }); 
	}; 
	
	//获取预约休息原因；
	function makeBusyAppoint(){
		 var url=pathUrl+'/mvc/SkipIpccMakeBusyAppointModal.do';
		 $.post(url,function(content){
			 openIpccDialog("置忙原因",content,400,600,function setBusy(){
				 setAppointBusy(busy);
				}
			);
		 }); 
	}; 
	
	//获取坐席状态，实现咨询
	var buttontype=null; //方式；
	function getFreeCust(){
		var url=pathUrl+'/mvc/SkipIpccFreeCustModal.do';
	    $.post(url,function(content){
				openIpccDialog("空闲人员列表",content,500,700,function setConsultCall(){
					if(buttontype=="咨询"){
						getStatusConsultCall(userNu,suffix);
					}
					if(buttontype=="会议"){
						getStatusConferenceCall(userNu,suffix);
					}
					userNu=null;
				}
			);
		}); 
	}; 
	
	//获取坐席状态，实现转接
	var transferSkill="";
	function getFreeCustTran(){
		var url=pathUrl+'/mvc/SkipIpccFreeCustSkill.do';
	    $.post(url,function(content){
				openIpccDialog("转接技能组选择",content,500,700,function setConsultCall(){
					//技能转接
					getStatusTransferCall(transferSkill,suffix);
					console.log(transferSkill);
					userNu=null;
				} 
			);
		}); 
	    transferSkill="咨询转接";
	}; 
	
	//save touch data
	function saveIpccData(param){
		var url=pathUrl+'/mvc/SaveIpccDate.do'; 
		console.log(param);
	    $.post(url,param,function(content){
	  
		}); 
	}; 
	
	//改变坐席首页技能字段
	function skillChange(skillNamePortal1,checkeStatus){
		var skillne=$(".020_content").contents().find("#personSkill").text();
		var skillNameArrary = new Array(); 
		skillNameArrary = skillne.split("、");
		var skillHtml = "";
		for(var i=0;i<skillNameArrary.length;i++){
			if(i==0){
				if(skillNamePortal == skillNameArrary[i]){
					skillHtml += "<b>"+skillNameArrary[i]+"</b>";
				} else {
					skillHtml += skillNameArrary[i];
				}
			}else{
				if(skillNamePortal == skillNameArrary[i]){
					skillHtml += "、"+"<b>"+skillNameArrary[i]+"</b>"
				} else {
					skillHtml += "、"+skillNameArrary[i];
				}
			}
		}
		if(checkeStatus=="签入"&&skillne!=null){
			$(".020_content").contents().find("#personSkill").html(skillHtml);
		}
		if(checkeStatus=="签出"&&skillne!=null){
			skillNamePortal = null;
			$(".020_content").contents().find("#personSkill").html(skillne);
		}
	};
	
	//ipcc controller
	$(function(){
			 var btnName;     //按钮名称，可以根据名称，选择方法；
			$("#answerCall").click(function(){                 //摘机，按钮的变化（工具栏无法实现摘机功能）
					btnName=$(this).text();
					if(btnName=="摘机"){
						agentBar.answerCall();
					}
					if(btnName=="挂机"){
						agentBar.hangupCall();
						holdType='01';   //  主动挂机
					}
					return false;
			})
			
			//置忙点击  空闲；
			$("#notReady").click(function(){          
				btnName=$(this).text();        //置忙 函数只能在电话接通过程中调用？还是可以再不接电话中也可调用？小休及预约的区别？
				 if(btnName=="置忙"){
					 makeBusy();
				} 
				if(btnName=="预约置忙"){
					console.log(btnName);
					makeBusyAppoint();
				}
				if(btnName=="空闲"){
					console.log(btnName);
					agentBar.ready();
				}
				return false;
			})
	
			//保持
			$("#holdCall").click(function(){ 
				btnName=$(this).text();
				console.log(btnName);
				if(btnName=="恢复"){
					agentBar.retrieveCall()
				}
				if(btnName=="保持"){
					agentBar.holdCall();
				}
				return false;
			})
			
			//咨询
			$("#consultCall").click(function(){    
				btnName=$(this).text();
				console.log(btnName)
				if(btnName=="咨询"){
					buttontype="咨询";
					getFreeCust();
				}
				if(btnName=="咨询取回"){
					console.log(btnName)
					agentBar.reconnectCall();
				}
				return false;
			})
	
			//转接
			$("#transferCall").click(function(){   
				btnName=$(this).text();
				console.log(btnName)
				buttontype="转接";
				if($("#consultCall").text()=="咨询取回"){
					getStatusForwordCall();
				}
				if(btnName=="转接"&&$("#consultCall").text()!="咨询取回"){
					getFreeCustTran();
				}
				return false;
			})
			
			//会议
			$("#conferenceCall").click(function(){  
				btnName=$(this).text();
				console.log(btnName);
				if($("#consultCall").text()=="咨询取回"){
					agentBar.joinCall();
				}
				if(btnName=="会议"&&$("#consultCall").text()!="咨询取回"){
					buttontype="会议";
					getFreeCust();
				}
				return false;
			});
			 
			 //满意度
			 $("#survey").click(function(){
				 var flag=agentBar.singleStepTransfer("1","4001");  //需要确定技能组，以实现技能组转ivr分机;
				 if(flag==true){
					 holdType='03';  //转ivr挂机
				 }
			 })
	})

	//进入页面时，关闭外拨按钮
	$(function(){
		$("[data-toggle='popover']").popover();
	})
	
	function monitorIframe(param){
		$.post(pathUrl+'/mvc/getHiddenIframeData.do',param,function(content){
			if(content["iframeData"]){
				var obj=content["iframeData"][0];
				iframeurl=obj["systerm_url"]+obj["systerm_project"];
				classNm=obj["systerm_code"]+"_hidden";
				pageName=obj["systerm_code"]+"_hidden";
				idNm=obj["systerm_id"]+"_hidden";
			}
			portalId=param["portalId"];
			useHiddenIframe(iframeurl,classNm,idNm,pageName,portalId);
		}).error(function(){
			f_alert("ipcc事件监控失败，请重新刷新页面");
		});
	}
	
	