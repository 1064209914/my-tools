package junit;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.junit.Test;

import com.hxd.entry.Person;

public class RecieveTest {

	
	public ProcessEngine processEngine =ProcessEngines.getDefaultProcessEngine();
	/*
	 * 部署流程定义(classpath)
	 */
	@Test
	public void depliymentProcessDenition(){
		Deployment deployment= processEngine.getRepositoryService()//与流程部署，定义相关的service
					.createDeployment()//创建一个部署实例对象
					.name("接收活动任务") //添加名称
					.addClasspathResource("diagrams/receiveTask.bpmn")// 从classPath中加载资源，一次只能加载一个
					.addClasspathResource("diagrams/receiveTask.png")// 从classPath中加载资源，一次只能加载一个
					.deploy();//完成部署
		System.out.println("部署id："+deployment.getId());
		System.out.println("部署名称："+deployment.getName());			
	}
	
	/*
	 * 启动流程实例
	 */
	@Test
	public void startProcessinstance(){
		String processDefinitionKey="receivetask";
		ProcessInstance processInstance =processEngine.getRuntimeService() //与流程启动相关的sercice
					.startProcessInstanceByKey(processDefinitionKey); //通过key 来启动流程   key-->源文件的process中的“”
		System.out.println("流程实例id"+processInstance.getId());
		System.out.println("流程定义id"+processInstance.getProcessDefinitionId());
		
		/* 通过流程实例id查询执行id*/
		Execution execution1 =processEngine.getRuntimeService()
					.createExecutionQuery()
				   .activityId("receivetask1")  //活动id对应的是receiveTask.bpmn 文件中的id 
					.processInstanceId(processInstance.getId())  //可能会变  这里没有变化
					.singleResult();
		
		/* 因为接收活动任务不再任务库中 所以只能通过runtime 来设置变量  需要执行id*/
		processEngine.getRuntimeService()
					.setVariable(execution1.getId(), "每日销售额", 320000);
		
		/* 传递给下一个*/
		processEngine.getRuntimeService().signal(execution1.getId());
		
		
		/* 通过流程实例id查询执行id 流程实例可能改变 */
		Execution execution2 =processEngine.getRuntimeService()
				.createExecutionQuery()
			   .activityId("receivetask2")  //活动id对应的是receiveTask.bpmn 文件中的id 
//				.processInstanceId(processInstance.getId())  //可能会变  这里没有变化
				.singleResult();
		
		/* 获取流程变量*/
		int mun=(Integer)processEngine.getRuntimeService().getVariable(execution2.getId(), "每日销售额");
		System.out.println("老板接受的的销售额是："+mun);
		
		/*结束*/
		processEngine.getRuntimeService().signal(execution2.getId());
	}
	

}
