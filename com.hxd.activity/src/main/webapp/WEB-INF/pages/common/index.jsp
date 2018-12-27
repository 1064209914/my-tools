<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<!--菜单  -->
	<jsp:include page="menu.jsp"></jsp:include>
<body>
	<div class="main-container" id="main-container" style="min-width: 1340px;">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed');
			} catch (e) {

			}
		</script>
		<div class="main-container-inner">
			<a class="menu-toggler" id="menu-toggler" href="#"> <span
				class="menu-text"></span>
			</a>
			<div class="sidebar" id="sidebar">
				<script type="text/javascript">
					try {
						ace.settings.check('sidebar', 'fixed');
					} catch (e) {
					}
				</script>
			
				 <ul class="nav nav-list">
					<li style="display: block;height: 38px;line-height: 36px;padding: 0 16px 0 12px;
								background-color: #f9f9f9;color: #585858;text-shadow: none !important;
								font-size: 17px;font-weight:bold;text-decoration: none;">
							 <i	class="icon-dashboard" ></i> 
							 <span> 控制台 </span>
					</li>
				
				</ul>

				<!-- 菜单 -->
				<ul class="nav nav-list" id="menuTree"  style="font-family: '微软雅黑';">
					<%-- <c:forEach items="${menuTree}" var="menuList">
						<li>
							<c:if test="${menuList.menu_url == '#' }">
								<a data-menuname="${menuList.menu_name }" data-menuid="${menuList.menu_id }" data-sysid="${menuList.systerm_id }" href="javascript:void(0);" class="dropdown-toggle">
									<span class="menu-text">${menuList.menu_name }</span>
									<b class="arrow icon-angle-down"></b>
								</a>
							</c:if>
							<c:if test="${menuList.menu_url != '#' }">
								<a data-menuname="${menuList.menu_name }" data-menuid="${menuList.menu_id }" data-sysid="${menuList.systerm_id }" href="javascript:void(0);">
									<span class="menu-text">${menuList.menu_name }</span>
								</a>
							</c:if>
							<c:if test="${menuList.nodes != '' }">
								<ul class="submenu">
									<c:forEach items="${menuList.nodes}" var="list">
										<li>
											<a data-menuname="${list.menu_name }" data-sysid="${list.systerm_id }" data-menuid="${list.menu_id }" href="javascript:void(0);">
												<span class="menu-text">${list.menu_name } </span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</c:if>
						</li>
					</c:forEach> --%>
						
				</ul>
				<!-- /.nav-list -->

				<div class="sidebar-collapse" id="sidebar-collapse" onclick="changeWidth()">
					<i class="icon-double-angle-left"
						data-icon1="icon-double-angle-left"
						data-icon2="icon-double-angle-right"></i>
				</div>

				<script type="text/javascript">
					try {
						ace.settings.check('sidebar', 'collapsed');
					} catch (e) {
						
					}
				</script>
			</div>
			<div class="main-content">
				<ul id="tabs" class="breadcrumbs_tab">
					<li class="current hidden home">
						<a class="tab" id="020" href="#" rel="首页">首页</a>
					<div class="line"></div>
				</ul>
				<div id="contents"></div>
			</div>
		</div>
		
	</div>
 	<a href="#top" id="toTop"></a> 
	<!-- <div id="modal_area"></div> -->
