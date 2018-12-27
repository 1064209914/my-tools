<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<head>
<meta charset="utf-8" />
<title>客服呼叫中心管理平台</title>
<!-- BootStrap3全面支持移动平台：下行代码为默认情况下，UI布局的宽度和移动设备的快读移植，缩放大小为原始大小。 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- basic styles -->
<link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=path%>/css/font-awesome.min.css" />

<!--[if IE 7]>
		  <link rel="stylesheet" href="<%=path%>/css/font-awesome-ie7.min.css" />
		<![endif]-->

<!-- page specific plugin styles -->

<!-- fonts -->
<link rel="stylesheet" href="<%=path%>/css/ace-fonts.css" />
<!-- <link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" /> -->

<!-- ace styles -->

<link rel="stylesheet" href="<%=path%>/css/ace.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace-rtl.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace-skins.min.css" />
<link rel="stylesheet" href="<%=path%>/css/datepicker.css" />
<link rel="stylesheet" href="<%=path%>/css/bootstrap-timepicker.css" />
<link rel="stylesheet" href="<%=path%>/css/daterangepicker.css" />
<link rel="stylesheet" href="<%=path%>/css/jquery-ui-1.10.3.full.min.css" />

<!--[if lte IE 8]>
		  <link rel="stylesheet" href="<%=path%>/css/ace-ie.min.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler 
<script src="http://mpc.portal.com/socket.io/socket.io.js"></script>
-->

<script src="<%=path%>/js/ace-extra.min.js"></script>


<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
		<script src="<%=path%>/js/html5shiv.js"></script>
		<script src="<%=path%>/js/respond.min.js"></script>
		<![endif]-->
</head>
		<div class="navbar navbar-default" id="navbar">
		<!-- <div class="navbar navbar-default" id="navbar"> -->
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<small>
							<i class="icon-leaf"></i>
							客服呼叫中心管理平台
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
			<ul class="nav ace-nav">
						<!-- <li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-tasks"></i>
								<span class="badge badge-grey">4</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-ok"></i>
									4 Tasks to complete
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Software Update</span>
											<span class="pull-right">65%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:65%" class="progress-bar "></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Hardware Upgrade</span>
											<span class="pull-right">35%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:35%" class="progress-bar progress-bar-danger"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Unit Testing</span>
											<span class="pull-right">15%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:15%" class="progress-bar progress-bar-warning"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">Bug Fixes</span>
											<span class="pull-right">90%</span>
										</div>

										<div class="progress progress-mini progress-striped active">
											<div style="width:90%" class="progress-bar progress-bar-success"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										See tasks with details
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li> -->
<!-- 
						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important">8</span>
							</a>

							<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-warning-sign"></i>
									8 Notifications
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
												New Comments
											</span>
											<span class="pull-right badge badge-info">+12</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<i class="btn btn-xs btn-primary icon-user"></i>
										Bob just signed up as an editor ...
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success icon-shopping-cart"></i>
												New Orders
											</span>
											<span class="pull-right badge badge-success">+8</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-info icon-twitter"></i>
												Followers
											</span>
											<span class="pull-right badge badge-info">+11</span>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										See all notifications
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li> -->
<%-- 
						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-envelope icon-animated-vertical"></i>
								<span class="badge badge-success">5</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-envelope-alt"></i>
									5 Messages
								</li>

								<li>
									<a href="#">
										<img src="<%=path%>/avatars/avatar.png" class="msg-photo" alt="Alex's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Alex:</span>
												Ciao sociis natoque penatibus et auctor ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>a moment ago</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="#">
										<img src="<%=path%>/avatars/avatar3.png" class="msg-photo" alt="Susan's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Susan:</span>
												Vestibulum id ligula porta felis euismod ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>20 minutes ago</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="#">
										<img src="<%=path%>/avatars/avatar4.png" class="msg-photo" alt="Bob's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Bob:</span>
												Nullam quis risus eget urna mollis ornare ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>3:15 pm</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="inbox.html">
										See all messages
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li> --%>
			<%-- 			<li class="light-grey">
						<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<span class="">
								<c:if test="${userSession.userStatus == 0 }">
									<small id="userStatus">用户状态：未签到</small>
								</c:if>	
								<c:if test="${userSession.userStatus == 1 }">
									<small id="userStatus">用户状态：已签到</small>
								</c:if>	
								<c:if test="${userSession.userStatus == 2 }">
									<small id="userStatus">用户状态：已签离</small>
								</c:if>	
								</span>
							</a>
							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a>
										<i class="icon-user"></i>
										营业日期：${userSession.accDate}
									</a>
								</li>
								<li>
									<a >
										<i class="icon-cog"></i>
										机构编号：${userSession.branchNo}
									</a>
								</li>
								<li>
									<a>
										<i class="icon-user"></i>
										机构名称：${userSession.branchName}
									</a>
								</li> 
								<li>
									<a >
									</a>
								</li>
							</ul>
						</li> --%>
						
						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="<%=path%>/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									欢迎您,&nbsp;
									<small>${userSession.userName}&nbsp;</small>
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								
									<li>
									<a>
										营业日期：${userSession.accDate}
									</a>
								</li>
						<%-- 		<li>
									<a >
										机构编号：${userSession.branchNo}
									</a>
								</li>
								<li>
									<a>
										机构名称：${userSession.branchName}
									</a>
								</li>  --%>
								
							

								<!-- <li>
									<a href="javaScript:signOut()">
										<i class="icon-user"></i>
										签离
									</a>
								</li> -->

								<li class="divider"></li>
									<li>
									<a href="javaScript:toUpdatePwd()">
										<i class="icon-cog"></i>
										修改密码
									</a>
								</li>
								<li>
									<a href="javaScript:logOut()">
										<i class="icon-off"></i>
										签退
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div>
			</div><!-- /.container -->
		<!-- </div> -->
		</div>
		<!-- confirm区域 -->
		<div id="dialog-confirm" class="hide">
			<p class="bigger-110 bolder center grey">
				Are you sure?
			</p>
		</div>
		<div id="dialog-alert" class="hide">
			<p class="bigger-110 bolder center grey">
				alert
			</p>
		</div>
	<script type="text/javascript">
		window.jQuery|| document.write("<script src='<%=path%>/js/jquery-2.0.3.min.js'>" + "<"+"script>");
	</script>
	<script type="text/javascript">
		var $assets = "assets";//this will be used in fuelux.tree-sampledata.js
	</script>
	<!-- <![endif]-->

	<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='<%=path%>/js/jquery-1.10.2.min.js'>"+"<"+"script>");
