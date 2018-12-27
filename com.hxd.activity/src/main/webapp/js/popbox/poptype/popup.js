
/**
 * 签入判断(是否选择技能，是否直接取消)，关闭电话功能；
 * @param title
 * @param content
 * @param width
 * @param height
 * @param ok
 * @param cancel
 */
function loginIpccDialog(title,content,width,height,ok,cancel){
$.popbox({
	width : width, 
	maxHeight : height,  //body区域的最大高度
	title : title,  //标题
	content :content, //主体内容，支持HTML标签
	contentUrl : '',
	showMask : true,  //是否显示遮罩层
	showCloseBtn : false,  //是否显示关闭按钮
	btns : [
		{
			type : 'ok',
			text : '保存',
			click : ok
		},
		{
			type : 'cancel',
			text : '取消',
			click : cancel
		}
	], //默认显示的按钮
	draggable : true,  //是否可拖动
	autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
	blurClose : false,  //点击窗口外部是否关闭窗口
	onOpen : '', //窗口加载完毕时的动作
	onOk : '' ,  //点击确定按钮
	onCancel : function loginFail(){
		agentBar.logout();
     } 
});
}

/**
 * ip电话弹框，关闭电话功能；
 * @param title
 * @param content
 * @param width
 * @param height
 * @param ok
 * @param cancel
 */
function openIpccphone(title,content,width,height,ok,cancel){
$.popbox({
	width : width, 
	maxHeight : height,  //body区域的最大高度
	title : title,  //标题
	content :content, //主体内容，支持HTML标签
	contentUrl : '',
	showMask : true,  //是否显示遮罩层
	showCloseBtn : false,  //是否显示关闭按钮
	btns : [
		{
			type : 'ok',
			text : '关闭',
			click : ok
		}
	], //默认显示的按钮
	draggable : true,  //是否可拖动
	autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
	blurClose : false,  //点击窗口外部是否关闭窗口
	onOpen : '', //窗口加载完毕时的动作
	onOk : function(){agentBar.hangupCall();},  //点击确定按钮
});
}
/**
 * ip电话弹框
 * @param title
 * @param content
 * @param width
 * @param height
 * @param ok
 * @param cancel
 */
function openIpccDialog(title,content,width,height,ok,cancel){
	$.popbox({
		width : width, 
		maxHeight : height,  //body区域的最大高度
		title : title,  //标题
		content :content, //主体内容，支持HTML标签
		contentUrl : '',
		showMask : true,  //是否显示遮罩层
		showCloseBtn : false,  //是否显示关闭按钮
		btns : [
			{
				type : 'ok',
				text : '保存',
				click : ok
			},
			{
				type : 'cancel',
				text : '取消',
				click : cancel
			}
		], //默认显示的按钮
		draggable : true,  //是否可拖动
		autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
		blurClose : false,  //点击窗口外部是否关闭窗口
		onOpen : '', //窗口加载完毕时的动作
		onOk : '' ,  //点击确定按钮
		onCancel : cancel  //点击取消按钮
	});
}
/**
 * 
 * @param content  html或者 其他信息
 * @param width 弹框宽度
 * @param height 弹框高度
 * @param btnsClick  ok
 */
 
function openInfoDialog(title,content,width,height,ok,cancel){
$.popbox({
	width : width, 
	maxHeight : height,  //body区域的最大高度
	title : title,  //标题
	content :content, //主体内容，支持HTML标签
	contentUrl : '',
	showMask : true,  //是否显示遮罩层
	showCloseBtn : true,  //是否显示关闭按钮
	btns : [
		{
			type : 'ok',
			text : '保存',
			click : null
		},
		{
			type : 'cancel',
			text : '取消',
			click : null
		}

	], //默认显示的按钮
	draggable : true,  //是否可拖动
	autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
	blurClose : false,  //点击窗口外部是否关闭窗口
	onOpen : '', //窗口加载完毕时的动作
	onOk : ok,  //点击确定按钮
	onCancel : cancel  //点击取消按钮
});
}

