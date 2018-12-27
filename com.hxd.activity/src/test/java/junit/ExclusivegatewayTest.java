package junit;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.junit.Test;

public class ExclusivegatewayTest {

	public ProcessEngine processEngine =ProcessEngines.getDefaultProcessEngine();
	/*
	 * 部署流程定义(classpath)
	 */
	@Test
	public void depliymentProcessDenition(){
		Deployment deployment= processEngine.getRepositoryService()//与流程部署，定义相关的service
					.createDeployment()//创建一个部署实例对象
					.name("排他网管") //添加名称
					.addClasspathResource("diagrams/exclusivegateway.bpmn")// 从classPath中加载资源，一次只能加载一个
					.addClasspathResource("diagrams/exclusivegateway.png")// 从classPath中加载资源，一次只能加载一个
					.deploy();//完成部署
		System.out.println("部署id："+deployment.getId());
		System.out.println("部署名称："+deployment.getName());			
	}
	
	/*
	 * 启动流程实例
	 */
	@Test
	public void startProcessinstance(){
		String processDefinitionKey="exclusivegateway";
		ProcessInstance processInstance =processEngine.getRuntimeService() //与流程启动相关的sercice
					.startProcessInstanceByKey(processDefinitionKey); //通过key 来启动流程   key-->源文件的process中的“”
		System.out.println("流程实例id"+processInstance.getId());
		System.out.println("流程定义id"+processInstance.getProcessDefinitionId());
	}

	/*
	 * 查询个人任务
	 */
	@Test
	public void quaPersonTask(){
		String assignee="王五";
		List<Task> list=processEngine.getTaskService() //与任务相关的service
					.createTaskQuery() //创建任务查询
					.taskAssignee(assignee) //查询指定人的指定
					.list(); //返回 List<Task>
		if (list!=null&&list.size()>0) {
			for (Task task : list) {
				System.out.println("任务id："+task.getId());
				System.out.println("任务名称："+task.getName());
				System.out.println("任务办理人："+task.getAssignee());
				System.out.println("任务创建时间："+task.getCreateTime());
			}
		}
		
	}
	/*
	 * 完成我的任务
	 */
	@Test
	public void completeTask(){
		String  taskId="95004";
		Map<String, Object> variables=new HashMap<String,Object>();
		variables.put("money", 5000);
		processEngine.getTaskService().complete(taskId, variables);;
		System.out.println("任务id："+taskId);
	System.out.println("————————————————————————任务完成——————————————————————");
	}
	
	
}
