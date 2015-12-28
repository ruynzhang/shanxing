package com.dimeng.p2p.console.servlets.system.jpush;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.enums.T7160_F07;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.JpushManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

@Right(id = "P2P_C_SYS_ADDJPUSH", name = "添加APP推送")
public class AddJpush extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;
	private static final String  masterSecret="7529c0c706b5b2090f864f47";
	private static final String  appKey="6deac6d8165a85cddb6ea14d";

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		JpushManage jpushManage = serviceSession.getService(JpushManage.class);
		T7160_F07 sendType = EnumParser.parse(T7160_F07.class,
				request.getParameter("sendType"));
		String content = request.getParameter("content");
		String title = request.getParameter("title");
		String url = request.getParameter("url");
		String jtype=request.getParameter("jtype");
		//内部模块类型
		String insiModel =request.getParameter("insiModel");
		int jputype =0;
		int jumpModule =0;
		if(jtype!=null && !"".equals(jtype)){
			jputype=Integer.parseInt(jtype);
		}
		if(insiModel!=null && !"".equals(insiModel)){
			jumpModule=Integer.parseInt(insiModel);
		}
		String userName = request.getParameter("userName");
		String[] userNames = new String[0];
		if (!StringHelper.isEmpty(userName)) {
			userNames = userName.split("\\s");
		}
		
		//附加字段
		//键值
		String[] jkeys =request.getParameterValues("jkey");
		//value值
		String[] jvalues =request.getParameterValues("jvalue");
		
		Map<String, String> params = new HashMap<String, String>();
		
		
		for(int i=0;i<jkeys.length;i++){
			if("".equals(jkeys[i]) || jkeys[i]==null){
				continue;
			}else{
				params.put(jkeys[i], jvalues[i]);
			}
		}
		
		//保存数据库,推送
		jpushManage.addJpushService(masterSecret, appKey, sendType, title, content,url,jputype,jumpModule, params,userNames);
		//进行极光推送
		//smsManage.conSoleJpush(masterSecret, appKey, content,url,title);
		
		sendRedirect(request, response,
				getController().getURI(request, JpushList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
