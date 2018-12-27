	var hashH = "";
	var bodyHeight = "";
	var showHeight = "";
	var showModalId = "";
	var showReSetHeight = "625";
	var showModalId = "";
	
	var localObj = window.location;
	var contextPath = localObj.origin+"/" + localObj.pathname.split("/")[1] ;
	
	//var contextPath = "http://172.16.8.253:8080/com.htfg.callcenter.portal.web";//送Iframe高度的门户地址
	
	function setHash(contextPath) {
		//alert(contextPath);
		bodyHeight = $("#iframe_body").height();
		height = $(window).height()-100;
		if(bodyHeight>height){
			$("#iframe_body").css("overflow-y","auto");
			$("#iframe_body").css("overflow-x","hidden");
		}
		showHeight = bodyHeight;
		//alert("bodyHeight:     "+bodyHeight);
		//alert(showModalId);
		if(showModalId != "") {
			//alert("showModalId    	"+$(showModalId).height());
			if($(showModalId).height() > bodyHeight) {
				showHeight = $(showModalId).height()+5;
			}
		}
		if(showHeight == hashH) {
			return;
		}
		
		hashH = showHeight;
		if(hashH <=showReSetHeight){
			hashH=showReSetHeight ;
		}
		var iframe_url = contextPath+"/mvc/handleIfame.do#"+hashH;
		$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	}
function reSetHash(height) {
	hashH = height;
	var iframe_url = contextPath+"/mvc/handleIfame.do#"+hashH;
	$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
};	
	
//自定义confirm控件
function f_confirm(message,callback){
	//刷新Iframe高度
	reSetHash(showReSetHeight);
	var txt=  message;
	var option = {
		title: "提示",
		btn: parseInt("0011",2),
		onOk: function(){
			callback.call();
			//刷新Iframe高度
			//reSetHash(showHeight);
		},
		onClose: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		}
	}
	window.wxc.xcConfirm(txt, "confirm", option);
}

//自定义成功控件
function f_back(message,callback){
	//刷新Iframe高度
	reSetHash(showReSetHeight);
	var txt=  message;
	var option = {
		title: "提示",
		btn: parseInt("0001",2),
		onOk: function(){
			callback.call();
			//刷新Iframe高度
			//reSetHash(showHeight);
		},onClose:function(){
			callback.call();
		}
	}
	window.wxc.xcConfirm(txt, "success", option);
}

//自定义alert控件
function f_alert_title(title, message){
	//刷新Iframe高度
	reSetHash(showReSetHeight);	
	var txt=  message;
	var option = {
		title: title,
		btn: parseInt("0001",2),
		onOk: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		},
		onClose: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		}
	}
	window.wxc.xcConfirm(txt, "warning", option);
}

//自定义alert控件
function f_alert(message){
	//刷新Iframe高度
	reSetHash(showReSetHeight);	
	var txt=  message;
	var option = {
		title: "提示",
		btn: parseInt("0001",2),
		onOk: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		},
		onClose: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		}
	}
	window.wxc.xcConfirm(txt, "warning", option);
}

//自定义alert控件
function f_success(message){
	//刷新Iframe高度
	reSetHash(showReSetHeight);	
	var txt=  message;
	var option = {
		title: "提示",
		btn: parseInt("0001",2),
		onOk: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		},
		onClose: function(){
			//刷新Iframe高度
			reSetHash(showHeight);
		}
	}
	window.wxc.xcConfirm(txt, "success", option);
}

