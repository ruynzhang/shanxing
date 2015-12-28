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
import com.fasterxml.jackson.databind.util.JSONPObject;

public class IsExistValue extends AbstractThirdServlet {

	protected static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		Map<String, Object> map = new HashMap<>();
		try {
			StaffManage manage = serviceSession.getService(StaffManage.class);
			String value = request.getParameter("value");
			String typeStr = request.getParameter("type");
			if(StringUtils.isBlank(value) || StringUtils.isBlank(typeStr)){
				throw new IllegalArgumentException("非法请求");
			}
			int type = Integer.valueOf(typeStr);
			String[] arr = manage.getLoginNameAndMobileAndCode(type, value);
			map.put("isSuccess", Boolean.TRUE);
			map.put("isExists", arr != null);
			if(arr != null){
				map.put("loginName", arr[0]);
				map.put("mobilePhone", arr[1]);
				map.put("tgCode", arr[2]);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			map.put("isSuccess", Boolean.FALSE);
			map.put("content", e.getMessage());
		}
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(Include.ALWAYS);
		mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(mapper.writeValueAsString(new JSONPObject("callbackIsExistValue", map)));
	}

}
