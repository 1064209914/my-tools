
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getServerName() + ":"
		+ request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>华拓新一代外呼营销作业平台</title>
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css" />
<link rel="shortcut icon" href="<%=path%>/images/favicon.ico"
	type="image/x-icon" />
<link rel="stylesheet" href="<%=path%>/css/mainPage/layout.min.css" />
<link rel="stylesheet"
	href="<%=path%>/css/mainPage/css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=path%>/css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace-rtl.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace-skins.min.css" />
<link rel="stylesheet" href="<%=path%>/css/jquery.popbox.css" />
<link rel="stylesheet" href="<%=path%>/css/xcConfirm.css" />
<link rel="stylesheet" href="<%=path%>/css/tablePannel/tablePannel.css">
<style type="text/css">
.noticeBotk {
	right: 8px;
	position: fixed;
	width: 200px;
	z-index: 9999;
	height: 0px;
	background: #7db4d8;
	color: #000000;
	bottom: 0px;
	display: none;
}

.noticeBotts {
	width: 200px;
	height: 100px;
	position: absolute;
	background: #e8e8e8;
}

#noticeContentOfMain {
	display: inline-block;
	text-align: center;
	width: 200px;
	line-height: 80px;
	color: #428bca;
}

#noticeClose {
	position: relative;
	z-index: 1;
	height: 22px;
}

#adclose {
	position: absolute;
	cursor: pointer;
	margin-right: auto;
	left: 87%;
	top: 0px;
	height: 22px;
	width: 25px;
}
/* 	.pb_panel{
	top:250px;
	} */
	#tree3{
		padding:0px;
	}
	#tree3 ul{
		margin:0px !important;
	}
	#tree_name{
		border:1px solid #c2c2c2;
		height: 30px;
		width:60%;
		padding-left:3px;
		line-height: 30px;
	}
	#tree_name:focus{
		outline:none;
		border-color:#6fb3e0;
	}
	#tree_name:visited{
		border-color:#6fb3e0;
	}
	#tree_name:active{
		border-color:#6fb3e0;
	}
	#tree_name:hover{
		border-color:#b5b5b5;
	}
	.userInput>p{
	text-indent:1em;
	}
</style>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/chat.css" />
<script src="<%=path%>/js/ace-extra.min.js"></script>
<script type="text/javascript">
		window.jQuery|| document.write("<script src='<%=path%>/js/jquery-2.0.3.min.js'>" + "<"+"script>");
	</script>
<script type="text/javascript">
		if ("ontouchend" in document)document.write("<script src='<%=path%>/js/jquery.mobile.custom.min.js'>"
						+ "<"+"script>");