function showModal(obj){
	var id = obj.attr("id");
	//alert(obj.prop("outerHTML"));
	//将html代码加载至iframe外的modal_area区域
	$(window.document).find("#modal_area").append(obj.prop("outerHTML"));
	//赋值
	/*alert(option[i]);
	for(var i=0;i<option.length;i++){
		alert(option[i]);
	}*/
	//显示模态块
	$(window.document).find("#"+id).modal({
		keyboard:false,
		backdrop:false,
		show:true
	});
	//刷新Iframe高度
	var contextPath = location.pathname.split("/")[1];
	var basePath = location.protocol+"//"+location.host+"/"+contextPath;
	var iframe_url = basePath+"/mvc/handleIfame.do#"+610;
	$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');

	
	//背景至灰
	$(window.document).find("body").addClass("modal-open").append("<div class=\"modal-backdrop fade in\"></div>");
};
function hideModal(){
	/*var id = $(obj).closest(".modal").attr("id");
	alert($("#"+id).prop("outerHTML"));
	$("#"+id).modal("hide");*/
	/*$("#modal_area").html("");
	$(document.body).removeClass("modal-open");
	$(document.body).find("div").remove(".modal-backdrop");*/
	
	$(window.document).find("#modal_area").html("");
	$(window.document).find("body").removeClass("modal-open");
	$(window.document).find("body").find("div").remove(".modal-backdrop");
	
	//刷新Iframe高度
	var contextPath = location.pathname.split("/")[1];
	var basePath = location.protocol+"//"+location.host+"/"+contextPath;
	var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
	$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');

};

//异步加载页面
function ajaxLoadPage(areaId,url,param){
	$.post(url, param, function(result) {
		$(areaId).html(result).hide().fadeIn('fast');
		setHash(param);
	});
}
//异步加载页面
function ajaxMenuLoadPage(areaId,url){
	/*$.post(url, function(result) {
		$(areaId).html(result).hide().fadeIn('fast');
	});*/
	$("#loadMainContent").attr("src", url);
}
//提示后跳转返回
function f_alert(message,backData){
	setTimeout(
			function (){
	var path = location.pathname.split("/")[1];
	var basePath = location.protocol+"//"+location.host+"/"+path;
	if("success"==message||""==message||null==message){
		var txt=  "恭喜你,操作成功!";
		var option = {
			title: "提示",
			btn: parseInt("0001",2),
			onOk: function(){
				//跳转
				if(null==backData || ""==backData){
					//判断是否为空为空直接返回
				}else if(typeof(backData)=='string'){
					//判断是否为url返回
					var toURL=basePath+"/mvc/"+backData;
					window.location = toURL;
				}else{
					backData.call();
				}
				//刷新Iframe高度
				var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
				$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	
			},
			onClose: function(){
				//跳转
				if(null==backData || ""==backData){
					//判断是否为空为空直接返回
				}else if(typeof(backData)=='string'){
					//判断是否为url返回
					var toURL=basePath+"/mvc/"+backData;
					window.location = toURL;
				}else{
					backData.call();
				}
				//刷新Iframe高度
				var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
				$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
		
			}
		}
		window.wxc.xcConfirm(txt, "success", option);
	}else{
		var txt= message;
		var option = {
			title: "提示",
			btn: parseInt("0001",2),
			onOk: function(){
				//跳转
				if(null==backData || ""==backData){
					//判断是否为空为空直接返回
				}else if(typeof(backData)=='string'){
					//判断是否为url返回
					var toURL=basePath+"/mvc/"+backData;
					window.location = toURL;
				}else{
					backData.call();
				}
				//刷新Iframe高度
				var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
				$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	
			},
			onClose: function(){
				//跳转
				if(null==backData || ""==backData){
					//判断是否为空为空直接返回
				}else if(typeof(backData)=='string'){
					//判断是否为url返回
					var toURL=basePath+"/mvc/"+backData;
					window.location = toURL;
				}else{
					backData.call();
				}
				//刷新Iframe高度
				var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
				$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
		
			}
		}
		window.wxc.xcConfirm(txt, "info", option);
	}
	//刷新Iframe高度
	var iframe_url = basePath+"/mvc/handleIfame.do#"+620;
	$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
			},200);
	}

//自定义confirm控件
function ncms_confirm(message,callback){
	var path = location.pathname.split("/")[1];
	var basePath = location.protocol+"//"+location.host+"/"+path;
	setTimeout(
			function (){
	var txt=  message;
	var option = {
		title: "提示",
		btn: parseInt("0011",2),
		onOk: function(){
			callback.call();
			//刷新Iframe高度
			var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
			$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');

		},
		onClose: function(){
			//刷新Iframe高度
			var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
			$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	
		}
	}
	//刷新Iframe高度
	var iframe_url = basePath+"/mvc/handleIfame.do#"+620;
	$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	window.wxc.xcConfirm(txt, "confirm", option);
			},200);
}