</body>
 <script src="<%=path%>/js/jquery.scrollToTop.min.js"></script>
 <script src="<%=path%>/js/bootstrap.min.js"></script>
 <script type="text/javascript">
     $(function() {
         $("#toTop").scrollToTop();
         var currentName = $("#desktop").text();
         if(currentName == "座席工作台"){
        	 $(".breadcrumbs_tab .home").removeClass("hidden");
        	 var url = "<%=path%>/mvc/querySeatInfoMain.do";
        	 $("#contents").append("<iframe id='loadMainContent 020_content' class='020_content' name='首页_iframe' frameborder='0'" +
      				"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
         }
         if(currentName == "电销工作台"){
        	 $(".breadcrumbs_tab .home").removeClass("hidden");
        	 var url = '${systemUrl}' + "loadHomePage.do?portal_id="+'${portal_id}';
        	 $("#contents").append("<iframe id='loadMainContent 021_content' class='020_content' name='首页_iframe' frameborder='0'" +
      				"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
         }
         if(currentName == "华拓催收"){
        	 $(".breadcrumbs_tab .home").removeClass("hidden");
        	 var url = '${systemUrl}' + "goCsMain.do?portal_id="+'${portal_id}';
        	 $("#contents").append("<iframe id='loadMainContent 022_content' class='020_content' name='首页_iframe' frameborder='0'" +
      				"marginheight='0' marginwidth='0' scrolling='yes' width='100%' onload='setHeight(this)' src='"+url+"'></iframe>");
         }
         if($(".sidebar-collapse").find("i").hasClass("icon-double-angle-right")){
     		$(".icon-dashboard").siblings("span").addClass("hidden");
     	}
         
    });
    function changeWidth(){
    	if($("#menuTree").css("overflow-y")!="auto"){
			$("#menuTree").css("max-height",height);
			$("#menuTree").css("overflow-y","auto");
    	}else{
    		$("#menuTree").css("max-height","none");
			$("#menuTree").css("overflow-y","");
    	}
    	if($(".sidebar-collapse").find("i").hasClass("icon-double-angle-left")){
    		if($(".icon-dashboard").siblings("span").hasClass("hidden")) return;
    		$(".icon-dashboard").siblings("span").addClass("hidden");
    	}
    	if($(".sidebar-collapse").find("i").hasClass("icon-double-angle-right")){
    		$(".icon-dashboard").siblings("span").removeClass("hidden");
    	}
    }
    
</script> 
<script type="text/javascript">
	var sidebarCollapse = $("#sidebar-collapse > i").attr("class");
	jQuery(function($) {
		debugger;
		if('${exp}'!=null &&'${exp}'!="" ){
			alert("操作超时");
			parent.window.location = "<%=path%>/mvc/forwardMain.do";
		}
		$(".bell").click(function(){
			$(".warning").toggle();
		});
	});
	function callBackfunction(obj) {
		loadMainContent.window.CallBackSubmit(obj);
	}

	function callBackfunction1(obj) {
		loadMainContent.window.CallBackSubmit1(obj);
	}
	
	//关闭当前页(提示)
	function closeTab(msg){
		var $li = $("#tabs li.current");
		var tabid = $li.find(".tab").attr("id");
		var contentname = tabid + "_content";
		$("." + contentname).remove();
		$li.remove();
		f_alert(msg);
		if ($("#tabs li.current").length == 0 && $("#tabs li").length > 0) {
            // find the first tab    
            var firsttab = $("#tabs li:first-child");
            firsttab.addClass("current");
            // get its link name and show related content
            var firsttabid = $(firsttab).find("a.tab").attr("id");
            $("." + firsttabid + "_content").show();
     }
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

	//管理员菜单按钮签入ipcc，需求已改，暂时不改；
	<%-- var menuNameOne=true;
	$(".submenu li").click(function(){
		//获取菜单
		var menuName=$(this).find("span").text().trim();
		//导航栏已存在菜单
		var menuExist=0;
		$(".breadcrumbs_tab li a").each(function(i){
			if($(this).text()=="综合预警"||$(this).text()=="座席监控"){
				menuExist+=1;
			}
		});
		//存在一个界面则签入，两个界面，则第二个界面不签入。没有界面则签入；
		if(menuExist<=1){
			if(menuName=="综合预警"||menuName=="座席监控"){
				$.getScript("<%=path%>/ipcc/js/cust_monitor.js");
				innitMonitor("${userSession.jobNumber}","${userSession.suffix}","${userSession.userName}",monitorSkill,ipccLoginUrl);
				console.log("11111");
			}
		}
	}); --%>
</script>
</html>

