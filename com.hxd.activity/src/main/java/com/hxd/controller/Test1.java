package com.hxd.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hxd.entry.Node;
import com.hxd.entry.TestUser;
import com.hxd.service.TestService;

@Controller
public class Test1 {
	@Autowired
	private TestService testService;
	
	/*//用来查看配置SpringMvc是否能成功运行
	@RequestMapping("/viewPage.do")
	public String test(){
		return "index";
	}*/
	@RequestMapping("/viewPage.do")
	public ModelAndView test(){
		ModelAndView mv=new ModelAndView();
		List<Node>  nodeA = new ArrayList<Node>();
         nodeA.add(new Node(4, "A01", null));
         nodeA.add(new Node(5, "A02", null));
         nodeA.add(new Node(6, "A03", null));

         List<Node> nodeB = new ArrayList<Node>();
         nodeB.add(new Node(7, "B07", null));
         nodeB.add(new Node(8, "B08", null));
         nodeB.add(new Node(9, "B09", null));

         List<Node> nodes = new ArrayList<Node>();
         nodes.add(new Node(1, "A01", nodeA));
         nodes.add(new Node(2, "B02", nodeB));
         nodes.add(new Node(3, "A03", null));
         mv.addObject("nodes", nodes);
         mv.setViewName("tree");
         return mv;
	}
	
	/*保存实体*/
	@RequestMapping("/save1")
	public void save1(){
String name="张三";
		testService.saveEntity(name);
	}
	/*保存实体*/
	@RequestMapping("/save")
	public void save(){
		TestUser user=new TestUser();
		user.setName("李四");
		testService.save(user);
	}
}
