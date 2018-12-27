package junit;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngineConfiguration;
import org.junit.Test;

public class TestAcitivity {

	/*
	 * 用代码创建工作流所需的23张表
	 */
	@Test
	public void createTable(){
	ProcessEngineConfiguration processEngineConfiguration= ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();
	//数据库链接配置
	processEngineConfiguration.setJdbcDriver("com.mysql.jdbc.Driver");
	processEngineConfiguration.setJdbcUrl("jdbc:mysql://172.16.12.45:3306/activity?characterEncoding=utf8");
	processEngineConfiguration.setJdbcUsername("root");
	processEngineConfiguration.setJdbcPassword("root");
	/*
	 *public static final String DB_SCHEMA_UPDATE_FALSE = "false"; 不创建表 只更新表 
	 *public static final String DB_SCHEMA_UPDATE_CREATE_DROP = "create-drop"; 先删除在创建表
	 *public static final String DB_SCHEMA_UPDATE_TRUE = "true";  如果表不存在创建表
	 */
	processEngineConfiguration.setDatabaseSchemaUpdate(processEngineConfiguration.DB_SCHEMA_UPDATE_TRUE);
	//工作流核心对象，processEngine
     ProcessEngine processEngine=processEngineConfiguration.buildProcessEngine();
     System.out.println("processEngine"+processEngine);
	}
	
	
	
	/*
	 * 用配置文件创建工作流所需的23张表
	 */
	@Test
	public void createTable2(){
	ProcessEngine processEngine=ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("activiti.cfg.xml").buildProcessEngine();
	 System.out.println("processEngine"+processEngine);
	}
	
}
