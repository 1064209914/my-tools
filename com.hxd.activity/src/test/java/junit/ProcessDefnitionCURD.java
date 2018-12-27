package junit;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.ObjectUtils.Null;
import org.junit.Test;

public class ProcessDefnitionCURD {

	public ProcessEngine processEngine =ProcessEngines.getDefaultProcessEngine();
	/*
	 * 部署流程定义(zip)
	 */
	@Test
	public void deploymentProcessDenition(){
		ZipInputStream zipInputStream=new ZipInputStream(this.getClass().getClassLoader().getResourceAsStream("diagrams/helloworld.zip"));
		Deployment deployment= processEngine.getRepositoryService()//与流程部署，定义相关的service
					.createDeployment()//创建一个部署实例对象
					.name("流程定义") //添加名称
					.addZipInputStream(zipInputStream)
					.deploy();//完成部署
		System.out.println("部署id："+deployment.getId());
		System.out.println("部署名称："+deployment.getName());			
	}
	/*
	 * 查询流程定义
	 */
	@Test
	public void quaProcessDenition(){
		List<ProcessDefinition> list=processEngine.getRepositoryService() // 与流程定义相关的sercice
						.createProcessDefinitionQuery() // 定义流程查询
						/* 查询条件  where条件 */
//						.deploymentId(deploymentId) //通过部署id查询
						.orderByProcessDefinitionVersion().asc() // 版本号 升序排列
						.list();
//						.listPage(firstResult, maxResults); //分页
		
		if (list!=null&&list.size()>0) {
			for (ProcessDefinition processDefinition : list) {
				System.out.println("流程定义id："+processDefinition.getId());
				System.out.println("部署id:"+processDefinition.getDeploymentId());
				System.out.println("流程定义key："+processDefinition.getKey());
			}
		}
	}
	
	/* 删除流程定义 */
	@Test
	public void delProcessDenition(){
		String deploymentId="1";
		/*不级联  只能删除没有启动的流程定义  否则 抛异常*/
		//processEngine.getRepositoryService().deleteDeployment(deploymentId);
		/*级联*/
		processEngine.getRepositoryService().deleteDeployment(deploymentId,true);
	}
	
	/* 删除流程定义 通过key*/
	@Test
	public void delProcessDenitionByKey(){
		String processDefinitionKey="helloword";
		List<ProcessDefinition> list=processEngine.getRepositoryService()
					.createProcessDefinitionQuery()
					.processDefinitionKey(processDefinitionKey)
					.list();
	if (list!=null&& list.size()>0) {
		for (ProcessDefinition processDefinition : list) {
			String deploymentId=processDefinition.getDeploymentId();
			processEngine.getRepositoryService().deleteDeployment(deploymentId, true);
		}
	}
	}
	/* 查看流程图*/
	@Test
	public void wacthProcessDenitionMig(){
             String deploymentId="5001";
            List<String> list= processEngine.getRepositoryService()
             			.getDeploymentResourceNames(deploymentId);
            if (list!=null && list.size()>0) {
            	String resourceName="";
				for (String name : list) {
					if (name.indexOf(".png")>0) {
						resourceName=name;
					}
				}
				 InputStream in=processEngine.getRepositoryService()     
				.getResourceAsStream(deploymentId, resourceName);
				 
				 File file=new File("D:/activiti"+resourceName);
				 try {
					FileUtils.copyInputStreamToFile(in, file);
				} catch (IOException e) {
					e.printStackTrace();
				}
            } 
            
	}
	/*查看同key最新版本的*/
	/*创建一个Map<String,ProcessDefinition>集合 key放的是ProcessDefinition.key */
	@Test
	public void quaNewestProcessDenition(){
		 List<ProcessDefinition> list=processEngine.getRepositoryService()
					.createProcessDefinitionQuery()
					.orderByProcessDefinitionVersion().asc()
					.list();
		Map<String,ProcessDefinition > map=new HashMap<>();
		if (list!=null && list.size()>0) {
			for (ProcessDefinition processDefinition : list) {
				map.put(processDefinition.getKey(), processDefinition);
			}
		}
		List<ProcessDefinition> list2=new ArrayList<ProcessDefinition>(map.values());
 		if (list2!=null && list2.size()>0) {
			for (ProcessDefinition processDefinition : list2) {
				System.out.println(processDefinition.getKey());
				System.out.println(processDefinition.getVersion());
			}
		} 
		
	}
}
