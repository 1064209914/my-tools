<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<script src="<%=path%>/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
	pseth();
	function pseth() {
		var iObj = window.top.$("#loadMainContent");
		var locationHash = window.location.hash;
		if(locationHash.indexOf("?") != -1) {
			var params = locationHash.split("?");
			iObj.height(params[0].split("#")[1]);
		}else {
			iObj.height(locationHash.split("#")[1]);
		}
	}
</script>
