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

import sun.security.x509.KeyIdentifier;

public class CandidateUserTest {

	public ProcessEngine processEngine =ProcessEngines.getDefaultProcessEngine();
	/*
	 * 部署流程定义(classpath)
	 */
	@Test
	public void depliymentProcessDenition(){
		Deployment deployment= processEngine.getRepositoryService()//与流程部署，定义相关的service
					.createDeployment()//创建一个部署实例对象
					.name("组任务") //添加名称
					.addClasspathResource("diagrams/candidateuser.bpmn")// 从classPath中加载资源，一次只能加载一个
					//.addClasspathResource("diagrams/candidateuser.png")// 从classPath中加载资源，一次只能加载一个
					.deploy();//完成部署
		System.out.println("部署id："+deployment.getId());
		System.out.println("部署名称："+deployment.getName());			
	}
	
	/*
	 * 启动流程实例
	 */
	@Test
	public void startProcessinstance(){
		String processDefinitionKey="candidateUdser";
		Map<String, Object> variables=new HashMap<String,Object>();
		variables.put("groupUsers", "小a,小b");  // value 值由string 组成
		ProcessInstance processInstance =processEngine.getRuntimeService() //与流程启动相关的sercice
					.startProcessInstanceByKey(processDefinitionKey,variables); //通过key 来启动流程   key-->源文件的process中的“”
		System.out.println("流程实例id"+processInstance.getId());
		System.out.println("流程定义id"+processInstance.getProcessDefinitionId());
	}

	/*
	 * 查询当前人的组任务
	 */
	@Test
	public void quaPersonTask(){
		String candidateUser="小a";
		List<Task> list=processEngine.getTaskService() //与任务相关的service
					.createTaskQuery() //创建任务查询\
//					. taskAssignee(candidateUser)
				.taskCandidateUser(candidateUser)
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
	
	/*历史库中有相对应的表*/
	
	/*拾取任务*/
	@Test
	public void cliam(){
		String taskId="107505";
		//可是是组内成员也可以是其他成员
		String userId="小a";
		processEngine.getTaskService()
						.claim(taskId, userId);
	}
	
	
	/*将组任务改为个人任务*/
	@Test
	public void changetoPerson(){
		String taskId="107505";
		String userId="小h";
		processEngine.getTaskService()
						.setAssignee(taskId, userId);
	}
	
	/*将个人任务 变成组任务  前提： 之前要是组任务*/
	@Test
	public void changetoGroup(){
		String taskId="107505";
		processEngine.getTaskService()
						.setAssignee(taskId, null);
	}
	
	/*增加组任务成员*/
	@Test
	public void addCandidateUser(){
		String taskId="107505";
		String userId="小h";
		processEngine.getTaskService()
					.addCandidateUser(taskId, userId);
	}
	
	/*删除组任务成员*/
	@Test
	public void deleteCandidateUser(){
		String taskId="107505";
		String userId="小h";
		processEngine.getTaskService()
					.deleteCandidateUser(taskId, userId);
	}
	
	
	/*
	 * 完成我的任务
	 */
	@Test
	public void completeTask(){
		String  taskId="107505";
		processEngine.getTaskService().complete(taskId);
		System.out.println("任务id："+taskId);
	System.out.println("————————————————————————任务完成——————————————————————");
	}
	
	
}
