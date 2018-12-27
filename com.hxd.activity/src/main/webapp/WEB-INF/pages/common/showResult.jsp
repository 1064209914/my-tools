<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	</head>
	<body>
	<input class="hidden" type="hidden" name="exp" id="exp"  value="${exp}" />
	<input class="hidden" type="hidden" name="url" id="url"  value="${url}" />
	<script type="text/javascript">
	doit();
	function doit(){
		var exp = document.getElementById("exp").value;
		var url = document.getElementById("url").value;
		if(exp !=null && exp!=""){
			alert(exp);
			window.location.href=url;
		}else{
			window.location.href="<%=path%>/mvc/forwardIndex.do";
		}
	}
	</script>
	</body>
</html>
