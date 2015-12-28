package com.dimeng.p2p.console.servlets.account.staff;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.AbstractThirdServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AddAccount extends AbstractThirdServlet {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		Map<String, Object> map = new HashMap<>();
		try{
			StaffManage manage = serviceSession.getService(StaffManage.class);
			String loginName = request.getParameter("loginName");
			String mobilePhone = request.getParameter("mobilePhone");
			if(StringUtils.isBlank(loginName) || StringUtils.isBlank(mobilePhone)){
				throw new IllegalArgumentException("非法请求");
			}
			String myCode = manage.addAccount(serviceSession, loginName, mobilePhone);
			map.put("isSuccess", Boolean.TRUE);
			map.put("tgCode", myCode);
		}catch(Exception e){
			log.error(e.getMessage(), e);
			map.put("isSuccess", Boolean.FALSE);
			map.put("content", e.getMessage());
		}
		serviceSession.commit();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(Include.ALWAYS);
		mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(mapper.writeValueAsString(map));
	}
	
}