/*无按钮*/
function openDialogNobutton(title,content,width,height,ft,ok,cancel,isTrue){
	$.popbox({
		width : width, 
		maxHeight : height,  //body区域的最大高度
		title : title,  //标题
		content :content, //主体内容，支持HTML标签
		contentUrl : '',
		showMask : true,  //是否显示遮罩层
		showCloseBtn : false,  //是否显示关闭按钮
		btns : [
			{
				type : '',
				text : '',
				click : null
			},
			{
				type : 'cancel',
				text : '关闭',
				click : null
			}

		], //默认显示的按钮
		draggable : false,  //是否可拖动
		autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
		blurClose : false,  //点击窗口外部是否关闭窗口
		onOpen : '', //窗口加载完毕时的动作
		onClose:ft,
		onOk : ok,  //点击确定按钮
		onCancel : cancel  //点击取消按钮
	});
	if(isTrue){
		$('.pb_closebtn').addClass("hidden");
	}
	}

/**
 * 
 * @param content  html或者 其他信息
 * @param width 弹框宽度
 * @param height 弹框高度
 * @param btnsClick  ok
 */
 
function backDialog(title,content,width,height,cancel,isTrue){
$.popbox({
	width : width, 
	maxHeight : height,  //body区域的最大高度
	title : title,  //标题
	content :content, //主体内容，支持HTML标签
	contentUrl : '',
	showMask : true,  //是否显示遮罩层
	showCloseBtn : true,  //是否显示关闭按钮
	btns : [
		{
			type : 'cancel',
			text : '返回',
			click : cancel
		}

	], //默认显示的按钮
	draggable : true,  //是否可拖动
	autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
	blurClose : false,  //点击窗口外部是否关闭窗口
	onOpen : '', //窗口加载完毕时的动作
	onOk : null,  //点击确定按钮
	onCancel : cancel,  //点击取消按钮
});
}





function OkDialog(title,content,width,height,ok,cancel){
	$.popbox({
		width : width, 
		maxHeight : height,  //body区域的最大高度
		title : title,  //标题
		content :content, //主体内容，支持HTML标签
		/*contentUrl : '',*/
		showMask : true,  //是否显示遮罩层
		showCloseBtn : false,  //是否显示关闭按钮
		btns : [
			{
				type : 'ok',
				text : '确定',
				click : ok
			},
			{
				type : 'cancel',
				text : '取消',
				click : null
			}

		], //默认显示的按钮
		draggable : true,  //是否可拖动
		autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
		blurClose : false,  //点击窗口外部是否关闭窗口
		onOpen : '', //窗口加载完毕时的动作
		onOk : null,  //点击确定按钮
		onCancel : cancel  //点击取消按钮
	});
	}

/**
 * @param msg 提示信息
 * @param btnOk 点击确定按钮触发事件
 */
function openDialog(msg,btnOk){
	$.popbox({
		width : '400px', 
		maxHeight : '200px',  //body区域的最大高度
		title : '消息提示',  //标题
		content :msg, //主体内容，支持HTML标签
		contentUrl : '',
		showMask : true,  //是否显示遮罩层
		showCloseBtn : true,  //是否显示关闭按钮
		btns : [
			{
				type : 'ok',
				text : '确定',
				click : btnOk
			}
	
		], //默认显示的按钮
		draggable : true,  //是否可拖动
		autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
		blurClose : false,  //点击窗口外部是否关闭窗口
		onOpen : '', //窗口加载完毕时的动作
		onClose : '',  //窗口关闭前的动作，返回false可组织窗口关闭
		onOk : null,  //点击ok按钮
		onCancel : ''  //点击cancel按钮
	});
};
/**
 * @param msg 提示信息
 * @param btnOk 点击确定按钮触发事件
 */
function openDialogTwo(msg,width,maxHeight,btnOk){
	$.popbox({
		width : width, 
		maxHeight : maxHeight,  //body区域的最大高度
		title : '消息提示',  //标题
		content :msg, //主体内容，支持HTML标签
		contentUrl : '',
		showMask : true,  //是否显示遮罩层
		showCloseBtn : true,  //是否显示关闭按钮
		btns : [
			{
				type : 'ok',
				text : '确定',
				click : btnOk
			}
	
		], //默认显示的按钮
		draggable : true,  //是否可拖动
		autoClose : 0, //是否自动关闭，否则设为0，是则设为大于0的数字，表示关闭时间，单位ms
		blurClose : false,  //点击窗口外部是否关闭窗口
		onOpen : '', //窗口加载完毕时的动作
		onClose : '',  //窗口关闭前的动作，返回false可组织窗口关闭
		onOk : null,  //点击ok按钮
		onCancel : ''  //点击cancel按钮
	});
};
