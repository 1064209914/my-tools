package junit;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.junit.Test;

import com.hxd.entry.Person;

public class VariableTest {

	
	public ProcessEngine processEngine =ProcessEngines.getDefaultProcessEngine();
	/*
	 * 部署流程定义(classpath)
	 */
	@Test
	public void depliymentProcessDenition(){
		Deployment deployment= processEngine.getRepositoryService()//与流程部署，定义相关的service
					.createDeployment()//创建一个部署实例对象
					.name("测试流程变量") //添加名称
					.addClasspathResource("diagrams/HelloWorld.bpmn")// 从classPath中加载资源，一次只能加载一个
					.addClasspathResource("diagrams/HelloWorld.png")// 从classPath中加载资源，一次只能加载一个
					.deploy();//完成部署
		System.out.println("部署id："+deployment.getId());
		System.out.println("部署名称："+deployment.getName());			
	}
	
	/*
	 * 启动流程实例
	 */
	@Test
	public void startProcessinstance(){
		String processDefinitionKey="helloword";
		ProcessInstance processInstance =processEngine.getRuntimeService() //与流程启动相关的sercice
					.startProcessInstanceByKey(processDefinitionKey); //通过key 来启动流程   key-->源文件的process中的“”
		System.out.println("流程实例id"+processInstance.getId());
		System.out.println("流程定义id"+processInstance.getProcessDefinitionId());
	}
	
	/*设置流程变量*/
	@Test
	public void saveVariable(){
		String  taskId="32502";
	/*两种*/
	/*与流程实例，正在运行*/
	RuntimeService runtimeService= processEngine.getRuntimeService();
//	runtimeService.setVariable(executionId, variableName, value);  //  一个一个添加
//	runtimeService.setVariableLocal(executionId, variableName, value); //local 绑定改executionId 只能改executionId查询
	/*启动流程实例时也可是设置流程变量 */
//	runtimeService.startProcessInstanceById(processDefinitionId, variables)
	
	/*与任务相关*/
	TaskService taskService	=processEngine.getTaskService();
//	taskService.setVariable(taskId, variableName, value);	// 与上面一样 以taskId
	Person person=new Person();
	person.setId(1);
	person.setName("张三");
	taskService.setVariable(taskId, "张三", person);
	System.out.println("设置成功");
	
	/*任务完成时*/
//	processEngine.getTaskService().complete(taskId, variables);
	}
	
	/*启动 */
	
	
	/* 获取流程变量*/
	@Test
	public void getVariable(){
		String  taskId="35002";
		TaskService taskService	=processEngine.getTaskService();
	Person person=(Person)taskService.getVariable(taskId, "张三");
		System.out.println(person.getName());
	}
	
	/*
	 * 完成我的任务
	 */
	@Test
	public void completeTask(){
		String  taskId="35002";
		processEngine.getTaskService().complete(taskId);
		System.out.println("任务id："+taskId);
	System.out.println("————————————————————————任务完成——————————————————————");
	}
	
}
