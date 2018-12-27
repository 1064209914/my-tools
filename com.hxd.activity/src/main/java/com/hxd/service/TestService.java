package com.hxd.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxd.dao.TestDao;
import com.hxd.entry.TestUser;
import com.mysql.fabric.xmlrpc.base.Array;

@Service("testService")
public class TestService{
	@Autowired
	private TestDao testDao;

	public void saveEntity(String  user){
		Object[]  objects={user}; 
		List<Object[]> list =new ArrayList<Object[]>();
		list.add(objects);
		
		testDao.save(list);
	}

	public void save(TestUser user) {
		testDao.saveEntity(user);
		
	}
	
}

