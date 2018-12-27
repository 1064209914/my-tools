package junit;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

/**
 * Title: HelloWorld.java
 * Description:第一个activiti工作流
 * Company: htfg
 * @author 胡小东
 * @date 2017年12月21日 上午9:54:47
 */
public class HelloWorld {
		
	public ProcessEngine processEngine =ProcessEngines.getDefaultProcessEngine();
	/*
	 * 部署流程定义(classpath)
	 */
	@Test
	public void depliymentProcessDenition(){
		Deployment deployment= processEngine.getRepositoryService()//与流程部署，定义相关的service
					.createDeployment()//创建一个部署实例对象
					.name("第一个activiti工作流") //添加名称
					.addClasspathResource("diagrams/HelloWorld.bpmn")// 从classPath中加载资源，一次只能加载一个
					//.addClasspathResource("diagrams/HelloWorld.png")// 从classPath中加载资源，一次只能加载一个
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

	
	/* 查看流程图*/
	@Test
	public void wacthProcessDenitionMig(){
		String  deploymentId="127501";
		ProcessDefinition processDefinition=processEngine.getRepositoryService()
		.createProcessDefinitionQuery()
		.deploymentId(deploymentId)
		.singleResult();
		
				 InputStream in=processEngine.getRepositoryService()
						 .getProcessDiagram(processDefinition.getId());
				 
				 File file=new File("D:/activiti/"+"test.png");
				 try {
					FileUtils.copyInputStreamToFile(in, file);
				} catch (IOException e) {
					e.printStackTrace();
				}
            } 
            
	
	/*挂起操作*/
	public void guaqi(){
		//挂起流程定义是  之后不能创建新的流程定义（	否则会抛出异常）
		//processEngine.getRepositoryService().suspendProcessDefinitionByKey(processDefinitionKey);
		//要想重新激活一个流程定义，可以调用repositoryService.activateProcessDefinitionXXX方法。
		//processEngine.getRepositoryService().activateProcessDefinitionByKey(processDefinitionKey);

		/*也可以挂起一个流程实例  不能往下继续执行*/
		//挂起程实例可以调用 runtimeService.suspendProcessInstance方法。
		//激活流程实例可以调用runtimeService.activateProcessInstanceXXX方法
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
		String  taskId="12502";
		processEngine.getTaskService().complete(taskId);
		System.out.println("任务id："+taskId);
	System.out.println("————————————————————————任务完成——————————————————————");
	}
	
}