//自定义alert控件
function ncms_alert(message){
	var path = location.pathname.split("/")[1];
	var basePath = location.protocol+"//"+location.host+"/"+path;
	setTimeout(
	function (){var txt=  message;
	var option = {
		title: "提示",
		btn: parseInt("0001",2),
		onOk: function(){
			//刷新Iframe高度
			var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
			$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');

		},
		onClose: function(){
			//刷新Iframe高度
			var iframe_url = basePath+"/mvc/handleIfame.do#"+showHeight;
			$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	
		}
	}
	//刷新Iframe高度
	var iframe_url = basePath+"/mvc/handleIfame.do#"+620;
	$("#iframeDiv").html('<iframe id="hiddenIframe" name="hiddenIframe" src="'+iframe_url+'" width="0" height="0" style="display:none;"></iframe>');
	window.wxc.xcConfirm(txt, "warning", option);
	},200);
}
function checkOption(id, value) {
	var $this = $("#" + id);
	var options = value;
	$this.closest("form").find(".help-block").remove();
	if ($this.val() == '-1') {
		$this
				.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;请选择["
						+ options + "] ！</div>");
		return false;
	}
	return true;
}

/**
 * 校验电话号
 * @param
 * @return
 */
function check_telno1(id,name)
{
	var $this = $("#" + id);
	var tempValue = $this.val();
	$this.closest("form").find(".help-block").remove();
	var isPhone1 =/^([0-9]{3,4}-)?[0-9]{7,8}$/;
	var isPhone =/^([0-9]{3,4})?[0-9]{7,8}$/;
	var isMob=/^((\+?86)|(\(\+86\)))?(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
	if(tempValue!="" && tempValue!=null)
	{
		if(!isMob.test(tempValue)&&!(isPhone1.test(tempValue)||isPhone.test(tempValue)))
		{
			$("#" + id).after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["+ name + "] 格式有误！</div>");
			return  false;
		}else{
			return true;
		}
	}
}

function checkCheckBox(value,name) { 
	var falg = 0; 
	$("input[name='"+value+"']:checkbox").each(function () { 
		if ($(this).is(':checked')) { 
			falg += 1; 
		} 
	}); 
	if (falg > 0) 
		return true; 
	else 
		f_alert(name +"是必选项");
		return false; 
	} 
function checkData(id, value, flag) {
	var dataid = document.getElementById(id).value;
	var options = value;
	var $this = $("#" + id);
	$this.closest("form").find(".help-block").remove();
	if ((flag == "input") & dataid.length == 0) {
		$this.focus();
		/*$this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["+ options + "] 是必填项！</div>");*/
		f_alert(options+"是必填项！");
		return false;
	}
	if ((flag == "inputNull") & dataid.length == 0) {
		$this.focus();
		$this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["+ options + "] 是必填项！</div>");
		/*f_alert(options+"是必填项！");*/
		return false;
	}
	if ((flag == "number")) {
		var reg = /^[0-9]*$/;
		 if(reg.test(dataid) == false){
			 /*$this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ options + "] 含有非法字符，只能输入汉子、字母、数字与下划线！");*/
			 f_alert(options+"为数字类型")
			 return false;
		 }
	}

	if ((flag == "number2")) {
		var reg = /^[a-zA-Z0-9]+$/;
		 if(reg.test(dataid) == false){
			 f_alert(options+"数字、字母，任意组合");
			/* $this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ options + "] 含有非法字符，只能输入汉子、字母、数字与下划线！");*/
			 return false;
		 }
	}

	if ((flag == "space") & dataid.indexOf(' ') >= 0) {
		/*$this
				.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ options + "] 不允许存在空格！");*/
		$this.focus();
		f_alert(options+"不允许存在空格");
		return false;
	}
	
	if (flag == "pinLength" & dataid.length < 6) {
		/*$this
				.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ options + "] 长度不足6位！");*/
		$this.focus();
		/*f_alert(options + "长度不足6位");*/
		$this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
				+ options + "] 长度不足6位");
		return false;
	}
	
	if(flag == "pwd"){
		var reg = /(?!^\d+$)(?!^[a-zA-Z]+$)(^[0-9a-zA-Z]+$)/;
		if(reg.test(dataid) == false){
			/*f_alert(options + "只能输入字母和数字组合");*/
			$this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
					+ options + "] 只能输入字母和数字组合");
			return false;
		}
	}

	if (flag == "chinese") {
		// regExp=/[\u4E00-\u9FA5]/g;
		regExp = /[^\x00-\xff]/g;
		if (regExp.test(dataid) == true) {
			/*$this
					.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
							+ options + "] 不允许使用汉字！");*/
			$this.focus();
			f_alert(options + "不允许使用汉字！");
			return false;
		}
	}

	if (flag == "illegal") {
		// fibdn = new Array
		// ("'","[","]",".",":",";","-","+",">","<","*","%","#","$","}","{","~","`","!","￥","|","/","?","&","^","(",")");
		/*fibdn = new Array(" ", "'", "[", "]", ":", ";", "-", ".", "+", ">",
				"<", "*", "%", "#", "$", "}", "{", "~", "`", "!", "￥", "|",
				"/", "?", "&", "^", "(", ")", "=", "@");
		for (i = 0; i < fibdn.length; i++) {
			for (j = 0; j < dataid.length; j++) {
				temp1 = dataid.charAt(j);
				temp2 = fibdn[i];
				if (temp1 == temp2) {
					$this
							.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
									+ options + "] 含有非法字符，只能输入汉子、字母、数字与下划线！");
					return false;
				}
			}
		}*/
		
		 var reg = /^[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
		 if(reg.test(dataid) == false){
			 f_alert(options + "含有非法字符，只能输入汉子、字母、数字与下划线");
			/* $this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ options + "] 含有非法字符，只能输入汉子、字母、数字与下划线！");*/
			 return false;
		 }
	}
	
	if(flag == "illegalHG"){
		for (i = 0; i < dataid.length; i++) {
			temp1 = dataid.charAt(i);
			if(isNaN(temp1) & temp1 != "-" ){
				/*$this
				.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ options + "] 含有非法字符,只能是数字或者-！");*/
				f_alert(options + "含有非法字符,只能是数字或者-");
				return false;
				}
			}
	}
	return true;
}

