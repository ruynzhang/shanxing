 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.htgl.Xydb"%>
<%@page import="java.io.IOException"%>
<%@page import="freemarker.template.TemplateException"%>
<%@page import="freemarker.template.Configuration"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.DzxyDy"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Dzxy"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.DzxyManage"%>
<%@page import="freemarker.template.Template"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta> 
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_抵押担保</title>
</head>
<body>
<%
int creditId = IntegerParser.parse(request.getParameter("id"));
%>
<p class="clearfix pt10"><a target="_blank" href="<%=controller.getURI(request, Xydb.class)%>?id=<%=creditId%>&s=1" class="btn btn01 fr">点击下载</a></p>
<%
		DzxyManage manage = serviceSession.getService(DzxyManage.class);
		Dzxy dzxy = manage.getBidContent(creditId);
		if (dzxy == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		DzxyDy dzxyDy =  manage.getDzxyDy(creditId);
		final Envionment envionment = configureProvider.createEnvionment();

		Map<String, Object> valueMap = new HashMap<String, Object>() {
		
				private static final long serialVersionUID = 1L;
			
				@Override
				public Object get(Object key) {
					Object object = super.get(key);
					if (object == null) {
						return envionment == null ? null : envionment.get(key.toString());
					}
					return object;
				}
			};
		valueMap.put("xy_no", dzxyDy.xy_no);
		valueMap.put("jklist", dzxyDy.cjrList);
		
		valueMap.put("yf_loginName", dzxyDy.yf_loginName);
		if(null != dzxyDy.t6141){
			valueMap.put("yf_card", dzxyDy.t6141.F07);
			valueMap.put("yf_realName", dzxyDy.t6141.F02);
		}
		
		valueMap.put("bf_companyName", dzxyDy.bf_companyName == null?"":dzxyDy.bf_companyName);
		valueMap.put("bf_address", dzxyDy.bf_address == null?"":dzxyDy.bf_address);
		
		valueMap.put("df_companyName", dzxyDy.df_companyName== null?"":dzxyDy.df_companyName);
		valueMap.put("df_address", dzxyDy.df_address== null?"":dzxyDy.df_address);
		
		valueMap.put("yq_rate", dzxyDy.yq_rate);
		valueMap.put("wyj_rate", dzxyDy.wyj_rate);
		
		valueMap.put("jk_jkyt", dzxyDy.t6231.F08);
		valueMap.put("jk_money_xx", dzxyDy.bdxq.F05);
		valueMap.put("jk_money_dx", dzxyDy.jk_money_dx);
		valueMap.put("jk_rate", Formater.formatRate(dzxyDy.bdxq.F06));
		valueMap.put("jk_jkqx", dzxyDy.bdxq.F09);
		valueMap.put("jk_hkqs", dzxyDy.t6231.F02);
		valueMap.put("jk_hkr", dzxyDy.jk_hkr);
		valueMap.put("jk_ksr", DateParser.format(dzxyDy.t6231.F12,"yyyy-MM-dd"));
		Calendar calendar = Calendar.getInstance();
        calendar.setTime(dzxyDy.t6231.F12);
        calendar.add(Calendar.MONTH, dzxyDy.bdxq.F09);
		valueMap.put("jk_dqr", DateParser.format(calendar.getTime(),"yyyy-MM-dd"));
		
		valueMap.put("hklist", dzxyDy.hkjh);
		
		valueMap.put("site_name", configureProvider.format(SystemVariable.SITE_NAME));
		valueMap.put("site_domain", configureProvider.format(SystemVariable.SITE_DOMAIN));
		
		
	Configuration cfg = new Configuration();
	Template template = new Template(dzxy.xymc, dzxy.content, cfg);
	try {
		
		template.process(valueMap, out);
	} catch (TemplateException e) {
		throw new IOException(e);
	}
%>
</body>
</html>