<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>


<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type">
		  <title>Process Diagram</title>
		  <!-- framework CSS -->
<link href="<%=path%>/themes/default/css/style.css" type="text/css" rel="stylesheet" title="blue"/>

<!-- JQuery EasyUi CSS-->
<link type="text/css" href="<%=path%>/js/jquery-easyui/themes/default/easyui.css" rel="stylesheet" title="blue">
<link href="<%=path%>/js/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet"/>

<!-- JQuery validate CSS-->
<link href="<%=path%>/js/validate/jquery.validate.extend.css" type="text/css" rel="stylesheet"/>

<!-- JQuery AutoComplete -->
<link rel="stylesheet" type="text/css" href="<%=path%>/js/jquery-autocomplete/jquery.autocomplete.css" />
<!--<link rel="stylesheet" type="text/css" href="<%=path%>/js/jquery-autocomplete/lib/thickbox.css" />-->

<!-- JQuery-->
<script src="<%=path%>/js/jquery-1.4.4.min.js" type="text/javascript"></script>
<!--<script src="<%=path%>/js/jquery-1.6.min.js" type="text/javascript"></script>-->

<!-- JQuery EasyUi JS-->
<script src="<%=path%>/js/jquery-easyui/jquery.easyui.min.js" type="text/javascript"></script>
<!-- JQuery validate JS-->
<script src="<%=path%>/js/validate/jquery.validate.js" type="text/javascript"></script>
<script src="<%=path%>/js/validate/jquery.metadata.js" type="text/javascript"></script>
<script src="<%=path%>/js/validate/jquery.validate.method.js" type="text/javascript"></script>
<script src="<%=path%>/js/validate/jquery.validate.extend.js" type="text/javascript"></script>

<!-- JQuery form Plugin -->
<script src="<%=path%>/js/jquery.form.js" type="text/javascript"></script>

<!-- JSON JS-->
<script src="<%=path%>/js/json2.js" type="text/javascript"></script>

<!-- JQuery AutoComplete -->
<script type='text/javascript' src='<%=path%>/js/jquery-autocomplete/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='<%=path%>/js/jquery-autocomplete/lib/jquery.ajaxQueue.js'></script>
<!--<script type='text/javascript' src='<%=path%>/js/jquery-autocomplete/lib/thickbox-compressed.js'></script>-->
<script type='text/javascript' src='<%=path%>/js/jquery-autocomplete/jquery.autocomplete.min.js'></script>

<!-- framework JS -->
<script src="<%=path%>/js/skin.js" type="text/javascript"></script>
		  <link href="<%=path%>/js/designer/designer.css" type="text/css" rel="stylesheet"/>
  			
        <!-- common, all times required, imports -->
        <SCRIPT src='<%=path%>/js/draw2d/wz_jsgraphics.js'></SCRIPT>          
        <SCRIPT src='<%=path%>/js/draw2d/mootools.js'></SCRIPT>          
        <SCRIPT src='<%=path%>/js/draw2d/moocanvas.js'></SCRIPT>                        
        <SCRIPT src='<%=path%>/js/draw2d/draw2d.js'></SCRIPT>


        <!-- example specific imports -->
        <SCRIPT src="<%=path%>/js/designer/MyCanvas.js"></SCRIPT>
        <SCRIPT src="<%=path%>/js/designer/ResizeImage.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/event/Start.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/event/End.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/connection/MyInputPort.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/connection/MyOutputPort.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/connection/DecoratedConnection.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/Task.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/UserTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/ManualTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/ServiceTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/ScriptTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/MailTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/ReceiveTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/BusinessRuleTask.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/task/CallActivity.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/gateway/ExclusiveGateway.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/gateway/ParallelGateway.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/container/SubProcess.js"></SCRIPT>
		<SCRIPT src="<%=path%>/js/designer/designer.js"></SCRIPT>	
</head>
<script type="text/javascript">
</script>

<body id="designer" class="easyui-layout">
	<div region="west" split="true" iconCls="palette-icon" title="Palette" style="width:150px;">
		<div class="easyui-accordion" fit="true" border="false">