</script>
</head>
<body>
	<!-- 当前客服端地址 -->
	<input value="${client_url}" id="client_address_url" class="hidden">
	<!-- ipcc事件改变，子系统页面监控变化，一旦此处div中的文本元素发生改变，子页面就会监听到该事件 -->
	<div id="agentMonitor" style="display: none">
		<div id="agentStatus" style="display: none"></div>
	</div>
	<div id="monitorData" style="display: none"></div>
	<div id="toppage">
		<div class="logowrap">
			<span id="topName" style="font-family: '微软雅黑';">华拓新一代外呼营销作业平台</span>
			<span id="desktop" class="hidden"></span> <span id="portalSign"
				class="hidden"></span>
		</div>
		<img alt="" src="<%=path%>/css/mainPage/image/tu_01.png" width="239"
			height="74" class="logo_pic">
		<div class="bjfw clearfix">
			<div class="picScroll">
				<div class="tempWrap">
					<ul>
						<c:forEach items="${portalList}" var="portalList">
							<li id='${portalList.portal_id}'><span class="icon-bell-alt"
								style="display: none;" id="span"></span> <a id="pitchOn"
								href="javascript:void(0);"
								onclick="to_portal('${portalList.portal_id}','${portalList.portal_name}','${portalList.portal_sign}');"
								style="text-decoration: none;"> <%-- <i class="fa ${portalList.portal_class}" style="font-size:30px;"></i> --%>
									<img alt=""
									src="<%=path%>/css/icons/${portalList.portal_class}.png"
									style="display: block; margin: auto;"> <font
									style="font-size: 12px; text-align: center; font-family: '微软雅黑';">${portalList.portal_name}</font>
							</a></li>
						</c:forEach>
					</ul>
				</div>
				<a class="prev"></a><a class="next"></a>
			</div>
		</div>
		<div class="userInfo">
			<ul class="information_down">
				<div class="soft_phone">
					<span id="cue" class="icon-circle cue"
						style="color: rgb(192, 192, 192)"></span> <span>状态:<span
						class="agentbar txtStatus" id="txtStatus"
						style="color: rgb(217, 83, 79); display: inline-block;"></span></span> <span><span
						id="statusTime" class="statusTime"
						style="color: rgb(217, 83, 79); display: inline-block;">00:00:00</span></span>
					<button class="btn-soft checkin" id="checkin" disabled="disabled">签入</button>
					<button class="btn-soft answerCall" id="answerCall"
						disabled="disabled">挂机</button>
					<button class="btn-soft notReady" id="notReady" disabled="disabled">置忙</button>
					<button class="btn-soft holdCall" id="holdCall" disabled="disabled">保持</button>
					<button class="btn-soft consultCall" id="consultCall"
						disabled="disabled">咨询</button>
					<button class="btn-soft transferCall" id="transferCall"
						disabled="disabled">转接</button>
					<button class="btn-soft conferenceCall" id="conferenceCall"
						disabled="disabled">会议</button>
					<input type="hidden" id="hideNumber" />
					<!-- 拨号弹框按钮 -->
					<button type="button" class="btn-soft makeCall"
						data-container="body" data-toggle="popover"
						data-placement="bottom" data-html="text" id="makeCall"
						disabled="disabled"
						data-content="
						<div class='input-group' style='width:158px'>
							<div class='input-group-btn' id='showList'>
								<button type='button' class='btn btn-info dropdown-toggle' id='suffixdown'  style='height:37px;' data-toggle='dropdown'>选择</button>
								<ul class='dropdown-menu'>
									<li><a id='userdn' href='#'>分机</a></li>
									<li><a id='userid'href='#'>工号</a></li>
									<li><a id='userph' href='#'>外线</a></li>
								</ul>
							</div>
								<input type='text' class='form-control' id='number' style='height:37px;width:78px'/>
								<span class='input-group-addon'><span id='remakeCall' class='glyphicon glyphicon-phone-alt' style='color:rgb(51,93,200);'></span></span>
						</div>
						
					<script>
						$('#suffixdown').click(function(){
							var suffixClass=$('#showList').attr('class').trim();
							if(suffixClass=='input-group-btn'){
								$('#showList').addClass('open');
							}else{
								$('#showList').removeClass('open');
							}
							var number=$('#hideNumber').val();
							$('#number').val(number);			
						});
					$('#sendDTMF').popover('hide');
					$('.input-group-btn>.dropdown-menu li').click(function(){
						var test=$(this).children('a:eq(0)').text();
						$('.input-group-btn>.btn').text(test);
					})
					$('#remakeCall').click(function(){ 
						var nubmer=$('#number').val();
						var style=$('.input-group-btn>.btn').text().substring(0,2);
						if(nubmer){
							if(style=='分机'){
								console.log('进入'+style)
								style=1;
								agentBar.makeCall(1,nubmer,suffix);
							}else if(style=='工号'){
								console.log('进入'+style)
								style=2;
								agentBar.makeCall(2,nubmer,suffix);
							}else if(style=='外线'){
								console.log('进入'+style)
								style=3;
								agentBar.makeCall(3,nubmer,suffix);
							}else{
								f_alert('外拨类型错误')
							}
						}else{
							f_alert('请输入号码')
						}
						$('#makeCall').popover('hide');
					});
					</script>">外拨</button>

					<!-- 二次拨号弹框按钮 -->
					<button type="button" class="btn-soft secDialing sendDTMF"
						data-container="body" data-toggle="popover"
						data-placement="bottom" data-html="text" id="sendDTMF"
						disabled="disabled"
						data-content="
						<div class='input-group '>
							<span class='input-group-addon' >拨号</span>
							<input type='text' class='form-control' id='number' style='height:37px'/>
							<span class='input-group-addon'><span id='resendDTMF' class='glyphicon glyphicon-phone-alt' style='color:rgb(51,93,200);font-size:20px;'></span></span>
						</div>
					<script>
					$('#makeCall').popover('hide');
					$('#resendDTMF').click(function(){ 
						var nubmer=$('#number').val();
						console.log(nubmer);
						agentBar.makeCall(1,nubmer,'3002');
						$('#sendDTMF').popover('hide');
					});
					</script>">二次拨号</button>
					<!-- 本机分机号从session中获取 -->
					<button class="btn-soft survey" id="survey" disabled="disabled">满意度</button>
					<button class="btn-soft listenCall" id="listenCall"
						disabled="disabled" style="display: none">监听</button>
					<button class="btn-soft insertCall" id="insertCall"
						disabled="disabled" style="display: none">强插</button>
					<button class="btn-soft forceHangupCall" id="forceHangupCall"
						disabled="disabled" style="display: none">强拆</button>
					<button class="btn-soft forceLogout" id="forceLogout"
						disabled="disabled" style="display: none">强制签出</button>
					&nbsp;&nbsp;&nbsp;
				</div>
			</ul>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- 头部右侧，导航信息列表 -->
	<div class="information_top userInfo"
		style="z-index: 10; position: fixed; height: 50px">
		<ul class="infomation_up">
			<li class="logout"><a href="javascript:void(0);"
				onclick="logOut();" style="text-decoration: none;">&nbsp;&nbsp;<i
					class="icon-off"></i>退出
			</a></li>
			<li class="suffix_login">分机号：<span></span>
			</li>
			<li class="logout light-blue open showPersonList"
				style="position: relative"><span
				style="color: #428bca; text-decoration: none;">欢迎您：</span> <a
				style="text-decoration: none;" href="javascript:void(0);" >
					${userSession.userName}<i class="icon-caret-down"
					style="margin-left: 8px; font-size: 16px;"></i>
					    <input type="hidden" id="myname" value="${userSession.userName}">
			</a>&nbsp;|&nbsp;
				<ul
					class="hidden user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close"
					id="personList">
					<li><a href="javascript:void(0);" onclick="personalInfo();">
							<i class="icon-user"></i>个人信息
					</a></li>
					<li><a href="javascript:void(0);" onclick="queryScheduling();">
							<i class="icon-cog"></i>排班信息
					</a></li>
					<li><a href="javascript:void(0);" onclick="updatePWD();">
							<i class="icon-edit"></i>修改密码
					</a></li>
				</ul></li>


			<li class="logout"><a style="text-decoration: none;"
				href="javascript:void(0);" onclick="mainFile();"><i
					class="icon-home"></i>个人首页 | </a></li>
			<li title="${newNotice}条未读消息通知" id="title"><a id="bells"
				onclick="showNotice();" href="#" style="text-decoration: none;">
					<i id="bell"> <img src="<%=path%>/img/bell.png" width="15" />
				</i> <i id="bell2" style="display: none;"> <img
						src="<%=path%>/img/bellrun.gif" width="15" />
				</i> <span style="color: red; font-size: 12px" id="newNotice">(${newNotice}条未读)</span>
			</a>|</li>
			<div id="noticeList"></div>
		</ul>
	</div>

	<!-- 中间内容区域 -->
	<div id="main_Content">
		<div id="imgIs">
			<img src="../images/back_disabled1.png" class="image" />
		</div>
		<div id="mainJsp" class="hidden">
			<div class="main-contentJsp">
				<ul id="tabs" class="breadcrumbs_tab">
					<li class="current home"><a class="tab" id="020" href="#"
						rel="首页">导航页</a>
						<div class="line"></div></li>
				</ul>
				<div id="contents">
					<!-- <div class="hidden" id="hiddenIframe"></div> -->
				</div>
			</div>
		</div>
	</div>
	<div id="modal_area"></div>
	<div class="noticeBotk">
		<div id="noticeClose">
			<span>&nbsp;通知提示</span>
			<button class="btn btn-xs" id="adclose">
				<i class="icon-remove"></i>
			</button>
		</div>
		<div id="noticeBottomad" class="noticeBotts">
			<a id="noticeContentOfMain" href="javascript:void(0)"
				style="font-color: #428bca" onclick="viewEntity()"><div style='height: 15px'></div></a>
		</div>
	</div>
