<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=path%>/css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace-rtl.min.css" />
<link rel="stylesheet" href="<%=path%>/css/ace-skins.min.css" />
<link rel="stylesheet" href="<%=path%>/css/jquery-ui-1.10.3.full.min.css" />
<script src="<%=path%>/js/ace-extra.min.js"></script>
<link rel="stylesheet" href="<%=path%>/css/webchat/sdmenu.css" />
<div class="ace-settings-container" id="ace-settings-container">
	<div class="btn btn-app btn-xs ace-settings-btn btn-success" id="webchat_btn">
		<div class="infobox-icon">
			<i class="icon-comments"></i>
		</div>
		<span class="badge badge-pink" style="display: none;" id=new_message>+1</span>
	</div>
	<div class="ace-settings-box" id="ace-settings-box">
		<div class="row">
			<div class="left_box col-sm-4">
				<div class="widget-box ">
					<div class="widget-header" style="min-height: 20px !important;">
						<h4 class="lighter smaller" style="font-size: 16px">
							<i class="icon-user blue"></i> 联系人
						</h4>
					</div>
					<div class="widget-body">
						<div class="widget-main no-padding">
							<div id="webchat_left">
							
								<div id="tree_user" class="sdmenu">
									<!--联系人列表  -->
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="right_box col-sm-8">
				<div class="widget-box ">
					<div class="widget-header" style="min-height: 20px !important;">
						<h4 class="lighter smaller" style="font-size: 16px" id="liaotian">
							<i class="icon-comment blue"></i> 
								聊天窗口
						</h4>
						<div class="widget-toolbar">
							<a href="javascript:void(0)" onclick="closeWin()" style="font-weight: bold;">
								<i class="icon-minus"></i>
							</a>
						</div>
					</div>
					<div class="widget-body">
						<div class="widget-main no-padding">
							<div class="center" style="text-decoration: none;">
								<div id="webchat_top" style="height: 20px"></div>
							</div>
							<div class="dialogs" id="webchat_right">
								
								<div class="center blue" style="padding-top: 80px;" id="webchat_center">
									<!--消息列表  -->
										<h4>请选择联系人！</h4>
								</div>
							
							</div>
							<form name="send_form" id="send_form">
							<div class="form-actions">
								<div class="input-group">
									<input type="hidden"  id="userid" name="userid" value=""/>
									<input type="hidden"  id="username" name="username"  value=""/>
									<input type="hidden"  id="friendid" name="friendid"  value=""/>
									<input type="hidden"  id="friendname" name="friendname"  value=""/>
									<input placeholder="点击Ctrl+回车直接发送消息" type="text"
										class="form-control" name="message" id="message"/> <span
										class="input-group-btn">
										<button class="btn btn-sm btn-primary" type="button" onclick="sendMessage()">
											 发送
										</button>
									</span>
								</div>
							</div>
							</form>
						</div>
						<!-- /widget-main -->
					</div>
					<!-- /widget-body -->
				</div>
				<!-- /widget-box -->
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	window.jQuery|| document.write("<script src='<%=path%>/js/jquery-2.0.3.min.js'>" + "<"+"script>");
</script>
<script type="text/javascript">
	if ("ontouchend" in document)
		document.write("<script src='<%=path%>/js/jquery.mobile.custom.min.js'>" + "<"+"script>");
</script>
<script src="<%=path%>/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/typeahead-bs2.min.js"></script>
<script src="<%=path%>/js/jquery.slimscroll.min.js"></script>
<script src="<%=path%>/js/fuelux/data/fuelux.tree-sampledata.js"></script>
<script src="<%=path%>/js/fuelux/fuelux.tree.min.js"></script>
<script src="<%=path%>/js/sdmenu.js"></script>
<script src="<%=path%>/js/sockjs.min.js"></script>
<script src="<%=path%>/js/stomp.min.js"></script>
<script src="<%=path%>/js/ace-elements.min.js"></script>
<script src="<%=path%>/js/ace.min.js"></script>
<script type="text/javascript">
	$("#webchat_btn").click( function() {
		$(this).toggleClass("open");
		$("#ace-settings-box").toggleClass("open");
		$("#webchat_btn").find("#new_message").attr("style","display: none;");
		$("#webchat_btn").attr("style","display: none;");
	});
	//设置行业动态显示的高度
	$('#webchat_left').slimScroll({
		height: '351px',
		alwaysVisible : true
	});
	$('#webchat_right').slimScroll({
		height: '275px',
		alwaysVisible : true
	});
	function closeWin(){
		$("#webchat_btn").removeAttr("style");
		$("#webchat_btn").toggleClass("open");
		$("#ace-settings-box").toggleClass("open");
		$("#webchat_btn").find("#new_message").attr("style","display: none;");
	}
 </script>