<!--				<div id="connection" title="Connection" iconCls="palette-menu-icon" class="palette-menu">-->
<!--					<a href="##" class="easyui-linkbutton" plain="true" iconCls="sequence-flow-icon">SequenceFlow</a><br>-->
<!--				</div>-->
				<div id="event" title="Event" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="start-event-icon">Start</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="end-event-icon">End</a><br>
				</div>
				<div id="task" title="Task" iconCls="palette-menu-icon" selected="true" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="user-task-icon" wfModel="UserTask">User Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="manual-task-icon" wfModel="ManualTask">Manual Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="service-task-icon" wfModel="ServiceTask">Service Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="script-task-icon" wfModel="ScriptTask">Script Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="mail-task-icon" wfModel="MailTask">Mail Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="receive-task-icon" wfModel="ReceiveTask">Receive Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="business-rule-task-icon" wfModel="BusinessRuleTask">Business Rule Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="subprocess-icon" wfModel="SubProcess" modelType="container">SubProcess</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="callactivity-icon" wfModel="CallActivity">CallActivity</a><br>
				</div>
				<div id="gateway" title="Gateway" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="parallel-gateway-icon" wfModel="ParallelGateway" iconImg="<%=path%>/js/designer/icons/type.gateway.parallel.png">ParallelGateway</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway" iconImg="<%=path%>/js/designer/icons/type.gateway.exclusive.png">ExclusiveGateway</a><br>
				</div>
				<div id="boundary-event" title="Boundary event" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="timer-boundary-event-icon">TimerBoundaryEvent</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="error-boundary-event-icon">ErrorBoundaryEvent</a><br>
				</div>
		</div>
	</div>
	<div id="process-panel" region="center" split="true"  iconCls="process-icon" title="Process">
		
				<script>
					function parseProcessDescriptor(data){
						var descriptor = jq(data);
						var definitions = descriptor.find('definitions');
						var process = descriptor.find('process');
						var startEvent = descriptor.find('startEvent');
						var endEvent = descriptor.find('endEvent');
						var userTasks = descriptor.find('userTask');
						var exclusiveGateway = descriptor.find('exclusiveGateway');
						var parallelGateway = descriptor.find('parallelGateway');
						var lines = descriptor.find('sequenceFlow');
						var shapes = descriptor.find('bpmndi\\:BPMNShape');
						var edges = descriptor.find('bpmndi\\:BPMNEdge');
						
						workflow.process.category=definitions.attr('targetNamespace');
						workflow.process.id=process.attr('id');
						workflow.process.name=process.attr('name');
						var documentation = trim(descriptor.find('process > documentation').text());
						if(documentation != null && documentation != "")
							workflow.process.documentation=documentation;
						var extentsion = descriptor.find('process > extensionElements');
						if(extentsion != null){
							var listeners = extentsion.find('activiti\\:executionListener');
							var taskListeners = extentsion.find('activiti\\:taskListener');
							workflow.process.setListeners(parseListeners(listeners,"draw2d.Process.Listener","draw2d.Process.Listener.Field"));
						}
						jq.each(processDefinitionVariables,function(i,n){
								var variable = new draw2d.Process.variable();
								variable.name=n.name;
								variable.type=n.type;
								variable.scope=n.scope;
								variable.defaultValue=n.defaultValue;
								variable.remark=n.remark;
								workflow.process.addVariable(variable);
							});
						startEvent.each(function(i){
								var start = new draw2d.Start("<%=path%>/js/designer/icons/type.startevent.none.png");
								start.id=jq(this).attr('id');
								start.eventId=jq(this).attr('id');
								start.eventName=jq(this).attr('name');
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==start.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addFigure(start,x,y);
										return false;
									}
								});
							});
						endEvent.each(function(i){
								var end = new draw2d.End("<%=path%>/js/designer/icons/type.endevent.none.png");
								end.id=jq(this).attr('id');
								end.eventId=jq(this).attr('id');
								end.eventName=jq(this).attr('name');
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==end.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addFigure(end,x,y);
										return false;
									}
								});
							});
						
						userTasks.each(function(i){
								var task = new draw2d.UserTask();
								var tid = jq(this).attr('id');
								task.id=tid;
								var tname = jq(this).attr('name');
								var assignee=jq(this).attr('activiti:assignee');
								var candidataUsers=jq(this).attr('activiti:candidateUsers');
								var candidataGroups=jq(this).attr('activiti:candidateGroups');
								var formKey=jq(this).attr('activiti:formKey');
								if(assignee!=null&&assignee!=""){
									task.isUseExpression=true;
									task.performerType="assignee";
									task.expression=assignee;
								}else if(candidataUsers!=null&&candidataUsers!=""){
									task.isUseExpression=true;
									task.performerType="candidateUsers";
									task.expression=candidataUsers;
								}else if(candidataGroups!=null&&candidataGroups!=""){
									task.isUseExpression=true;
									task.performerType="candidateGroups";
									task.expression=candidataGroups;
								}
								if(formKey!=null&&formKey!=""){
									task.formKey=formKey;
								}
								var documentation = trim(jq(this).find('documentation').text());
								if(documentation != null && documentation != "")
									task.documentation=documentation;
								task.taskId=tid;
								task.taskName=tname;
								if(tid!= tname)
									task.setContent(tname);
								var listeners = jq(this).find('extensionElements').find('activiti\\:taskListener');
								task.setListeners(parseListeners(listeners,"draw2d.Task.Listener","draw2d.Task.Listener.Field"));
								var performersExpression = jq(this).find('potentialOwner').find('resourceAssignmentExpression').find('formalExpression').text();
								if(performersExpression.indexOf('user(')!=-1){
									task.performerType="candidateUsers";
								}else if(performersExpression.indexOf('group(')!=-1){
									task.performerType="candidateGroups";
								}
								var performers = performersExpression.split(',');
								jq.each(performers,function(i,n){
									var start = 0;
									var end = n.lastIndexOf(')');
									if(n.indexOf('user(')!=-1){
										start = 'user('.length;
										var performer = n.substring(start,end);
										task.addCandidateUser({
												sso:performer
										});
									}else if(n.indexOf('group(')!=-1){
										start = 'group('.length;
										var performer = n.substring(start,end);
										task.addCandidateGroup(performer);
									}
								});
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==task.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addModel(task,x,y);
										return false;
									}
								});
							});
						exclusiveGateway.each(function(i){
								var gateway = new draw2d.ExclusiveGateway("<%=path%>/js/designer/icons/type.gateway.exclusive.png");
								var gtwid = jq(this).attr('id');
								var gtwname = jq(this).attr('name');
								gateway.id=gtwid;
								gateway.gatewayId=gtwid;
								gateway.gatewayName=gtwname;
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==gateway.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addModel(gateway,x,y);
										return false;
									}
								});
							});
						parallelGateway.each(function(i){
							var gateway = new draw2d.ExclusiveGateway("<%=path%>/js/designer/icons/type.gateway.parallel.png");
							var gtwid = jq(this).attr('id');
							var gtwname = jq(this).attr('name');
							gateway.id=gtwid;
							gateway.gatewayId=gtwid;
							gateway.gatewayName=gtwname;
							shapes.each(function(i){
								var id = jq(this).attr('bpmnElement');
								if(id==gateway.id){
									var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
									var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
									workflow.addModel(gateway,x,y);
									return false;
								}
							});
						});
						lines.each(function(i){
								var lid = jq(this).attr('id');
								var name = jq(this).attr('name');
								var condition=jq(this).find('conditionExpression').text();
								var sourceRef = jq(this).attr('sourceRef');
								var targetRef = jq(this).attr('targetRef');
								var source = workflow.getFigure(sourceRef);
								var target = workflow.getFigure(targetRef);
								edges.each(function(i){
										var eid = jq(this).attr('bpmnElement');
										if(eid==lid){
											var startPort = null;
											var endPort = null;
											var points = jq(this).find('omgdi\\:waypoint');
											var startX = jq(points[0]).attr('x');
											var startY = jq(points[0]).attr('y');
											var endX = jq(points[1]).attr('x');
											var endY = jq(points[1]).attr('y');
											var sports = source.getPorts();
											for(var i=0;i<sports.getSize();i++){
												var s = sports.get(i);
												var x = s.getAbsoluteX();
												var y = s.getAbsoluteY();
												if(x == startX&&y==startY){
													startPort = s;
													break;
												}
											}
											var tports = target.getPorts();
											for(var i=0;i<tports.getSize();i++){
												var t = tports.get(i);
												var x = t.getAbsoluteX();
												var y = t.getAbsoluteY();
												if(x==endX&&y==endY){
													endPort = t;
													break;
												}
											}
											if(startPort != null&&endPort!=null){
												var cmd=new draw2d.CommandConnect(workflow,startPort,endPort);
												var connection = new draw2d.DecoratedConnection();
												connection.id=lid;
												connection.lineId=lid;
												connection.lineName=name;
												if(lid!=name)
													connection.setLabel(name);
												if(condition != null && condition!=""){
													connection.condition=condition;
												}
												cmd.setConnection(connection);
												workflow.getCommandStack().execute(cmd);
											}
											return false;
										}
									});
							});
						if(typeof setHightlight != "undefined"){
							setHightlight();
						}
					}
					function parseListeners(listeners,listenerType,fieldType){
						var parsedListeners = new draw2d.ArrayList();
						listeners.each(function(i){
							var listener = eval("new "+listenerType+"()");
							
							listener.event=jq(this).attr('event');
							var expression = jq(this).attr('expression');
							var clazz = jq(this).attr('class');
							if(expression != null && expression!=""){
								listener.serviceType='expression';
								listener.serviceExpression=expression;
							}else if(clazz != null&& clazz!=""){
								listener.serviceType='javaClass';
								listener.serviceExpression=clazz;
							}
							var fields = jq(this).find('activiti\\:field');
							fields.each(function(i){
								var field = eval("new "+fieldType+"()");
								field.name=jq(this).attr('name');
								//alert(field.name);
								var string = jq(this).find('activiti\\:string').text();
								var expression = jq(this).find('activiti\\:expression').text();
								//alert("String="+string.text()+"|"+"expression="+expression.text());
								if(string != null && string != ""){
									field.type='string';
									field.value=string;
								}else if(expression != null && expression!= ""){
									field.type='expression';
									field.value=expression;
								}
								listener.setField(field);
							});
							parsedListeners.add(listener);
						});
						return parsedListeners;
					}
				</script>
				<div id="process-definition-tab">
							<div id="designer-area" title="Diagram" style="POSITION: absolute;width:100%;height:100%;padding: 0;border: none;overflow:auto;">
								<div id="paintarea" style="POSITION: absolute;WIDTH: 3000px; HEIGHT: 3000px" ></div>
							</div>
							<div id="xml-area" title="XML" style="width:100%;height:100%;overflow:hidden;overflow-x:hidden;overflow-y:hidden;">
								<textarea id="descriptorarea" rows="38" style="width: 100%;height:100%;padding: 0;border: none;" readonly="readonly"></textarea>
							</div>
				</div>
				<script type="text/javascript">
					<!--
					var workflow;
					jq('#process-definition-tab').tabs({
						fit:true,
						onSelect:function(title){
							if(title=='Diagram'){
								
							}else if(title=='XML'){
								jq('#descriptorarea').val(workflow.toXML());
								/*
								if(document.body.innerText)
									jq('#xml-area').get(0).innerText=workflow.toXML();
								else if(document.body.textContent)
									jq('#xml-area').get(0).textContent=workflow.toXML();
								*/
							}
						}
					});
					function openProcessDef(){
						jq.ajax({
							url:"<%=path%>/wf/procdef/procdef!getProcessDefXML.action?procdefId="+processDefinitionId,
							type: 'POST',
							/*
							data:{
										moduleId:"${moduleId}",
										_request_json_fields:json4params
								},
							*/
							dataType:'xml',
							error:function(){
								$.messager.alert("<s:text name='label.common.error'></s:text>","System Error","error");
								return "";
							},
							success:parseProcessDescriptor	
						}); 
					}
				
					function createCanvas(disabled){
						try{
							//initCanvas();
							workflow  = new draw2d.MyCanvas("paintarea");
							workflow.scrollArea=document.getElementById("designer-area");
							if(disabled)
								workflow.setDisabled();
							if(typeof processDefinitionId != "undefined" && processDefinitionId != null &&  processDefinitionId != "null" && processDefinitionId != "" && processDefinitionId != "NULL"){
								openProcessDef();
							}else{
									var id = "process"+Sequence.create();
									//var id = workflow.getId();
									workflow.process.category='demo_wf_process_def';
									workflow.process.id=id;
									workflow.process.name=id;
								// Add the start,end,connector to the canvas
								  var startObj = new draw2d.Start("<%=path%>/js/designer/icons/type.startevent.none.png");
								  //startObj.setId("start");
								  workflow.addFigure(startObj, 200,50);
								  
								  var endObj   = new draw2d.End("<%=path%>/js/designer/icons/type.endevent.none.png");
								  //endObj.setId("end");
								  workflow.addFigure(endObj,200,400);
							} 
						}catch(e){
							alert(e.message);
						}
					}
					//-->
				</script>
	</div>
	<div id="properties-panel" region="east" split="true" iconCls="properties-icon" title="Properties" style="width:500px;">
		
	</div>
	
	<!-- toolbar -->
	<div id="toolbar-panel" region="north" border="false" style="height:36px;background:#E1F0F2;">
		<div style="background:#E1F0F2;padding:5px;">
			<a href="javascript:void(0)" id="sb1" class="easyui-splitbutton" menu="#edit-menu" iconCls="icon-edit">Edit</a>
