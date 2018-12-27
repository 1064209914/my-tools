
var userId = '${userSession.userId}';
var BOSH_SERVICE = 'http://172.16.8.253:5280/http-bind/';

// XMPP连接
var connection = null;

// 当前状态是否连接
var connected = false;
var tree ="[";
// 当前登录的JID
var jid = "";
var users="";
// 连接状态改变的事件
function onConnect(status) {
    console.log(status)
    if (status == Strophe.Status.CONNFAIL) {
    	console.log("连接失败！");
    } else if (status == Strophe.Status.AUTHFAIL) {
    	console.log("登录失败！");
    } else if (status == Strophe.Status.DISCONNECTED) {
    	console.log("连接断开！");
        connected = false;
    } else if (status == Strophe.Status.CONNECTED) {
    	 console.log("连接成功，可以开始聊天了！");
        connected = true;
        // 当接收到<message>节，调用onMessage回调函数
        connection.addHandler(onMessage, null, 'message', null, null, null);
        
        // 首先要发送一个<presence>给服务器（initial presence）
        connection.send($pres().tree());
    }
}
var fromUser="from";
// 接收到<message>
function onMessage(msg) {
    // 解析出<message>的from、type属性，以及body子元素
    var from = msg.getAttribute('from').split("@");
    var type = msg.getAttribute('type');
    var elems = msg.getElementsByTagName('body');

    if (type == "chat" && elems.length > 0) {
    	debugger;
        var body = elems[0];
        var body1 = Strophe.getText(body);
        body1 = Strophe.getText(body).replace(/&lt;/g,"<");
        body1 = body1.replace(/&gt;/g,">");
        body1 = body1.replace(/&quot;/g,'"');
        if($("#"+from[0]+"_input").length>0){
        	  $("#"+from[0]+"_input").append("<span class='"+from[0]+"_fromName' style='color:red'>"+fromUser+" "+getNowFormatDate()+"</span>" + "" + body1 + "").append("<hr style='margin-top:5px;margin-bottom:5px;' />");
        	  var div =  document.getElementById(from[0]+"_input");
        	  div.scrollTop =div.scrollHeight;
		}else{
			$("#userInput").append("<div class='message_box userInput' id='"+from[0]+"_input"+"'>"+"<span class='"+from[0]+"_fromName' style='color:red' >"+fromUser+" "+getNowFormatDate()+"</span>" + "" + body1 + ""+"<hr style='margin-top:5px;margin-bottom:5px;' /></div>");

		}
        
        if($("#"+from[0]+"_input").is(':hidden')){
        	changeTitle(from[0]);
        	$("#ace-settings-btns").attr("style","#ffb44b !important");
        }
    }
    return true;
}

