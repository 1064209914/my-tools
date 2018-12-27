<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8" />
	<!-- basic styles -->
	<%-- <jsp:include page="./common/commonList.jsp"></jsp:include> --%>
	<link rel="stylesheet" href="<%=path%>/css/jquery.popbox.css" />
	<link rel="stylesheet" href="<%=path%>/css/mytree.css" />
	</head>
	<!-- 该页面为iframe嵌套页面，以下代码用于计算iframe高度，不允许修改：
			<body id="iframe_body" onload="setHash('${pageContext.request.contextPath}')">
			<div id="iframeDiv" style="display:none"></div>
			<div class="page-content" id="loadPageContent">
	-->
	<body id="iframe_body"   onkeydown="keyLogin();">
		<div id="iframeDiv" style="display:none"></div>
		<div class="page-content" id="loadPageContent">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div class="col-xs-3" style="padding-right: 35px;padding-left: 14px;">
					<div class="widget-box" id="org_tree">
						<div class="widget-header widget-header-flat" style="height:30px;padding:0px 4px;min-height:30px;">
							<input  value="" name="tree_name" id="tree_name"/>
							<a onclick="searchNode();" href="javascript:;" >
								<i class="icon-search bigger-130 blue"></i>
							</a>
							<a onclick="addEntity();" href="javascript:;" style="margin-left: 5px;" title="新增">
								<i class="icon-plus bigger-120 blue"></i>
							</a>
							<a onclick="editEntity();" href="javascript:;" style="margin-left: 5px;"  title="修改">
								<i class="icon-pencil bigger-120 blue"></i>
							</a>
							<a onclick="deleteEntity();" href="javascript:;" id="off" style="margin-left: 5px;"   title="停用">
								<i class="icon-off bigger-120 blue"></i>
							</a>
							<a onclick="notDeleteEntity();" href="javascript:;" id="circle" style="margin-left: 5px;"  title="启用">
								<i class="icon-play-circle bigger-120 blue"></i>
							</a>
							<!-- <a onclick="addEntity();" class="btn btn-xs btn-info" style="float: right;margin: 13px 4%;">
								<i class="icon-plus bigger-150 blue"></i>
							</a> -->
						</div>
						<div class="widget-body" style="height:400px;overflow-y:auto; overflow-x:hidden">
							<div>
								<div id="tree3" class="tree3 tree-selectable"></div>
							</div>
						</div>
						<input id="org_ids" name="org_ids" type="hidden" value="${userOrg}" />
						<input id="org_pid" name="org_pid" type="hidden" />
						<input id="org_pname" name="org_pname" type="hidden" />
						<input id="org_status" name="org_status" type="hidden" />
						<input id="selectedOrgName" type="hidden" value="${orgName}"/>
						<input id="selectedOrgId" type="hidden" value="${orgId}"/>
						<input id="selectedOrgstatus" type="hidden" value="${orgStatus}"/>
					</div>
				</div>
				<!-- 查询条件begin -->
				<div class="col-xs-9" id="editContent" style="padding-left: 0px;padding-right: 0px;">
				
				<!-- 查询条件end -->
				<div id="qryContent">
					
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div>
		</div>
	</div>
	
	<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js" ></script>
	<script type="text/javascript">
		var $assets = "assets";//this will be used in fuelux.tree-sampledata.js
	</script>
	<script src="<%=path%>/js/bootstrap-treeview.js"></script>
	<script src="<%=path%>/js/popbox/jquery.popbox.js"></script>
	<script src="<%=path%>/js/popbox/poptype/popup.js"></script>
	<script type="text/javascript">
	/*********页面加载区域**********/
	var tr="";
		jQuery(function($) {
			$("#circle").hide();
			$("#off").show();
			var data = [{"text":"根机构","org_id":"000999","org_pid":"#","status":"1","org_pname":"根机构","org_code":"000999","nodes":[{"text":"建行银行","org_id":"200001","status":"1","org_pid":"000999","org_pname":"根机构","org_code":"1000501","nodes":[{"text":"建行电销","org_id":"300001","status":"1","org_pid":"200001","org_pname":"建行银行","org_code":"1000502","nodes":[{"text":"合肥电销","org_id":"400001","status":"1","org_pid":"300001","org_pname":"建行电销","org_code":"1000504","nodes":[{"text":"合肥一区","org_id":"500001","status":"1","org_pid":"400001","org_pname":"合肥电销","org_code":"1000509","nodes":[{"text":"一区一组","org_id":"6000001","status":"1","org_pid":"500001","org_pname":"合肥一区","org_code":"1000515"},{"text":"一区二组","org_id":"6000002","status":"1","org_pid":"500001","org_pname":"合肥一区","org_code":"1000516"}]},{"text":"合肥二区","org_id":"500002","status":"1","org_pid":"400001","org_pname":"合肥电销","org_code":"1000510","nodes":[{"text":"二区一组","org_id":"6000003","status":"1","org_pid":"500002","org_pname":"合肥二区","org_code":"1000517"},{"text":"二区二组","org_id":"6000004","status":"1","org_pid":"500002","org_pname":"合肥二区","org_code":"1000518"}]}]},{"text":"花桥电销","org_id":"400002","status":"1","org_pid":"300001","org_pname":"建行电销","org_code":"1000505","nodes":[{"text":"花桥一区","org_id":"500003","status":"1","org_pid":"400002","org_pname":"花桥电销","org_code":"1000511","nodes":[{"text":"花桥一区一组","org_id":"6000005","status":"1","org_pid":"500003","org_pname":"花桥一区","org_code":"1000519"}]},{"text":"花桥二区","org_id":"500004","status":"1","org_pid":"400002","org_pname":"花桥电销","org_code":"1000512","nodes":[{"text":"花桥二区一组","org_id":"6000006","status":"1","org_pid":"500004","org_pname":"花桥二区","org_code":"1000520"}]}]},{"text":"九华电销","org_id":"400003","status":"1","org_pid":"300001","org_pname":"建行电销","org_code":"1000506","nodes":[{"text":"九华一区","org_id":"500005","status":"1","org_pid":"400003","org_pname":"九华电销","org_code":"1000513"},{"text":"九华二区","org_id":"500006","status":"1","org_pid":"400003","org_pname":"九华电销","org_code":"1000514"}]}]},{"text":"建行电催","org_id":"300002","status":"1","org_pid":"200001","org_pname":"建行银行","org_code":"1000503","nodes":[{"text":"合肥电催","org_id":"400004","status":"1","org_pid":"300002","org_pname":"建行电催","org_code":"1000507"},{"text":"九华电催","org_id":"400005","status":"1","org_pid":"300002","org_pname":"建行电催","org_code":"1000508"}]}]}]}];;
			/*组织机构树的显示*/
			tr = $('#tree3').treeview({
	    	      data:data,
	    		  levels: 2,
	    		  showCheckbox: false,
	    		  showIcon: true,
	    		  showTags:true,
	    		  highlightSelected:true,
	    		  multiSelect :false
	    	});
		  });
		 $('#tree3').on('nodeSelected', function(event, data) {
				var id=data.org_id;
				$("#org_pid").val(data.org_id);
				$("#org_pname").val(data.text);
				$("#org_status").val(data.status);
				viewEntity(data.org_id);
				if(data.status=="0"){
					$("#circle").show();
					$("#off").hide();
				}else{
					$("#circle").hide();
					$("#off").show();
				}
				/* if(id!=0){viewEntity(id);};  */
	        });
			setHash('${pageContext.request.contextPath}');
		}); 
		setHash('${pageContext.request.contextPath}');
	}); 
		<%-- 	$('#tree3').on('click', function (evt, data) {
				setHash('${pageContext.request.contextPath}');
			});
			selectedNode($("#selectedOrgName").val(),$("#selectedOrgId").val(),$("#selectedOrgstatus").val());
			/*组织机构树的点击节点事件*/
			 $('#tree3').on('nodeSelected', function(event, data) {
				var id=data.org_id;
				$("#org_pid").val(data.org_id);
				$("#org_pname").val(data.text);
				$("#org_status").val(data.status);
				viewEntity(data.org_id);
				if(data.status=="0"){
					$("#circle").show();
					$("#off").hide();
				}else{
					$("#circle").hide();
					$("#off").show();
				}
				/* if(id!=0){viewEntity(id);};  */
	        });
			setHash('${pageContext.request.contextPath}');
		}); 
	
	function selectedNode(node,orgId,status){
		var data = ${nodes};
		var initSelectableTree = function() {
	          return tr;
	        };
	      var $selectableTree = initSelectableTree();
		  var findSelectableNodes = function() {
	          return $selectableTree.treeview('search', [ node, { ignoreCase: false, exactMatch: false } ]);
	        };
	        var selectableNodes = findSelectableNodes();
	         $selectableTree.treeview('selectNode', [selectableNodes]);
	         $('#tree3').treeview('search', [ "", {
				  ignoreCase: true,     // case insensitive
				  exactMatch: false,    // like or equals
				  revealResults: true,  // reveal matching nodes
				}]);
	           //$selectableTree.treeview('disableNode', [selectableNodes]);
	           if(orgId!=null&&orgId!=""){
	        	   $("#org_pid").val(orgId);
					$("#org_pname").val(node);
					$("#org_status").val(status);
					if(status=="0"){
						$("#circle").show();
						$("#off").hide();
					}else{
						$("#circle").hide();
						$("#off").show();
					}
	        	   viewEntity(orgId);
	           }
	}
	
		//组织机构搜索功能
		 function searchNode(){
			var name = $('#tree_name').val()
			$('#tree3').treeview('search', [ name, {
				  ignoreCase: true,     // case insensitive
				  exactMatch: false,    // like or equals
				  revealResults: true,  // reveal matching nodes
				}]);
			 setHash('${pageContext.request.contextPath}');
			return ;
		}; 
		//根据查询条件查看
		 function toQry(){
			var param = $("#queryForm").serialize();
			param += "&qry_type=qry";
			$.post("organization_getList.do", param, function(result) {			
				$("#qryContent").html(result).hide();
				$("#qryContent").fadeIn('fast');
				setHash('${pageContext.request.contextPath}');
				return;
			});
		}
		function addEntity(){
			if($('#tree3').treeview('getSelected', null).length >0){
				if($("#org_status").val() == '0'){
					f_alert("此机构状态已停用不能新增下级组织");
					return;
				}
				var param={};
				param["org_pid"] = $("#org_pid").val();
				param["org_pname"] = $("#org_pname").val();
				$.post("organization_add.do", param, function(result) {	
					openInfoDialog("增加机构",result,null,null,function(){
						if (!checkData('orgid', '机构ID', 'input')) {
							return;
						}
						if (!checkData('orgid', '机构ID', 'number')) {
							return;
						}
						if(!limitCheck('orgid','机构ID','10')){
							return;
						}
						if (!checkData('orgname', '机构名称', 'input')) {
							return;
						}
						if (!checkData('orgname', '机构名称', 'illegal')) {
							return;
						}
						if(!limitCheck('orgname','机构名称','20')){
							return;
						}
						if (!checkOption('orggrade', '机构等级')) {
							return;
						} 
						var orggrade = $("#orggrade").val();
						if(orggrade=="2"){
							if (!checkOption('orgpid1', '上级机构')) {
								return;
							}
						}
						if(orggrade=="3"){
							if (!checkOption('orgpid2', '上级机构')) {
								return;
							}
						}
						var orgName=$("#orgname").val();
						var orgId=$("#orgid").val();
						var orgStatus=$("#org_status").val();
						$.ajax({
							type : "POST",
							url : "<%=path%>/mvc/organization_addSave.do",
							data : $("#sub_form").serialize(),
							async : false,
							dataType:'json',
							success : function(data) {
								if(data.msg == null){
									f_alert("","organization_getList.do?orgName="+orgName+"&orgId="+orgId+"&orgStatus="+orgStatus);
								}else{
									f_alert("保存失败:"+data.msg);
								}
							},
							error : function(msg) {
								var exp="分配出错 " + msg;
								f_alert("保存失败:"+exp);
							}
						});
					})
				});
				
			}else{
				f_alert("请选择机构!");
				return;
			}
		}
		 function viewEntity(org_id){
			 debugger;
			var param={};
			param["orgId"]=org_id;
			param["qry_type"]="org";
			param["one"]="ture";
			$.post("queryUserListByOrg.do", param, function(result) {			
				$("#editContent").html(result).hide();
				$("#editContent").fadeIn('fast');
				setHash('${pageContext.request.contextPath}');
			});
		} 
		function editEntity(org_id,org_pid,status){
			if( $("#org_pid").val()==$("#org_ids").val()){
				f_alert("不可修改本级机构");
				return;
			}
			if($('#tree3').treeview('getSelected', null).length >0){	
			if(status == "0"){
				f_alert("此状态不能维护");
				return;
			}else{
				var param={};
				param["org_id"]=$("#org_pid").val();
				param["viewOrEdit"]="edit";
				$.post("organization_edit.do", param, function(result) {			
					openInfoDialog("编辑机构",result,null,null,function(){
						if (!checkData('orgname', '机构名称 ', 'input')) {
							return;
						}
						if (!checkData('orgname', '机构名称 ', 'illegal')) {
							return;
						}
						if(!limitCheck('orgname','机构名称','20')){
							return;
						}
						if($("#orgpid").val() == $("#orgid").val()){
							f_alert("保存失败:上级机构不能是本机构");
							return;
						}
						var orgName=$("#orgname").val();
						var orgId=$("#orgid").val();
						var orgStatus=$("#org_status").val();
						$.ajax({
							type : "POST",
							url : "<%=path%>/mvc/organization_editSave.do",
							data : $("#sub_form").serialize(),
							async : false,
							dataType:'json',
							success : function(data) {
								if(data.msg == null){
									f_alert("","organization_getList.do?orgName="+orgName+"&orgId="+orgId+"&orgStatus="+orgStatus);
								}else{
									f_alert("修改失败:"+data.msg);
								}
							},
							error : function(msg) {
								var exp="分配出错 " + msg;
								f_alert("修改失败:"+exp);
							}
						});
					})
				});
				
			}
		}else{
			f_alert("请选择机构!");
			return;
		}
		}
		//停用
		function deleteEntity(){
			if($("#org_pid").val()==null||$("#org_pid").val()==""){
				f_alert("请选择机构");
			}else{
				f_confirm("确认停用？",function cellback(){
					var param={};
					param["org_id"]=$("#org_pid").val();
					$.post("organization_delete.do",param,function(data){
						if(data.msg== null){
							var orgId=$("#org_pid").val();
							var orgName=$("#org_pname").val();
							f_alert("","organization_getList.do?orgName="+orgName+"&orgId="+orgId+"&orgStatus=0");
						}else{
							f_alert("停用失败:" + data.msg);	
						}
					}); 
				});
			}
		}
		
		
		//启用
		function notDeleteEntity(){
			if($("#org_pid").val()==null||$("#org_pid").val()==""){
				f_alert("请选择机构");
			}else{
				f_confirm("确认启用？",function cellback(){
					var param={};
					param["org_id"]=$("#org_pid").val();
					$.post("organization_notDelete.do",param,function(data){
						if(data.msg== null){
							var orgId=$("#org_pid").val();
							var orgName=$("#org_pname").val();
							f_alert("","organization_getList.do?orgName="+orgName+"&orgId="+orgId+"&orgStatus=1");
						}else{
							f_alert("启用失败:" + data.msg);	
						}
					}); 
				});
			}
		}
		function keyLogin(){
			 if (event.ctrlKey&&event.keyCode==13){  //回车键的键值为13
				 toQry(); 
			} 
		}--%>
	</script>
	</body>
</html>
