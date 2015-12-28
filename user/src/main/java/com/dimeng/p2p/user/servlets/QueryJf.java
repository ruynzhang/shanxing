package com.dimeng.p2p.user.servlets;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dimeng.framework.http.servlet.AbstractServlet;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfUtil;
import com.shanlin.framework.communication.http.HttpUtil;

/***
 * 查询用户积分
 * @author yangjh
 *
 */
public class QueryJf extends AbstractServlet {

	private static final long serialVersionUID = 1L;
	
	protected static Log logger = LogFactory.getLog(QueryJf.class);
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Integer credits=0;
		try{
			int userId=serviceSession.getSession().getAccountId();
			TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class); 
			String post_url=JfUtil.api_url()+"&user="+manage.getUserName(userId)+"&arg=12";
			Map<String, Object> post_result=HttpUtil.create().get(post_url).execute2Map();
			if("1".equals(post_result.get("status").toString())){
				credits=Integer.parseInt(post_result.get("credits").toString());
			}
		}catch(Exception e){
			logger.error("query jf error:"+e);
		}
		response.getWriter().print(credits);
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		sendRedirect(request, response,getController().getViewURI(request, getClass()));
	}

}
