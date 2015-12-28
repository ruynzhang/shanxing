package com.dimeng.p2p.user.servlets.mobile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S10.entities.RedPacketRecord;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.util.Formater;
import com.dimeng.util.parser.IntegerParser;

public class RedPaper extends AbstractMobileServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final int size=IntegerParser.parse(request.getParameter("size"));
	    final int page=IntegerParser.parse(request.getParameter("page"));
	    //用来区分1.已使用，2未使用，3已过期
		int type=IntegerParser.parse(request.getParameter("type"));
		
		final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
		int userId=serviceSession.getSession().getAccountId();
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		
		RedPacketRecord query = new RedPacketRecord();
		query.parse(requestWrapper);//设置界面传来的参数
		if(type==1){
		   query.state=12;
		}else if(type==2){
		   query.state=11;
		}else if(type==3){
		   query.state=4;
		}
		query.userId=userId;
		
		PagingResult<RedPacketRecord> list = manage.getListRecord(query, new Paging() {
			@Override
			public int getSize() {
				return size;
			}
			@Override
			public int getCurrentPage() {
				return page;
			}
		});
		
		RedPacketRecord[] vos=list.getItems();
		StringBuilder buff = new StringBuilder();
		buff.append("{\"hasNext\":").append(list.getPageCount()>page).append(",");
		buff.append("\"content\":[");
		if (vos != null && vos.length > 0) {
			for (RedPacketRecord record : vos) {
				buff.append("{\"ramount\":\"").append(record.amount.intValue()).append("\",");
        		buff.append("\"rsource\":\"").append(getSource(record.source)).append("\",");
        		buff.append("\"ranges\":\"").append(record.ranges.intValue()).append("\",");
        		buff.append("\"state\":\"").append(record.state).append("\",");
        		buff.append("\"startTime\":\"").append(Formater.formatDate(record.startTime)).append("\",");
        		buff.append("\"endTime\":\"").append(Formater.formatDate(record.endTime)).append("\"");
        		buff.append("},");
			}
        	buff.deleteCharAt(buff.length() - 1);
		}
		buff.append("]}");
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(buff.toString());
		response.getWriter().flush();
		
	}
	
	public String getSource(int num){
		if(num==1){return "手动发放";}
		else if(num==2){return "注册";}
		else if(num==3){return "推广";}
		return null;
	}

}
