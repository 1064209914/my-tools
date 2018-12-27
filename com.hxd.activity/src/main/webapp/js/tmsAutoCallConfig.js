$(function(){
	for(var i=0;i<25;i++){
		if(i<10) i="0"+i;
		if(i==$("#hidestarthour").val()){
			$("#startTimeHour").append("<option selected=selected>"+i+"</option>");
		}else{
			$("#startTimeHour").append("<option>"+i+"</option>");
		}
		if(i==$("#hideendhour").val()){
			$("#endTimeHour").append("<option selected=selected>"+i+"</option>");
		}else{
			$("#endTimeHour").append("<option>"+i+"</option>");
		}

	}
	for(var i=0;i<60;i++){
		if(i<10) i="0"+i;
		if(i==$("#hidestartminute").val()){
			$("#startTimeMinute").append("<option selected=selected>"+i+"</option>");
		}else{
			$("#startTimeMinute").append("<option>"+i+"</option>");
		}

		if(i==$("#hideendminute").val()){
			$("#endTimeMinute").append("<option selected=selected>"+i+"</option>");
		}else{
			$("#endTimeMinute").append("<option>"+i+"</option>");
		}
		
	}
	
	for ( var i = 1; i < 101; i++) {
		if(i==$("#hidesucc").val()){
			$("#succ").append("<option selected=selected>"+i+"</option>");
		}else{
			$("#succ").append("<option>"+i+"</option>");
		}
	}
	
	for ( var i = -100; i < 101; i++) {
		if(i==$("#hideparam").val()){
			$("#param").append("<option selected=selected>"+i+"</option>");
		}else{
			$("#param").append("<option>"+i+"</option>");
		}
	}
	

	function calcCallCount(idlenum,quenum,succ,param){
		return Math.floor((idlenum-quenum)/(succ/100)*(1+param/100));
	}
	var idlenum=$("#idlenum").val();
	var quenum=$("#quenum").val();
	var succ=$("#succ").find("option:selected").text();
	var param=$("#param").find("option:selected").text();
	$("#callCount").val(calcCallCount(idlenum,quenum,succ,param));
	
	$("#quenum").keyup(function(){
		var idlenum=$("#idlenum").val();
		var quenum=$("#quenum").val();
		if(isNaN(quenum)){
			 $(this).val("");
			 return;
		}
		var succ=$("#succ").find("option:selected").text();
		var param=$("#param").find("option:selected").text();
		$("#callCount").val(calcCallCount(idlenum,quenum,succ,param));
	});
	$("#succ").change(function(){			
		var idlenum=$("#idlenum").val();
		var quenum=$("#quenum").val();
		var succ=$("#succ").find("option:selected").text();
		var param=$("#param").find("option:selected").text();
		$("#callCount").val(calcCallCount(idlenum,quenum,succ,param));
	});
	$("#param").change(function(){		
		var idlenum=$("#idlenum").val();
		var quenum=$("#quenum").val();
		var succ=$("#succ").find("option:selected").text();
		var param=$("#param").find("option:selected").text();
		$("#callCount").val(calcCallCount(idlenum,quenum,succ,param));
	});
	
	
	$("#changeStatus").click(function(){
		var status=$("#status").val();
		var ipccId = $("#id").val();
		$.post("updateAutoCallConfig.do",{ipccId:ipccId,status:status},function(data){
			if(data.msg==null){
				f_success("调整成功！");
			}else{
				f_success("调整失败！");
			}
		});
	});
	$("#changeTime").click(function(){
		var startTime=$("#startTimeHour").val()+$("#startTimeMinute").val();
		var endTime=$("#endTimeHour").val()+$("#endTimeMinute").val();
		if(startTime>=endTime){
			f_alert("开始时间需小于结束时间");
			return;
		}
		var ipccId = $("#id").val();
		$.post("updateAutoCallConfig.do",{ipccId:ipccId,startTime:startTime,endTime:endTime},function(data){
			if(data.msg==null){
				f_success("调整成功！");
			}else{
				f_success("调整失败！");
			}
		});
	});
	$("#changeCount").click(function(){
		var quenum=$("#quenum").val();
		var succ=$("#succ").find("option:selected").text();
		var param=$("#param").find("option:selected").text();
		var ipccId = $("#id").val();
		if(quenum.trim()==""||quenum==null||quenum.length>5){
			f_alert("最大排队数不能为空，且最高5位数字！");
			return;
		}
		$.post("updateAutoCallConfig.do",{ipccId:ipccId,quenum:quenum,succ:succ,callParam:param},function(data){
			if(data.msg==null){
				f_success("调整成功！");
			}else{
				f_success("调整失败！");
			}
		});
	});

	$("#resetCallRate").click(function(){
		if($("#status").val()==1){
			f_alert("请先暂停自呼");
			return;
		}
		var ipccId = $("#id").val();
		 f_confirm("请先确保自呼已经暂停或停止,确定重置接通率吗？",function(){
			 $.post("resetCallRate.do",{ipccId:ipccId},function(data){
				 if(date.msg==null){
						f_success("重置成功！");
					}else{
						f_success("重置失败！");
					}
			 });
		 });		
	});	
	
});
function keyPress(){
	var keyCode=event.keyCode;
	if((keyCode>=48&&keyCode<=57)){
		event.returnValue=true;
	}else{
		event.returnValue=false;
	}
}