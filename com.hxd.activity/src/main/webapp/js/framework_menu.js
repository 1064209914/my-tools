//生成左侧Menu菜单
function initMenu(contextPath, obj) {
	console.log(obj);
	var treeHtml = "";
	tree(obj);
	function tree(obj){
			$(obj).each(function(index) {
				// 菜单头HTML
				var tempHead = "<li><a data-menuName="
				+ obj[index].menu_name
				+ " data-menuId="
				+ obj[index].menu_id
				+ " data-sysId="
				+ obj[index].systerm_id
				+ " href='javascript:void(0);'"
				+ " class='dropdown-toggle'><span class='menu-text'>"
				+ obj[index].menu_name
				+ "</span><b class='arrow icon-angle-down'></b></a><ul class='submenu'>";
				// 菜单体HTML
				var tempBody = "<li ><a data-menuName="+ obj[index].menu_name 
						+ " data-sysId="+ obj[index].systerm_id
						+ " data-menuId="+ obj[index].menu_id + " href='javascript:void(0);'"
						+ "><span class='menu-text'> "
						+ obj[index].menu_name + " </span></a></li>";
				// 菜单尾HTML
				var tempFoot = "</ul></li>";
				//加载第一个节点的菜单
				if(obj[index].menu_url == '#'){
					treeHtml += tempHead;
				}else{
					treeHtml += tempBody;
				}
				if(obj[index].nodes != null){
					var list = obj[index].nodes;
					treeHtml = listEach(list,treeHtml);
					/*console.log(list);*/
				}
				treeHtml += tempFoot;
		});
	}
	$('#menuTree').append(treeHtml);
}


function listEach(list,treeHtml){
	var tempNFoot = "</ul></li>";
	$(list).each(function(index){
		if(list[index].menu_url == '#'){
			treeHtml += "<li><a data-menuName="
						+ list[index].menu_name
						+ " data-menuId="
						+ list[index].menu_id
						+ " data-sysId="
						+ list[index].systerm_id
						+ " href='javascript:void(0);'"
						+ " class='dropdown-toggle'><span class='menu-text'>"
						+ list[index].menu_name
						+ "</span><b class='arrow icon-angle-down'></b></a><ul class='submenu'>";	
		}
        if(list[index].menu_url != '#'){
        	treeHtml += "<li ><a data-menuName="+ list[index].menu_name 
			+ " data-sysId="+ list[index].systerm_id
			+ " data-menuId="+ list[index].menu_id + " href='javascript:void(0);'"
			+ "><span class='menu-text'> "
			+ list[index].menu_name + " </span></a></li>";
		}
		
		if(list[index].nodes != null){
			var html = listEach(list[index].nodes,treeHtml);
			treeHtml = html+tempNFoot;
		}
	});
	return treeHtml;
}


// 取当前节点的下一结点等级
function getNextLevel(obj) {
	var attr = new Array();
	$(obj).each(function(index) {
		attr.push(obj[index].menu_id);
	});
	attr.push("0");
	return attr;
}
// 取当前节点的下一结点路径
function getNextUrl(obj) {
	var attr = new Array();
	$(obj).each(function(index) {
		attr.push(obj[index].menu_url);
	});
	attr.push("#");
	return attr;
}
