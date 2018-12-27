package com.hxd.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("testDao")
public class TestDao extends BaseDao {
	   @Autowired
	   private JdbcTemplate jdbcTemplate;

	
public void save(List<Object[]>  name){
	
	String sql="insert into  user(userName) value(?)";
    jdbcTemplate.batchUpdate(sql,name);
}
}