// 判断日期类型是否为YYYY-MM-DD格式的类型
function IsYYYYMMDD(id, value) {
	var str = document.getElementById(id).value;
	var $this = $("#" + id);
	if (str.length != 0) {
		var reg = /^(?:(?:(?:(?:(?:1[6-9]|[2-9][0-9])?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))()(?:0?2\1(?:29)))|(?:(?:(?:1[6-9]|[2-9][0-9])?[0-9]{2})()(?:(?:(?:0?[13578]|1[02])\2(?:31))|(?:(?:0?[13-9]|1[0-2])\2(?:29|30))|(?:(?:0?[1-9])|(?:1[0-2]))\2(?:0?[1-9]|1[0-9]|2[0-8]))))$/;
		if (!reg.test(str)) {
			$this
					.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
							+ value + "] 请输入正确的日期格式！");
			return false;
		}
	}
	return true;
}

function IsYYYYMMDD(value) {
		var reg = /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/;
			return reg.test(value+"");
}
function IsHHmmss(value){
	var reg = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/;
		return reg.test(value+"");
}
function IsYYMM(id, value) {
	var str = document.getElementById(id).value;
	var $this = $("#" + id);
	if (str.length != 0) {
		var reg = /^(0\d|1[0-2])\d{2}$/
		// var reg=/^\d{2}((0[1-9])|(1[0-2]))$/
		if (!reg.test(str)) {
			$this
					.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
							+ value + "] 请输入正确的日期格式！");
			return false;
		}
	}
	return true;
}

/*function limitCheck(id, value, limitLength) {
	var textarea = document.getElementById(id).value;
	var num = 0;
	var $this = $("#" + id);
	for (var i = 0; i < textarea.length; i++) {
		if (textarea.charCodeAt(i) > 127 || textarea.charCodeAt(i) < 0)
			num += 3;
		else
			num++;
	}
	if (num > limitLength) {
		$this
				.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
						+ value + "] 长度超出输入上限！");
		return false;
	}
	return true;
}*/