$(document).ready(function() {

    // 通过BOSH连接XMPP服务器
        if(!connected) {
            connection = new Strophe.Connection(BOSH_SERVICE);
            connection.connect($("#input-jid").val(), $("#input-pwd").val(), onConnect);
            jid = $("#input-jid").val();
        }
    
    // 发送消息
    $("#btn-send").click(function() {
        if(connected) {
            if($("#input-contacts").val() == '') {
                f_alert("请输入联系人！");
                return;
            }
            var bodys = editor.txt.html();
            // 创建一个<message>元素并发送
            var msg = $msg({
                to: $("#input-contacts").val(), 
                from: jid, 
                type: 'chat'
            }).c("body", null, bodys);
            connection.send(msg.tree());
            var userInput =$("#input-contacts").val().split("@")[0];
            $("#"+userInput+"_input").append("<span style='color:blue'>"+ $("#myname").val()+" "+getNowFormatDate()+"</span>" + "&nbsp;" +bodys + "<hr style='margin-top:5px;margin-bottom:5px;' />");
            editor.txt.clear();
            debugger;
            var div =  document.getElementById("userInput");
            div.scrollTop = div.scrollHeight;
        } else {
            f_alert("请先登录！");
        }
    });
    
});


		function flush(){
			debugger;
			var param={};
			param["orgId"]=$("#org_id").val();
			$.post("queryOrgUserList.do", param, function(result) {
				if(result!=null&&result.userList!=null&&result.userList.length>0){
					debugger;
					var i=0;
					$(".online").each(function (){
						$(this).attr("class","offline");
					})
					for(;i<result.userList.length;i++){
						if($("#"+result.userList[i].loginId+"_li")!=undefined){
							if(result.userList[i].ofl==1){
								$("#"+result.userList[i].loginId+"_li").attr("class","online");
							}
						}
					}
				}
			})
		}
	var otherLoginId = "";
	function sendUser(loginId,username){
		
		$("#"+loginId+"_li").parent().css("background-color","#428bca");
		$("#"+loginId+"_li").parent().siblings().css("background-color","");
		otherLoginId = loginId;
		fromUser = username;
		debugger;
		$("#title_userName").html(username);
		$("#input-contacts").val(loginId+"@172.16.8.253");
		$(".userInput").hide();
		debugger;
		if($("#"+loginId+"_input").length>0){
			$("#"+loginId+"_input").show();
			debugger;
			$("."+loginId+"_fromName").each(function (){
				debugger;
				var user = $(this).html().split(" ");
				$(this).html(username+" "+user[1]+" "+user[2]);
			})
		}else{
			$("#userInput").append("<div class='userInput' id='"+loginId+"_input"+"'></div>");	
		}
		var title="暂无消息";
		if(array.length>0){
			for(var i=0;i<array.length;i++){
				var login = array[i].split(":")[2];
				if(login==loginId){
					if(array.length>1){
					array.splice(i,1);
					}else{
						array= new Array();
						$("#ace-settings-btns").attr("style","background: green !important");
					}
					break;
				}
			}
		}
		if(array.length>0){
			title= "";
			for(var i=0;i<array.length;i++){
				title=title+array[i].split(":")[0]+":"+array[i].split(":")[1]+" \n";
			}
		}
		$("#ace-settings-btns").attr("title",title);
		$("#"+loginId+"_li").siblings(".chat03_name").html(username);
		
	}
	
	var opens=1;
		$("#ace-settings-btns").click(function(){
			if(opens==1){
				$("#ace-settings-box").addClass("open");
				$("#ace-settings-btn").addClass("open");
				opens=0;
			}else{
				$("#ace-settings-box").removeClass("open");
				$("#ace-settings-btn").removeClass("open");
				opens=1;
			}
		})
	//获取当前时间
	function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    var hour = date.getHours();
	    var minute = date.getMinutes();
	    var second = date.getSeconds();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    if (hour >= 0 && hour <= 9) {
	    	hour = "0" + hour;
	    }
	    if (minute >= 0 && minute <= 9) {
	    	minute = "0" + minute;
	    }
	    if (second >= 0 && second <= 9) {
	    	second = "0" + second;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + hour + seperator2 + minute + seperator2 + second;
	    return currentdate;
	}

		function changeTitle(loginId){
			debugger;
			var not="";
			var param={};
			param["login_id"]=loginId;
			$.post("getUserName.do", param, function(result) {
				debugger;
				var fname=result.username;
				if(array.length>0){
					var change=0;
					for(var i=0;i<array.length;i++){
						var name= array[i].split(":")[0];
						if(name==fname){
							array[i]=fname+":"+(parseInt(array[i].split(":")[1])+1)+":"+loginId;
							not=parseInt(array[i].split(":")[1]);
							change=1;
							break;
						}
					}
					if(change==0){
						array.push(fname+":1:"+loginId);
						not=1;
					}
				}else{
					array.push(fname+":1:"+loginId);
					not=1;
				}
				var title="";
				for(var i=0;i<array.length;i++){
					title=title+array[i].split(":")[0]+":"+array[i].split(":")[1]+" \n";
				}
				$("#ace-settings-btns").attr("title",title);
				
				if($("#"+loginId+"_li")!=undefined){
					$("#"+loginId+"_li").siblings(".chat03_name").html(fname+"("+not+")")
				}
				
				
			})
		}
	
	var countStart = 0;
	function queryHistoryTalk() {
		debugger
		var url = 'queryUserHistoryList.do';
		if(otherLoginId == null || otherLoginId =="") {
			f_alert("请选择要查询对象");
			return;
		}
		$.post(url,function(content){
			backDialog("聊天记录",content,480,300,function save(){
				countStart = 0;
			});
		})
	}

	function queryMoreHistoryTalk() {
		debugger
		var otherName = fromUser;
		var otherId = otherLoginId + "@172.16.8.253";
		var temp = {};
		temp["otherName"]=otherName;
		temp["otherId"]=otherId;
		temp["countStart"]=countStart;
		temp["countEnd"]=10;
		countStart += 10;
		$.post('queryUserHistoryList1.do',temp,function(data) {	
			debugger;
			if(data.msg == '0') {
				$("#aClick").remove();
				$("#appendDiv").prepend("<div style='margin-top:-8px;margin-bottom:10px;text-align:center;'><span style='color:green;'>无更多聊天记录</span></div>");
			} else {
			var tempcoutent = "";
			if(data.userHistoryList != null){
	    		$.each(data.userHistoryList,function(i,item){
	    			tempcoutent +="<div id="+item.messageId+"style='min-height:50px;'>";
	    			if(item.direction == "from") {
	    				tempcoutent += "<span style='color:blue;'>" +data.withName+""+item.time+"</span><br/>";
	    			}
	    			if(item.direction == "to") {
	    				tempcoutent += "<span style='color:red;'>" +data.ownerName+"&nbsp;"+item.time+"</span><br/>";
	    			}
	    			tempcoutent += "<span>"+item.body+"</span><hr style='margin-top: 5px; margin-bottom: 5px;' />";
	    			$("#appendDiv").prepend(tempcoutent);
	    			tempcoutent="";
	    		});
			}
			}
		});
	}
	function keyLogin(){
		if (event.ctrlKey&&event.keyCode==13){  //回车键的键值为13
		        if(connected) {
		            if($("#input-contacts").val() == '') {
		                f_alert("请输入联系人！");
		                return;
		            }
		            var bodys = editor.txt.html();
		            // 创建一个<message>元素并发送
		            var msg = $msg({
		                to: $("#input-contacts").val(), 
		                from: jid, 
		                type: 'chat'
		            }).c("body", null, bodys);
		            connection.send(msg.tree());
		            var userInput =$("#input-contacts").val().split("@")[0];
		            debugger;
		            $("#"+userInput+"_input").append("<span style='color:blue'>"+ $("#myname").val()+" "+getNowFormatDate()+"</span>" + "<br>&nbsp;" +bodys + "<br><hr style='margin-top:5px;margin-bottom:5px;' />");
		            editor.txt.clear();
		            var div =  document.getElementById(userInput+"_input");
		            div.scrollTop = div.scrollHeight;
		        } else {
		            f_alert("请先登录！");
		        }
		    }
	}