<!--			<a href="javascript:void(0)" id="sb2" class="easyui-splitbutton" menu="#mm2" iconCls="icon-ok" onclick="javascript:alert(workflow.toXML())">Ok</a>-->
<!--			<a href="javascript:void(0)" id="mb2" class="easyui-menubutton" menu="#xml/diagram" onclick="viewXMLOrDiagram()">XML/Diagram</a>-->
			<a href="javascript:void(0)" id="mb3" class="easyui-menubutton" menu="#mm3" iconCls="icon-help">Help</a>
		</div>
		<div id="edit-menu" style="width:150px;">
		<div iconCls="icon-undo" onclick="undo()">Undo</div>
		<div iconCls="icon-redo" onclick="redo()">Redo</div>
		<div class="menu-sep"></div>
<!--		<div onclick="openProcessDef()">Open</div>-->
		<div iconCls="icon-save" onclick="saveProcessDef()">Save</div>
		<div><a href="#" onclick="exportProcessDef(this)">Export</a></div>
<!--		<div class="menu-sep"></div>-->
<!--		<div>-->
<!--			<span>Toolbar</span>-->
<!--			<div style="width:150px;">-->
<!--				<div>Address</div>-->
<!--				<div>Link</div>-->
<!--				<div>Navigation Toolbar</div>-->
<!--				<div>Bookmark Toolbar</div>-->
<!--				<div class="menu-sep"></div>-->
<!--				<div>New Toolbar...</div>-->
<!--			</div>-->
<!--		</div>-->
<!--		<div iconCls="icon-remove">Delete</div>-->
<!--		<div>Select All</div>-->
		</div>
		<div id="mm3" style="width:150px;">
			<div>Help</div>
			<div class="menu-sep"></div>
			<div>About</div>
		</div>
	</div>
	<!-- task context menu -->
	<div id="task-context-menu" class="easyui-menu" style="width:120px;">
		<div id="properties-task-context-menu" iconCls="properties-icon">Properties</div>
		<div id="delete-task-context-menu" iconCls="icon-remove">Delete</div>
	</div>
	<!-- form configuration window -->
	<div id="form-win" title="Form Configuration" style="width:750px;height:500px;">
	</div>
	<!-- listener configuration window -->
	<div id="listener-win" title="Listener Configuration" style="width:750px;height:500px;">
	</div>
	<!-- candidate configuration window -->
	<div id="task-candidate-win" title="" style="width:750px;height:500px;">
	</div>
</body>
</html>
<script type="text/javascript">
<!--
	createCanvas(false);
//-->
</script>