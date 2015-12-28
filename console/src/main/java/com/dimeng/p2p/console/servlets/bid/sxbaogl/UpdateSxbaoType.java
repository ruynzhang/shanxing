package com.dimeng.p2p.console.servlets.bid.sxbaogl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S62.entities.SxbaoType;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.SxbaoManage;

public class UpdateSxbaoType extends AbstractBidServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		String id = request.getParameter("id");
		if(id != null){
			Long cid = Long.valueOf(id);
			SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
			SxbaoType sxbaoType = sxbaoManage.findTypeById(cid);
			request.setAttribute("sxbaoType", sxbaoType);
			forwardView(request, response, AddSxbaoType.class);
		}else{
			forwardView(request, response, SxbaoTypeList.class);
		}
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		serviceSession.openTransactions();
		SxbaoType sxbaoType = new SxbaoType();
		sxbaoType.parse(request);
		if(sxbaoType.id == null){
			return;
		}
		try{
			SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
			SxbaoType dbType = sxbaoManage.findTypeById(sxbaoType.id);
			//判断标题是否存在
			if(!dbType.name.equals(sxbaoType.name) && sxbaoManage.isExistTypeTitle(sxbaoType.name)){
				throw new ParameterException(sxbaoType.name + ":已存在的名称");
			}
			sxbaoManage.updateType(sxbaoType);
			getController().prompt(request, response, PromptLevel.WARRING,
					"保存成功");
			processGet(request, response, serviceSession);
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException || throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING, throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