<%-- 	<div class="ace-settings-container" id="ace-settings-container"   onkeydown="keyLogin();">
		<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btns" title="暂无消息" style="background: green !important;">
			<i class="icon-cog bigger-150"></i>
		</div>

		<div class="ace-settings-box" id="ace-settings-box" style="padding:0px">
			<div class="row" style="margin:0px">
				<div class="kePublic" style="padding:0px">
    <div class="col-xs-9" style="padding:0px">
    <div style="padding:0px;width: 100%;">
    <input type="hidden" id="input-jid" value="${username}@172.16.8.253"> 
    <input type="hidden" id="input-pwd" value="123456">
        <div class="chatBox" style="margin:0px;border:0px;width: 100%;">
            <div class="chatLeft" style="width: 70%;">
                <div class="chat01">
                    <div class="chat01_title">
                        <ul class="talkTo" style="margin: 0px;">
                            <li><a href="javascript:;" id="title_userName"></a></li></ul>
                       
                    </div>
                    <div class="chat01_content" id="userInput">
                       
                    </div>
                </div>
                <div class="chat02">
                    <div class="chat02_title">
                        
                        <label class="chat02_title_t">
                            <a onclick="queryHistoryTalk()">聊天记录</a></label>
                        <div class="wl_faces_box">
                            <div class="wl_faces_content">
                                <div class="title">
                                    <ul>
                                        <li class="title_name">常用表情</li><li class="wl_faces_close"><span>&nbsp;</span></li></ul>
                                </div>
                                <div class="wl_faces_main">
                                    
                                </div>
                            </div>
                            <div class="wlf_icon">
                            </div>
                        </div>
                    </div>
                    <div class="chat02_content">
                        <div id="input-msg" style="resize:none;">
                        </div>
                    </div>
                    <div class="chat02_bar">
                        <ul>
                            <li style="right: 5px; top: 5px;" id="btn-send"><a href="javascript:;">
                                <img src="../img/send_btn.jpg"></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="chatRight" style="width: 30%;">
                <div class="chat03">
                    <div class="chat03_title">
                        <label class="chat03_title_t"> 成员列表</label>
                        <input type="hidden" id="input-contacts">
                    </div>
                    <div class="chat03_content" style="margin-top: 0px;overflow-y: auto;max-height: 377px;min-height: 377px;">
                        <ul id="userList">
                            
                         </ul>
                    </div>
                </div>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        </div>
    </div>
    <div class="col-xs-3" style="padding:0px">
    
    <div class="widget-box" id="org_tree" style="margin: 0px;">
						<div class="widget-header widget-header-flat" style="min-height: 28px;background: url(../img/title_bg.jpg) repeat-x 0 0;">
							<input  value="" type="text" name="tree_name" id="tree_name" style="height: 28px;margin: 0px 5px;padding:0 10px;width:70%" />
							<input id="id" name="id" type="hidden" />
							<a onclick="searchNode();" href="javascript:;" title="搜索">
								<i class="icon-search bigger-120"></i>
							</a>
							<input id="org_id" name="org_id" type="hidden" />
							<input id="org_name" name="org_name" type="hidden" />
						</div>
						<div class="widget-body">
							<div class="widget-main" style="padding-left:0px;padding-right:5px;overflow-y:auto;overflow-x:hidden;max-height:377px;height: 377px;padding:0px;">
								<div id="tree3" class="tree3 tree-selectable"></div>
							</div>
						</div>
					</div>
    </div>