<script type="text/javascript">
	//获取当前登录用户
	$("#userid").val('${userSession.userId}');
	$("#username").val('${userSession.userName}');
	//初始化联系人
	var myMenu = new SDMenu("tree_user");
	jQuery(function($){
		load_tree();
		myMenu.init();
	});
	//加载联系人数据
	function load_tree(){
	 	$.ajax({
			type : "POST",
			url : "<%=path%>/mvc/user_webchatList.do",
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == ""||data.msg==null){
					var obj=data.u_data;
					$(obj).each(function(index){
						 var $top = "<div id='"+obj[index].org_id+"'><span>"+obj[index].org_name+"</span>"
								// +"<a href='javascript:void(0)' onclick=\"click_friend('00000000','系统管理员')\" id='00000000'>系统管理员[请留言]</a>"
								 +"</div>";
						$(window.document).find("#tree_user").append($top); 
					});
				}else{
					error_msg("联系人加载失败："+data.msg);
				}
			},
			error : function(msg) {
				error_msg("联系人加载失败，请刷新重试！");
			}
		});
	}
	/****消息发送时间，可能需要改为服务器时间****/
    function msgDate(){
        //系统时间，需改为服务器时间
        var msgDate= new Date();
        var month=msgDate.getMonth()+1;//月
        var day=msgDate.getDate();//日
        var hh=msgDate.getHours();//时
        var mm=msgDate.getMinutes();//分
        var ss=msgDate.getSeconds();//秒
        var clock="";
        if(month<10){
        	clock+="0";
        }
        clock+=month+"-";
        if(day<10){
        	clock+="0";
        }
        clock+=day + " ";
        if(hh<10){
        	clock+="0";
        }
        clock+=hh +":";
        if(mm<10){
        	clock+="0";
        }
        clock+=mm +":";
        if(ss<10){
        	clock+="0";
        }
         clock+=ss;
         return clock;
    }
	
	var webSocketServerUrl="<%=path%>/wsk/WebSocket";
	var LoginData='${userSession.branchNo}'+"|"+'${userSession.userId}'+"|"+'${userSession.userName}';
	var stompClient = null;
	//建立与服务器连接
	connect();
	function connect() {
   		var subscribeMsgUser="/topic/"+$("#userid").val();//选择订阅的消息
        var socket = new SockJS(webSocketServerUrl);
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
        	    stompClient.subscribe(subscribeMsgUser, function(msg){//订阅接收的消息，并等待服务器返回消息，此部分只接收点对点会话消息
        	    	//如果聊天窗口没有被打开,则显示提示
        	    	if(!$("#webchat_btn").hasClass("btn btn-app btn-xs ace-settings-btn btn-success open")){
	        	    	$("#webchat_btn").find("#new_message").attr("style","display: block;");
	        	    	//将消息提示添加到朋友列表中
	       		    	$(window.document).find("#tree_user").find("#"+JSON.parse(msg.body).orgId).find("#"+JSON.parse(msg.body).from_userId).append("<i id=\"new_red_msg\" class=\"icon-circle red\" style=\"right: 30px;margin-top: 2px;position: absolute;\"></i>");
        	    	}else if(JSON.parse(msg.body).from_userId==$("#friendid").val() && 
        	    				JSON.parse(msg.body).userId==$("#userid").val()&&JSON.parse(msg.body).orgId=='${userSession.branchNo}'){
        	    		//如果当前正和朋友聊天则直接将消息推送窗口
        	    		setMessage($("#friendname").val(),JSON.parse(msg.body).message,msgDate());
        	    	}else{
	       	    		//将消息提示添加到朋友列表中
	       		    	$(window.document).find("#tree_user").find("#"+JSON.parse(msg.body).orgId).find("#"+JSON.parse(msg.body).from_userId).append("<i id=\"new_red_msg\" class=\"icon-circle red\" style=\"right: 30px;margin-top: 2px;position: absolute;\"></i>");
        	    	}
            	});
        	    
        	    stompClient.subscribe("/topic/notiyTask", function(msg){//通知客户端有任务提醒
        	    	/* {portalId:10223333333333,roleCode:1022} */
        	    	//判断当前角色是否和通知角色一致
        	    	var role='${role_code}';
        	    	var c_role=JSON.parse(msg.body).roleCode;
        	    	if(role.indexOf(c_role)>=0){
        	    		//判断客户经理编号是否为空如果不为空则显示给固定的客户经理
        	    		if(JSON.parse(msg.body).custManager==''||JSON.parse(msg.body).custManager==null||JSON.parse(msg.body).custManager=='undefined'){
		        	    	//将提醒推送到条线按钮，提示小铃铛
		        	    	$(window.document).find("ul").find("#"+JSON.parse(msg.body).portalId).find("#span").attr("style","display: block;");
        	    		}else{
        	    			if(JSON.parse(msg.body).custManager==$("#userid").val()){
        	    				//将提醒推送到条线按钮，提示小铃铛
    		        	    	$(window.document).find("ul").find("#"+JSON.parse(msg.body).portalId).find("#span").attr("style","display: block;");
        	    			}
        	    		}
        	    	}
                });

        	    stompClient.subscribe("/topic/loginOrOut", function(msg){//通知客户端有上线用户或下线用户
        	    	//msg,所有在线用户信息json串
        	    	var users=msg.body;
        	    	var user=users.split("|");
        	    	var org_id=user[0];
        	    	var user_id=user[1];
        	    	var user_name=user[2];
        	    	var isOnline=user[4];//是否上线0否1是
        	    	//&& user_id!=$("#userid").val()
        	    	if(isOnline=='0'){
        	    		$(window.document).find("#tree_user").find("#"+org_id).find("#"+user_id).remove();
        	    	}
					if(isOnline=='1'&& $("#"+user_id).length<=0 ){
						var $u = "<a href='javascript:void(0)' onclick=\"click_friend('"+user_id+"','"+user_name+"')\" id='"+user_id+"'>"+user_name+"</a>";
        	    		$(window.document).find("#tree_user").find("#"+org_id).append($u); 
					}
       	    		myMenu.init();
                });
        	    
        	    stompClient.subscribe("/app/userOnLine/"+LoginData);//通知服务端有新用户上线
        });
    }

	//点击联系人触发事件
    function click_friend(friendid,friendname){
		$("#friendid").val(friendid);
		$("#friendname").val(friendname);
		$("#liaotian").html("<i class='icon-comment blue'></i>与【"+friendname+"】聊天中...");
    	$(window.document).find("#tree_user").find("#"+friendid).find("#new_red_msg").remove();
		//获取最近10条聊天记录
		getMessage();
	}
	
	var msgMaxSize=200;//输入最大字符
	//发送消息
	function sendMessage(){
        var userid=$("#userid").val();
        var username=$("#username").val();
        var  friendid=$("#friendid").val();
        var friendname=$("#friendname").val();
        var message=$("#message").val();
		 //消息发送
        if(friendid==''||friendid==null){
        	error_msg("对不起，联系人不能为空！")
            return false;
        }
        else  if(message==''||message==null){
        	error_msg("对不起，消息不能为空！");
            return false;
        }else  if(message.length>msgMaxSize){
        	error_msg("对不起，您输入的字数不能超过【"+msgMaxSize+"】");
        	return false;
        }
        else{
          	//往窗口中输入消息
      	    setMyMessage(username,message,msgDate());
        	
          	setTimeout(function (){
	            //数据发送到服务器
	      	   stompClient.send("/app/talk", {},JSON.stringify({'sendDest':'toUser','userId':friendid,'from_userId':userid,'orgId':'${userSession.branchNo}','message': message }));
	            
	            //数据存储到数据库
	            setMessageToDataBase(userid,friendid,message,msgDate());

        	},1000);//控制1秒后才能发消息
           	//清空消息输入框
    	   $("#message").val("");
	   	   $("#message").focus();
        }
	}
	
	//ctrl+回车发送消息
	$("#message").keydown(function (event){
		if(event.ctrlKey && event.keyCode==13){
			sendMessage();
		//控制单按回车事件(目前项目不支持单按回车发送，不知为什么回车就刷新，待完善)
		}else if(event.keyCode==13){
			return false;
		}
	});
	//添加朋友聊天信息
	function  setMessage(friendname,message,time){
		$(".dialogs").append("<div class='itemdiv dialogdiv'>"
				+"<div class='user center'>"
				+"	<div class='name blue'>"+friendname+"</div>"
				+"</div>"
				+"<div class='body'>"
				+"	<i class='icon-time'></i>"
				+"	<span class='blue'>"+time+"</span>"
				+"	<div class='text'>"+message+"</div>"
				+"</div>"
			+"</div>"
		);
		
		//将光标滚动到最底部
		document.getElementById("webchat_right").scrollTop=document.getElementById("webchat_right").scrollHeight;
	}
	//添加自己的聊天信息
	function  setMyMessage(username,message,time){
		$(".dialogs").append("<div class='itemdiv dialogdiv'>"
				+"<div class='user_right center'>"
				+"	<div class='name green'>"+username+"</div>"
				+"</div>"
				+"<div class='body_right'>"
				+"	<i class='icon-time'></i>"
				+"	<span class='green'>"+time+"</span>"
				+"	<div class='text'>"+message+"</div>"
				+"</div>"
			+"</div>"
		);
		
		//将光标滚动到最底部
		document.getElementById("webchat_right").scrollTop=document.getElementById("webchat_right").scrollHeight;
	}
	//消息存入数据库
	function setMessageToDataBase(userid,friendid,message,msgTime){
		var param={};
		param["userid"]=userid;
		param["friendid"]=friendid;
		param["message"]=message;
		param["msgTime"]=msgTime;
		$.ajax({
			type : "POST",
			url : "<%=path%>/mvc/addWebChatMessage.do",
			data : param,
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg != "success"){
					error_msg(data.msg);
					return false;
				}
			},
			error : function(msg) {
				error_msg("发送过快，请稍后发送！");
			}
		});
	}
	
	//获取聊天记录
	function getMessage(){
		var param={};
		param["userid"]=$("#userid").val();
		param["friendid"]=$("#friendid").val();
		param["type"]="1";//第一次查询默认10条
		$.ajax({
			type : "POST",
			url : "<%=path%>/mvc/getWebChatList.do",
			data : param,
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == "success"){
					$("#webchat_right").html("");
					//消息总数量
					var total=parseInt(data.total);
					if(total==0){
						$("#webchat_top").html("");
					}else{
						if(total<=10&&total>0){
							$("#webchat_top").html("<span>没有更多聊天记录</span>");
						}else{
							total=10;
							$("#webchat_top").attr("style","cursor: pointer;");
							$("#webchat_top").html("<i class=\"icon-time\"></i><a href=\"javascript:void(0)\" onclick=\"getMoreMessage('1');\">查看更多聊天记录</a>");
						}
						var message=data.message;
						//倒着写入聊天窗口
						for(var index=total-1;index>=0;index--){
							//是否我发送的
							var isMy=message[index].isMy;
							if(isMy=='1'){
								setMyMessage(message[index].user_name,message[index].message,message[index].webchat_date);
							}else{
								setMessage(message[index].user_name,message[index].message,message[index].webchat_date);
							}
						}
					} 
				}else{
					error_msg("聊天记录获取失败，请刷新重试！");
				}
			},
			error : function(msg) {
				error_msg("聊天记录获取失败，请刷新重试！");
			}
		});
	};
	
	//获取更多聊天记录
	function getMoreMessage(type){
		var param={};
		param["userid"]=$("#userid").val();
		param["friendid"]=$("#friendid").val();
		var new_type=parseInt(type)+1;
		param["type"]=new_type;//取10的整数倍条记录
		$.ajax({
			type : "POST",
			url : "<%=path%>/mvc/getMoreWebChatList.do",
			data : param,
			async : false,
			dataType:'json',
			success : function(data) {
				if(data.msg == "success"){
					$("#webchat_right").html("");
					//消息总数量
					var total=parseInt(data.total);
					if(total<=parseInt(new_type)*10){
						$("#webchat_top").html("<span>没有更多聊天记录</span>");
					}else{
						total=parseInt(new_type)*10;
						$("#webchat_top").attr("style","cursor: pointer;");
						$("#webchat_top").html("<i class=\"icon-time\"></i><a href=\"javascript:void(0)\" onclick=\"getMoreMessage('"+new_type+"');\">查看更多聊天记录</a>");
					}
					var message=data.message;
					//倒着写入聊天窗口
					for(var index=total-1;index>=0;index--){
						//是否我发送的
						var isMy=message[index].isMy;
						if(isMy=='1'){
							setMyMessage(message[index].user_name,message[index].message,message[index].webchat_date);
						}else{
							setMessage(message[index].friend_name,message[index].message,message[index].webchat_date);
						}
					}
				}else{
					error_msg("聊天记录获取失败，请刷新重试！");
				}
			},
			error : function(msg) {
				error_msg("聊天记录获取失败，请刷新重试！");
			}
		});
	};
	
	//错误提示
	function error_msg(msg){
		//$("#webchat_top").attr("style","left: 100px;top: 50px;position: absolute;height: 20px;z-index: 100000;");
    	$("#webchat_top").html("<i class=\"icon-warning-sign red bigger-130\"></i><span class=\"red\">"+msg+"</span>");
        $("#message").focus();
	}
</script>