</script>
<![endif]-->

	<script type="text/javascript">
		if ("ontouchend" in document)
			document
					.write("<script src='<%=path%>/js/jquery.mobile.custom.min.js'>"
							+ "<"+"script>");
	</script>
	<script src="<%=path%>/js/bootstrap.min.js"></script>
	<script src="<%=path%>/js/typeahead-bs2.min.js"></script>

	<!-- page specific plugin scripts -->

	<!--[if lte IE 8]>
		  <script src="<%=path%>/js/excanvas.min.js"></script>
		<![endif]-->

	<script src="<%=path%>/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="<%=path%>/js/jquery-ui-1.10.3.full.min.js"></script>
	<script src="<%=path%>/js/jquery.ui.touch-punch.min.js"></script>
	<script src="<%=path%>/js/jquery.slimscroll.min.js"></script>
	<script src="<%=path%>/js/jquery.easy-pie-chart.min.js"></script>
	<script src="<%=path%>/js/jquery.sparkline.min.js"></script>
	<script src="<%=path%>/js/flot/jquery.flot.min.js"></script>
	<script src="<%=path%>/js/flot/jquery.flot.pie.min.js"></script>
	<script src="<%=path%>/js/flot/jquery.flot.resize.min.js"></script>
	
	<!-- ace scripts -->

	<script src="<%=path%>/js/ace-elements.min.js"></script>
	<script src="<%=path%>/js/ace.min.js"></script>

	<!-- inline scripts related to this page -->
	<script src="<%=path%>/js/framework_menu.js"></script>
	<script src="<%=path%>/js/framework_pubFunction.js"></script>
	<script src="<%=path%>/js/fuelux/data/fuelux.tree-sampledata.js"></script>
	<script src="<%=path%>/js/ajaxfileupload.js"></script>
	<script src="<%=path%>/js/fuelux/fuelux.tree.min.js"></script>
	<script src="<%=path%>/js/framework_form.js"></script>
	<script src="<%=path%>/js/jquery.maskedinput.min.js"></script>
	<script src="<%=path%>/js/jquery.validate.min.js"></script>
	<script src="<%=path%>/js/date-time/bootstrap-datepicker.min.js"></script>
	<script src="<%=path%>/js/date-time/bootstrap-timepicker.min.js"></script>
	<script src="<%=path%>/js/date-time/moment.min.js"></script>
	<script src="<%=path%>/js/date-time/daterangepicker.min.js"></script>
	<script src="<%=path%>/js/bootbox.min.js"></script>
	<script src="<%=path%>/js/bootstrap-wysiwyg.min.js"></script>
    <script src="<%=path%>/js/markdown/markdown.min.js"></script>
	<script src="<%=path%>/js/markdown/bootstrap-markdown.min.js"></script>
	<script src="<%=path%>/js/jquery.hotkeys.min.js"></script>
	<script src="<%=path%>/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/js/jquery.dataTables.bootstrap.js"></script>
	<script type="text/javascript">
		jQuery(function($) {
			var obj = ${menuList};
			//生成菜单并增加选中菜单样式
			initMenu('${pageContext.request.contextPath}', obj);
			$("#menuTree a").click(function(){
				var menuId = $(this).attr("data-menuId");
				var url = $(this).attr("href");
				var menuName = $(this).attr("data-menuName");

				//异步刷新页面方法
			 	 if(url != '#'){
			 		//$("#loadPageContent").html("正在加载页面ing......");
			 		//异步刷新页面
			 		ajaxMenuLoadPage("#loadPageContent",url);
			 		//设置面包屑
			 		$("#breadCrumb").html("");
			 		$(this).parents().each(function(obj){
						if($(this).get(0).tagName=="LI"){
							$("#breadCrumb").prepend("<li>"+$(this).children().attr("data-menuName")+"</li>");
						}
					});
			 		$("#breadCrumb").prepend("<li><i class=\"icon-home home-icon\"></i> <a href=\"#\" onclick=\"toHomePage('<%=path%>/mvc/homePage.do');\">首页</a></li>");
					//清楚menuTree选中样式
					$("#menuTree li").each(function(index){
						if($(this).hasClass("open")){
							$(this).removeClass("open");
						}
						if($(this).hasClass("active")){
							$(this).removeClass("active");
						}
					});
					//收起所有打开的ul下的li标签
					$("#menuTree ul").each(function(index){
						$(this).css("display","none");
					});
					//选中的li添加样式
					var $li = $(this).parent();
					$li.addClass("active");
					$(this).parents().each(function(obj){
						if($(this).get(0).tagName="UL"){
							//打开当前ul下的li标签
							$(this).css("display","block");
						}
						if($(this).get(0).tagName=="LI"){
							$(this).addClass("active").addClass("open");
						}
					});
					return false;
				};  
				
			});
			

		});
		
		
		 function logOut(){
				$.ajax( {
					type : "POST",
					url : "<%=path%>/mvc/logOut.do",
					async : false,
					success : function(obj) {
						if(obj.expMsg != null){
						 	ncms_alert(obj.expMsg);
						}else{
							document.location.href="<%=path%>";
						}
					},
					error : function(msg) {
						ncms_alert("获取数据失败: " + msg);
					}
				});
			}	
		 function toUpdatePwd(){
			//重置面包屑
			$("#breadCrumb").html("");
			$("#breadCrumb").prepend("<li><i class=\"icon-home home-icon\"></i> <a href=\"#\" onclick=\"toHomePage('<%=path%>/mvc/homePage.do');\">首页</a></li>");
			//清楚menuTree选中样式
			$("#menuTree li").each(function(index){
				if($(this).hasClass("open")){
					$(this).removeClass("open");
				}
				if($(this).hasClass("active")){
					$(this).removeClass("active");
				}
			});
			//收起所有打开的ul下的li标签
			$("#menuTree ul").each(function(index){
				$(this).css("display","none");
			});
			$("#loadMainContent").attr("src", "<%=path%>/mvc/user_editPwd.do");
		 }
		 

		var socket = io.connect("http://mpc.portal.com");
		function sendMsg(userId) {
			socket.emit("tp.mc.channel.register", userId);
			socket.on("tp.mpc.channel.task.no.schedule", function(tpdata) {
				var params = JSON.stringify({
					"method" : "tp.kernel.task.add.tasks",
					"params" : [ {
						"task_level" : "0",
						"task_content" : "测试消息",
						"user_id" : "测试用户",
						"task_read_flag" : "1",
						"operator" : "操作员",
						"task_url" : "0",
						"task_url_type" : "0"
					} ],
					"id" : 1
				});
				$.ajax({
					type : "post",
					contentType : "application/json:charset=utf-8",
					url : "http://portal.smallpay.com/platform/openapi",
					data : params,
					success : function(data) {
						alert("success ! ");
					},
					error : function(data, status, e) {
						alert(data);
					}
				});
			});
		}
	</script>
</html>