</div>
			</div>
		</div>
	</div> --%>
	<!--存放ajax-error错误返回的登录界面html  -->
	<div id="readyState" class="hidden"></div>
	<div id="clientURl" class="hidden"><%=path%></div>
	<div class="hidden" id="hiddenIframe"></div>
	<!-- 外部应用js -->
	<script src="<%=path%>/js/bootstrap-treeview.js"></script>
	<script src="<%=path%>/js/bootstrap.min.js"></script>
	<script src="<%=path%>/js/sockjs.min.js"></script>
	<script src="<%=path%>/js/stomp.min.js"></script>
	<script src="<%=path%>/js/framework_pubFunction.js"></script>
	<script src="<%=path%>/js/ace-elements.min.js"></script>
	<script src="<%=path%>/js/ace.min.js"></script>
	<script src="<%=path%>/js/xcConfirm.js"></script>
	<!--panxiaoqiang-->
	<script src="<%=path%>/ipcc/js/html5shiv.min.js"></script>
	<script src="<%=path%>/ipcc/js/respond.min.js"></script>
	<script src="<%=path%>/ipcc/js/moment.min.js"></script>
	<script src="<%=path%>/js/popbox/jquery.popbox.js"></script>
	<script src="<%=path%>/ipcc/js/socket.io.js"></script>
	<script src="<%=path%>/ipcc/js/socket.io.min.js"></script>
	<script src="<%=path%>/ipcc/js/agent-client.js"></script>
	<script src="<%=path%>/ipcc/js/agent-toolbar.js"></script>
	<script src="<%=path%>/js/popbox/poptype/popup.js"></script>
	<script src="<%=path%>/js/mainPage/slide.js"></script>
	<script src="<%=path%>/js/sockjs.min.js"></script>

