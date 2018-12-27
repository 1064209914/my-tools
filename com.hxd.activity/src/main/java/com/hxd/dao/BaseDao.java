package com.hxd.dao;

 import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.entry.BaseEntity;
 
@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW )
 public abstract class BaseDao
 {
   @Autowired
   private HibernateTemplate hibernateTemplate;
   @Autowired
   private JdbcTemplate jdbcTemplate;
   
   public void sessionClear()
   {
     hibernateTemplate.getSessionFactory().getCurrentSession().clear();
   }
   
 

   public void merge(BaseEntity entity)
   {
     hibernateTemplate.merge(entity);
   }
   
 
 
 
 
   public Serializable saveEntity(BaseEntity entity)
   {
     return hibernateTemplate.save(entity);
   }
   
 
 
 
   public void removeEntity(BaseEntity entity)
   {
     hibernateTemplate.delete(entity);
   }
   
 
 
 
   public void updateEntity(BaseEntity entity)
   {
     hibernateTemplate.update(entity);
   }
   
 
 
 
 
 
   public BaseEntity getEntity(Class<?> entityClass, Serializable id)
   {
     return (BaseEntity)hibernateTemplate.get(entityClass, id);
   }
   
 
 
 
 
   @SuppressWarnings("rawtypes")
public List findByHQL(String queryString)
   {
     return hibernateTemplate.find(queryString, new Object[0]);
   }
   
 
 
 
 
   @SuppressWarnings({ "unchecked", "rawtypes" })
public void updateByHQL(final String queryString, final Object... values)
   {
     hibernateTemplate.execute(new HibernateCallback()
     {
       public Object doInHibernate(Session session) throws HibernateException {
         Query query = session.createQuery(queryString);
         for (int i = 0; i < values.length; i++)
           query.setParameter(i, values[i]);
         return Integer.valueOf(query.executeUpdate());
       }
     });
   }
   
 
 
 
 
 
 
   @SuppressWarnings("unchecked")
public List<Object[]> queryAllBySQL(final String queryString, final Object... values)
   {
     hibernateTemplate.setCacheQueries(false);
     @SuppressWarnings("rawtypes")
	List<Object[]> list = 
       (List)hibernateTemplate.execute(new HibernateCallback()
       {
         public Object doInHibernate(Session session) throws HibernateException
         {
           Query query = session.createSQLQuery(queryString);
           for (int i = 0; i < values.length; i++)
             query.setParameter(i, values[i]);
           return query.list();
         }
       });
     return list;
   }
   
 
 
 
 
 
 

   
 
 
 
 
   public List<Map<String, Object>> queryForList(String sql)
   {
     return jdbcTemplate.queryForList(sql);
   }
   
 
 
 
 
 
   public Map<String, Object> queryForMap(String sql)
   {
     return jdbcTemplate.queryForMap(sql);
   }
   
 
 
 
 
 
 
 
 
 
 
   public Session openSession()
     throws SQLException
   {
     return hibernateTemplate.getSessionFactory().openSession();
   }
}

