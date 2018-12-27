<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
%>
<div id="content1">
	<div style="margin-top:2px;margin-bottom:10px;text-align:center;"><a id="aClick" datehref="" disababled="true" style="cursor:pointer;color:green" onclick="queryMoreHistoryTalk()">点击查看更多</a></div>
	
	<div id="appendDiv"></div>
	
</div> 

<script>
	queryMoreHistoryTalk();
</script>