<%--	<script src="<%=path%>/js/bootstrap-treeview.js"></script> 
 	<script src="<%=path%>/js/openfire.js"></script>
	<script src="<%=path%>/js/strophe.js"></script>
	<script src="<%=path%>/js/strophe.min.js"></script> --%>
	<script src="<%=path%>/js/date-time/laydate.js" ></script>
	<script type="text/javascript" charset="UTF-8" src="<%=path%>/js/mainPage/main.js"></script>
<%-- 	<script src="<%=path%>/js/wangEditor.min.js"></script> --%>
	<script src="<%=path%>/ipcc/js/moment.min.js"></script>
	<script src="<%=path%>/monitor/js/socket.io.min.js" ></script>
	<script src="<%=path%>/monitor/js/monitor-client.js"></script>
	<script type="text/javascript">
	var cPh ='${pageContext.request.contextPath}';

	var userId = '${userSession.userId}';
	var array=new Array();

	 jQuery(function($) {
		var data = ${orgTrees};
		/*组织机构树的显示*/
		$('#tree3').treeview({
		      data:data,
			  levels: 2,
			  showCheckbox: false,
			  showIcon: true,
			  showTags:true,
			  highlightSelected:true,
			  multiSelect :false
		});
		$('#tree3').on('click', function (evt, data) {
			setHash('${pageContext.request.contextPath}');
		});
		/*组织机构树的点击节点事件*/
		 $('#tree3').on('nodeSelected', function(event, data) {
			var id=data.org_id;
			$("#org_id").val(id);
			$("#org_name").val(data.text);
			viewEntity(id);
	    });
		setHash('${pageContext.request.contextPath}');
	});  

	//组织机构搜索功能
	/*  function searchNode(){
		var name = $('#tree_name').val()
		$('#tree3').treeview('search', [ name, {
			  ignoreCase: true,     // case insensitive
			  exactMatch: false,    // like or equals
			  revealResults: true,  // reveal matching nodes
			}]);
		 setHash('${pageContext.request.contextPath}');
		return ;
	};  */

	 /* var timeoutNotices = null;
	 function viewEntity(id){
			var param={};
			param["orgId"]=id;
			$.post("queryOrgUserList.do", param, function(result) {
				var users = "";
				debugger;
				var i=0;
				if(result!=null&&result.userList!=null&&result.userList.length>0){
				for(;i<result.userList.length;i++){
					if(array.length>0){
						for(var n=0;n<array.length;n++){
							if(result.userList[i].loginId==array[n].split(":")[2]){
								 if(result.userList[i].ofl==1){
										if(result.userList[i].picture==null){
											users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"');><label  id='"+result.userList[i].loginId+"_li' class='online'></label><a href='javascript:;'><img src='../img/2016.jpg'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"("+array[n].split(":")[1]+")</a></li>";	
										}else{
											users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"'); ><label  id='"+result.userList[i].loginId+"_li' class='online'></label><a href='javascript:;'><img src='"+result.userList[i].picture+"'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"("+array[n].split(":")[1]+")</a></li>";
										}
								 }else{
										if(result.userList[i].picture==null){
												users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"');><label  id='"+result.userList[i].loginId+"_li' class='offline'></label><a href='javascript:;'><img src='../img/2016.jpg'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"("+array[n].split(":")[1]+")</a></li>";	
										}else{
												users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"'); ><label id='"+result.userList[i].loginId+"_li'  class='offline'></label><a href='javascript:;'><img src='"+result.userList[i].picture+"'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"("+array[n].split(":")[1]+")</a></li>";
											}
								 }
							}else{
								if(result.userList[i].ofl==1){
									if(result.userList[i].picture==null){
										users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"');><label  id='"+result.userList[i].loginId+"_li' class='online'></label><a href='javascript:;'><img src='../img/2016.jpg'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";	
									}else{
										users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"'); ><label  id='"+result.userList[i].loginId+"_li' class='online'></label><a href='javascript:;'><img src='"+result.userList[i].picture+"'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";
									}
							 }else{
									if(result.userList[i].picture==null){
											users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"');><label  id='"+result.userList[i].loginId+"_li' class='offline'></label><a href='javascript:;'><img src='../img/2016.jpg'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";	
									}else{
											users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"'); ><label id='"+result.userList[i].loginId+"_li'  class='offline'></label><a href='javascript:;'><img src='"+result.userList[i].picture+"'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";
										}
							 }
							}
						}
					}else{
						if(result.userList[i].ofl==1){
							if(result.userList[i].picture==null){
								users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"');><label  id='"+result.userList[i].loginId+"_li' class='online'></label><a href='javascript:;'><img src='../img/2016.jpg'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";	
							}else{
								users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"'); ><label  id='"+result.userList[i].loginId+"_li' class='online'></label><a href='javascript:;'><img src='"+result.userList[i].picture+"'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";
							}
					 }else{
							if(result.userList[i].picture==null){
									users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"');><label  id='"+result.userList[i].loginId+"_li' class='offline'></label><a href='javascript:;'><img src='../img/2016.jpg'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";	
							}else{
									users = users+"<li onclick=sendUser('"+result.userList[i].loginId+"','"+result.userList[i].userName+"'); ><label id='"+result.userList[i].loginId+"_li'  class='offline'></label><a href='javascript:;'><img src='"+result.userList[i].picture+"'></a><a href='javascript:;' class='chat03_name'>"+result.userList[i].userName+"</a></li>";
								}
					 }
					}
				}
			}
				$("#userList").html(users);
				setHash('${pageContext.request.contextPath}');
				});
			if(timeoutNotices!=null){
				clearInterval(timeoutNotices);
			}
			 timeoutNotices = setInterval("flush()",10000); 
		};
 */


		jQuery(".picScroll").slide({
			mainCell : "ul",
			autoPlay : false,
			effect : "left",
			vis : 4,
			scroll : 1,
			autoPage : true,
			pnLoop : false
		});
		var size = $(".tempWrap ul li").size();
		if (size == "1") {
			var a = '${portalList}';
			var array = new Array();
			<c:forEach items='${portalList}' var="portalList">
			array.push('${portalList.portal_id}');
			array.push('${portalList.portal_name}');
			array.push('${portalList.portal_sign}');
			</c:forEach>
			var portal_id = array[0];
			var portal_name = array[1];
			var portal_sign = array[2];
			toPortal.init(portal_id, portal_name, portal_sign);
		}

		/***********ipcc控制层*************/
		var userNub = '${userSession.jobNumber}'; //坐席工号(不可变动)
		var skillId = null; //技能ID 
		var skillNe = null; //技能
		var checkeStatus = null; //签入标识
		var userNm = '${userSession.userName}'; //座席姓名
		var userNu = '${userSession.jobNumber}'; //坐席工号，可以变动
		var monitorSuffix = "${userSession.suffix}"; //监控坐席分机号
		var suffix = null; //坐席分机号12
		var skillCo = ""; //技能编号；
		var arrayBusy = new Array(); //置忙原因数组，用于初始化；
		var busyList = eval('${busyList}'); //后台获取忙碌原因json数组；
		var valueArray = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
				"10" ]; //配置原因的序号，通过循环确定表格位置；
		var count = 0; //原因顺序标识；
		var audioUrl = '${ipccCfgUrlInfo[0].ipcc_record}'; //音频地址1
		var ipccMonitorUrl = '${ipccCfgUrlInfo[0].ipcc_monitor}'; //监控地址
		var monitorSkill = '${ipccCfgUrlInfo[0].monitor_skill}'; //监控技能；
		var ipccLoginUrl = '${ipccCfgUrlInfo[0].ipcc_login}'; //ipcc签入代理地址；
		var jsonskill = eval('${jsonskillList}');
		var skillNameDesktop=null;
		//挂机标识
		var holdType = '02';
		//监控iframe数据对象
		var hiddenIframeParameter = {};
		//固定参数；
		var ipccParameterObj = {};
		/**
		 *ipcc设置初始化参数
		 */
		$(function() {
			for (var j = 0; j < valueArray.length; j++) {
				for (var i = 0; i < busyList.length; i++) {
					if (busyList[i]['busyValue'] == valueArray[j]) {
						arrayBusy[count] = busyList[i]['busyName'];
						count += 1;
					}
				}
			}
			ipccParameterObj["proxyUrl"] = '${ipccCfgUrlInfo[0].ipcc_login}';
			ipccParameterObj["arrayBusy"] = arrayBusy;
			ipccParameterObj["userNu"] = '${userSession.jobNumber}';
			ipccParameterObj["audioUrl"] = '${ipccCfgUrlInfo[0].ipcc_record}';
			ipccParameterObj["answerUrl"] = '${ipccCfgUrlInfo[0].answerUrl}';
			ipccParameterObj["hangupUrl"] = '${ipccCfgUrlInfo[0].hangupUrl}';
			ipccParameterObj["ivrDn"] = '${ipccCfgUrlInfo[0].ivrDn}';
			ipccParameterObj["dialPrefix"] = '${ipccCfgUrlInfo[0].dialPrefix}';
			//设置参数；
			setIpccParameter(ipccParameterObj);
		})
		
	 /*    var E = window.wangEditor;
        var editor = new E('#input-msg');
        // 或者 var editor = new E( document.getElementById('#editor') )
        editor.customConfig.uploadImgShowBase64 = true;
        editor.customConfig.menus = [
									'image',
                                 ]
        editor.create()  */

	
	function fullDiv(url){
		var height=$(window).height()-120;
	    $.post(url,function(content){
	    	openDialogNobutton("话术操作",content,"100%",height,'','',function(){
	    	},true);
		}); 
	}
        
    //子坐席工号
    var childUserNub=null;
   	//定义坐席状态
   	var agentsStatu = null;
    //定义坐席状态
    var monitorClientWq = null;
     monitorClientWq = new MonitorClient({
    	url: ipccMonitorUrl,
    	success: function() {
    		monitorClientWq.subscribe({
            	topic: 'A02',
	            params: {"agent_id":childUserNub},
	            success: function(data) {
	            	if(data.rows.length!=0){
	            		agentsStatu = data;
	            		operaterForFmsSystem22(childUserNub);
	            	}
		    	},
			    error: function(data) {
			         console.log(data);
			    }
		    });
		},
    	error: function() {
        	alert('监控服务连接失败！');
    	}
    });
     
     function operaterForFmsSystem(userNu){
    	childUserNub = userNu;
 		monitorClientWq.start();
     }

	</script>
</body>
	<script src="<%=path%>/ipcc/js/htIpcc.js"></script>
</html>

