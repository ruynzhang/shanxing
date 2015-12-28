package com.dimeng.p2p.console.servlets.bid.hbgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.RedPacket;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.utlis.StrUtil;

public class OpRedp extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RedPacket record=(RedPacket)request.getAttribute("record");
		if(null!=record){
			forwardView(request, response, getClass());
			return;
		}
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		String id=request.getParameter("id");
		if(id!=null){ 
			record=manage.findById(StrUtil.Str2Int(id));
			request.setAttribute("record", record);
		}
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		RedPacket query = new RedPacket();
		query.parse(request);// 设置界面传来的参数
		try {
			if(query.id>0){
				manage.update(query);
			}else{
				manage.add(query);
			}
			getController().prompt(request, response, PromptLevel.WARRING,"保存成功");
			sendRedirect(request, response,getController().getURI(request, RedpList.class));
		} catch (Exception e) {
			request.setAttribute("record", query);
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