function limitCheck(id, value, limitLength) {
	var textarea = document.getElementById(id).value;
	var $this = $("#" + id);
	if(textarea.length > limitLength){
		/*$this.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;["
				+ value + "] 长度超出输入上限！");*/
		f_alert(value + "长度过长");
		
		return false;
	}
	return true;
}


function checkIdCard(id) {
	var $this = $("#" + id);
	var id_no = $this.val();
	$this.closest("form").find(".help-block").remove();
	// 检验身份证号
	// 检验18位身份证号的最后一位以及出生年月
	if (id_no.length == 18) {
		var a_idCard = id_no.split("");
		// 两检验方法均为检验通过：true，失败：false
		if (!check18IdCard(a_idCard) || !checkIdCardBirthday(id_no, 18)) {
			$this.focus();
			f_alert("身份证号输入错误,请重新输入");
			/*$this
					.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;身份证号输入错误,请重新输入!</div>");*/
			/*f_alert("身份证号输入错误,请重新输入!");*/
			return false;
		}
	}
	// 检验15位身份证号的出生年月
	if (id_no.length == 15) {
		if (!checkIdCardBirthday(id_no, 15)) {
			/*$this
			.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;身份证号输入错误,请重新输入!</div>");*/
			f_alert("身份证号输入错误,请重新输入!");
			return false;
		}
	}
	// 非15位和18位的身份证号
	if (id_no.length != 18 && id_no.length != 15) {
		$this.focus();
		/*$this
		.after("<div class=\"help-block red\" >&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;身份证号输入错误,请重新输入!</div>");*/
		f_alert("身份证号输入错误,请重新输入!");
		return false;
	}

	return true;
}

/**
 * 判断身份证号码为18位时最后的验证位是否正确
 * 
 * @param a_idCard
 *            身份证号码数组
 * @return
 */
function check18IdCard(a_idCard) {
	var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ]; // 加权因子
	var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]; // 身份证验证位值.10代表X
	var sum = 0; // 声明加权求和变量
	if (a_idCard[17].toLowerCase() == 'x')
		a_idCard[17] = 10; // 将最后位为x的验证码替换为10方便后续操作
	for (var i = 0; i < 17; i++) {
		sum += Wi[i] * a_idCard[i]; // 加权求和
	}
	var valCodePosition = sum % 11; // 得到验证码所位置
	if (a_idCard[17] == ValideCode[valCodePosition]) {
		return true;
	} else
		return false;
}

/**
 * 验证身份证号码中的生日是否是有效生日
 * 
 * @param idCard
 *            18位/15位书身份证字符串
 * @return
 */
function checkIdCardBirthday(idCard, sizeFlag) {
	if (sizeFlag == 18) {
		var year = idCard.substring(6, 10);
		var month = idCard.substring(10, 12);
		var day = idCard.substring(12, 14);
	} else if (sizeFlag == 15) {
		var year = idCard.substring(6, 8);
		var month = idCard.substring(8, 10);
		var day = idCard.substring(10, 12);
	}
	var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
	// 这里用getFullYear()获取年份，避免千年虫问题
	if (temp_date.getFullYear() == parseFloat(year)
			&& temp_date.getMonth() == parseFloat(month) - 1
			&& temp_date.getDate() == parseFloat(day))
		return true;
	else
		return false;
}

function toHomePage(url){
	//重置面包屑
	$("#breadCrumb").html("");
	$("#breadCrumb").prepend("<li><i class=\"icon-home home-icon\"></i> <a href=\"#\" onclick=\"toHomePage('"+url+"');\">首页</a></li>");
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
	ajaxMenuLoadPage('#loadPageContent',url);
}
/**
 * 通用的返回方法
 * @param
 * @return
 */
function goback(url){
	var contextPath = location.pathname.split("/")[1];
	var basePath = location.protocol+"//"+location.host+"/"+contextPath;
	window.location=basePath+"/mvc/"+url;
}























