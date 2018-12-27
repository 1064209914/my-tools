<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js" ></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<p>z这是测试界面</p>

<button id="save" >点击保存实体</button>
</body>
<script type="text/javascript">
$(function() {
	$("#save").click(function() {
		$.ajax({
	        type: "post",
	        url: "save.do",
	        data: {},
	        success: function (data) {
	        	if (data==null) {
	        	alert("保存成功！");	
				} 
	        }
	 	});
	})
})

</script>
</html>