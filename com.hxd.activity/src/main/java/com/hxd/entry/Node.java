package com.hxd.entry;

import java.util.List;

public class Node{
	  public int nodeId;    //树的节点Id，区别于数据库中保存的数据Id。若要存储数据库数据的Id，添加新的Id属性；若想为节点设置路径，类中添加Path属性
      public String text;   //节点名称
      public List<Node> nodes;    //子节点，可以用递归的方法读取，方法在下一章会总结
	
            public Node() { }
            public Node(int id, String str, List<Node> node)
            {
                nodeId = id;
                text = str;
                nodes = node;
            }
        }