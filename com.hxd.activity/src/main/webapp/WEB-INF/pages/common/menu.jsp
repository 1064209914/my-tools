<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="<%=path%>/css/font-awesome.min.css" />
	<link rel="stylesheet" href="<%=path%>/css/ace.min.css" />
	<link rel="stylesheet" href="<%=path%>/css/ace-rtl.min.css" />
	<link rel="stylesheet" href="<%=path%>/css/ace-skins.min.css" />
	<link rel="stylesheet" href="<%=path%>/css/jquery-ui-1.10.3.full.min.css" />
	<link rel="stylesheet" href="<%=path%>/css/tablePannel/tablePannel.css" />
	<link rel="stylesheet" href="<%=path%>/css/xcConfirm.css" />
	<script src="<%=path%>/js/ace-extra.min.js"></script>
</head>
<div>
	<input type="hidden" id="path"  name="path" value="<%=path %>"/>
</div>
<script type="text/javascript">
		window.jQuery|| document.write("<script src='<%=path%>/js/jquery-2.0.3.min.js'>" + "<"+"script>");
	</script>
<script type="text/javascript">
		var $assets = "assets";//this will be used in fuelux.tree-sampledata.js
	</script>
<script type="text/javascript">
	if ("ontouchend" in document)document.write("<script src='<%=path%>/js/jquery.mobile.custom.min.js'>"+ "<"+"script>");
</script>
<script src="<%=path%>/js/ace.min.js"></script>
<script src="<%=path%>/js/framework_menu.js"></script>
<script src="<%=path%>/js/framework_pubFunction.js"></script>
<script src="<%=path%>/js/fuelux/data/fuelux.tree-sampledata.js"></script>
<script src="<%=path%>/js/fuelux/fuelux.tree.min.js"></script>
<script src="<%=path%>/js/xcConfirm.js"></script>
<script type="text/javascript">
	jQuery(function($) {
		//对访问菜单的控制
		var flag=false;
		var obj = ${menuTree};
		var url="#";
		//生成菜单并增加选中菜单样式
		initMenu('${pageContext.request.contextPath}', obj);
		$("#menuTree a").click(function(){
			var menuId = $(this).attr("data-menuId");
			var systerm_id = $(this).attr("data-sysId");
			var systerm_url = "<%=baseUrl%>";
			//var url = $(this).attr("href");
			//通过menuId获取URL
			 $.ajax({
				type : "POST",
				url : "<%=path%>/mvc/getURL.do",
				async : false,
				data:{"menu_id":menuId,"systerm_id":systerm_id},
				dataType:'json',
				success : function(data) {
					
					
					if(data.msg == "success"){
						url=data.url;
						if(url!="#"){
							if(url.indexOf('http')<0)
								url=systerm_url+url;
							flag=true;
						}
					}else{
						alert("操作超时");
						parent.parent.window.location.href='${pageContext.request.contextPath}'+'/';
					}
				},
				error : function(msg) {
					alert("操作超时");
					parent.parent.window.location.href='${pageContext.request.contextPath}'+'/';
				}
			});
			
			var menuName = $(this).attr("data-menuName");
			if(url != '#'){
				//tablePannel
			    addTab($(this),url,menuId,menuName);
			};
		});
	});

		function initNavbar() {
			//Menu roll start
			var owl = $("#owl-menu")
					.owlCarousel(
							{
								items : 6,
								itemsCustom : [ [ 0, 2 ], [ 320, 3 ],
										[ 550, 4 ], [ 768, 5 ], [ 970, 4 ],
										[ 1300, 5 ], [ 1600, 6 ] ],
								navigation : true,
								pagination : false,
								rewindNav : false,
								navigationText : [
										"<i class='fa fa-angle-left'></i>",
										"<i class='fa fa-angle-right'></i>" ],
								afterMove : function() {
									var prev = $(".about-carousel .owl-controls .owl-prev");
									var next = $(".about-carousel .owl-controls .owl-next");

									prev.css("display", "block");
									next.css("display", "block");

									if (prev.hasClass("disabled")) {
										prev.css("display", "none");
									}
									if (next.hasClass("disabled")) {
										next.css("display", "none");
									}
								}
							});
			var prev = $(".about-carousel .owl-controls .owl-prev");
			var next = $(".about-carousel .owl-controls .owl-next");
			
		}
		
		 jQuery(function($) {
			debugger;
			var height = $(window).height()-133;
			$("#menuTree").css("max-height",height);
			$("#menuTree").css("overflow-y","auto");
		})  
	</script>