<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.user.servlets.financing.agreement.Zqzr"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.DzxyZqzr"%>
<%@page import="java.io.IOException"%>
<%@page import="freemarker.template.TemplateException"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="freemarker.template.Template"%>
<%@page import="freemarker.template.Configuration"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.DzxyDy"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Dzxy"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.DzxyManage"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_债权转让</title>
</head>
<body style="width:900px; margin:0 auto;font-size:14px;">
<%
int zqzrjlId = IntegerParser.parse(request.getParameter("id"));
int s = IntegerParser.parse(request.getParameter("s"));
%>
<%if(s!=1){ %>
<p class="clearfix pt10"><a target="_blank" href="<%=controller.getURI(request, Zqzr.class)%>?id=<%=zqzrjlId%>&s=1" class="btn btn01 fr">点击下载</a></p>
<%} %>
<%
		DzxyManage manage = serviceSession.getService(DzxyManage.class);
		Dzxy dzxy = manage.getZqzr(zqzrjlId);
		if (dzxy == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		DzxyZqzr dzxyZqzr = manage.getDzxyZqzr(zqzrjlId);
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
		valueMap.put("xy_no", dzxyZqzr.xy_no);
		valueMap.put("jf_zsxm", dzxyZqzr.t6141.F02== null?"":dzxyZqzr.t6141.F02);
		valueMap.put("jf_sfzh", dzxyZqzr.t6141.F07 == null?"":dzxyZqzr.t6141.F07);
		valueMap.put("jf_yhm", dzxyZqzr.t6110.F02);
		
		valueMap.put("yf_zsxm", dzxyZqzr.zqzr_yf_realName== null?"":dzxyZqzr.zqzr_yf_realName);
		valueMap.put("yf_sfzh", dzxyZqzr.zqzr_yf_sfzh== null?"":dzxyZqzr.zqzr_yf_sfzh);
		valueMap.put("yf_yhm", dzxyZqzr.zqzr_yf_loginName);
		
		
		valueMap.put("bid_title", dzxyZqzr.bdxq.F03);
		valueMap.put("bid_rate", dzxyZqzr.bdxq.F06);
		valueMap.put("bid_hkfs", dzxyZqzr.bdxq.F10.getChineseName());
		valueMap.put("bid_yzqqx", dzxyZqzr.bdxq.F09);
		valueMap.put("bid_hkr", dzxyZqzr.t6231.F06);
		valueMap.put("bid_dhqs", dzxyZqzr.t6231.F03);
		valueMap.put("bid_zqs", dzxyZqzr.t6231.F02);
		valueMap.put("bid_ychbxse", dzxyZqzr.zqzr_bid_ychbxse);
		
		valueMap.put("zqr_bjsr", dzxyZqzr.t6251.F05);
		valueMap.put("zqr_dsbx", dzxyZqzr.zqzr_zqr_dsbx);
		valueMap.put("zqr_tbsj", dzxyZqzr.t6251.F09);
		
		valueMap.put("bid_dqjz", dzxyZqzr.t6251.F07);
		
		valueMap.put("zqrz_zrjg", Formater.formatAmount(dzxyZqzr.t6260.F03));
		valueMap.put("zqrz_rate", Formater.formatAmount(dzxyZqzr.t6260.F08.multiply(dzxyZqzr.t6260.F03)));
		valueMap.put("zqrz_zrsj", TimestampParser.format(dzxyZqzr.t6262.F07,"yyyy-MM-dd"));
		
		valueMap.put("site_name", configureProvider.format(SystemVariable.SITE_NAME));
		valueMap.put("site_domain", configureProvider.format(SystemVariable.SITE_DOMAIN));
		valueMap.put("company_name", configureProvider.format(SystemVariable.COMPANY_NAME));
		
		
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