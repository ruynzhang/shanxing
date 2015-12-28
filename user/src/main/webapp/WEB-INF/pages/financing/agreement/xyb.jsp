 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.CjrList"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.utlis.Format"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.agreement.Xyb"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.IOException"%>
<%@page import="freemarker.template.TemplateException"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="freemarker.template.Template"%>
<%@page import="freemarker.template.Configuration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.DzxyDy"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Dzxy"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.DzxyManage"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta> 
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/other.css" />
<title>协议_信用标</title>
</head>
<body>
<%
int creditId = IntegerParser.parse(request.getParameter("id"));
int s = IntegerParser.parse(request.getParameter("s"));
%>
<%if(s!=1){ %>
<p class="clearfix pt10"><a target="_blank" href="<%=controller.getURI(request, Xyb.class)%>?id=<%=creditId%>&s=1" class="btn btn01 fr">点击下载</a></p>
<%} %>
<%
		DzxyManage manage = serviceSession.getService(DzxyManage.class);
		Dzxy dzxy = manage.getBidContent(creditId);
		SafetyManage userManage = serviceSession.getService(SafetyManage.class);
		Safety data = userManage.get();
		if (dzxy == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		DzxyDy dzxyDy =  manage.getDzxyXy(creditId);
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
		
		valueMap.put("bf_companyName",  dzxyDy.bf_companyName == null?"":dzxyDy.bf_companyName);
		valueMap.put("bf_address", dzxyDy.bf_address == null?"":dzxyDy.bf_address);
		
		valueMap.put("yq_rate", dzxyDy.yq_rate);
		valueMap.put("wyj_rate", dzxyDy.wyj_rate);
		
		valueMap.put("jk_jkyt", dzxyDy.t6231.F08);
		if(dzxyDy.bdxq.isSxbao==T6230_F13.S){
			BigDecimal tz_total=BigDecimal.ZERO;
			BigDecimal jk_lx=BigDecimal.ZERO;
			BigDecimal tz_total_all=BigDecimal.ZERO;
			BigDecimal jk_lx_all=BigDecimal.ZERO;
			List<CjrList> list=dzxyDy.cjrList;
			for(CjrList vo:list){
				if(vo.loginName.equals(data.username)){
					tz_total=tz_total.add(vo.cjje);
					jk_lx=jk_lx.add(vo.qbys.subtract(vo.cjje));
				}
				tz_total_all=tz_total_all.add(vo.cjje);
				jk_lx_all=jk_lx_all.add(vo.qbys.subtract(vo.cjje));
			}
			valueMap.put("jk_money_xx", tz_total);
			valueMap.put("jk_money_dx", Format.valuesToString(tz_total));
			valueMap.put("jk_lx", jk_lx);
			valueMap.put("jf_loginName", data.username);
			valueMap.put("jf_realName", data.name);
			valueMap.put("jklist", null);
			if(dzxyDy.yf_loginName.equals(data.username)){
				valueMap.put("jk_money_xx", tz_total_all);
				valueMap.put("jk_money_dx", Format.valuesToString(tz_total_all));
				valueMap.put("jk_lx", jk_lx_all);
				valueMap.put("jf_loginName", null);
				valueMap.put("jf_realName", null);
				valueMap.put("jklist", dzxyDy.cjrList);
			}
		}else{
			valueMap.put("jk_money_xx", dzxyDy.bdxq.F05);
			valueMap.put("jk_money_dx", dzxyDy.jk_money_dx);
			valueMap.put("jk_lx", dzxyDy.jk_lx.subtract(dzxyDy.bdxq.F05));
		}
		valueMap.put("jk_rate", Formater.formatRate(dzxyDy.bdxq.F06));
		valueMap.put("jk_jkqx", dzxyDy.bdxq.F09);
		valueMap.put("jk_hkqs", dzxyDy.t6231.F02);
		valueMap.put("jk_hkr", dzxyDy.jk_hkr);
		
		valueMap.put("slzc_no", "slzc"+DateParser.format(new Date(),"yyyyMM"));

		if(T6230_F10.YCFQ==dzxyDy.bdxq.F10){
			//YCFQ:本息到期一次付清
			valueMap.put("jk_hkfs", "1");
		}else if(T6230_F10.MYFX==dzxyDy.bdxq.F10){
			//MYFX:每月付息,到期还本;
			valueMap.put("jk_hkfs", "2");
		}else{
			valueMap.put("jk_hkfs", "");
		}
		
		
		valueMap.put("jk_ksr", DateParser.format(dzxyDy.t6231.F12,"yyyy年   MM月   dd日"));
		Calendar calendar = Calendar.getInstance();
        calendar.setTime(dzxyDy.t6231.F12);
        if(dzxyDy.t6231.F22==0){
        	calendar.add(Calendar.MONTH, dzxyDy.bdxq.F09);
        }else{
	        calendar.add(Calendar.DATE, dzxyDy.t6231.F22);
        }
        calendar.add(Calendar.DATE, dzxyDy.bdxq.F19);
		valueMap.put("jk_dqr", DateParser.format(calendar.getTime(),"yyyy年   MM月   dd日"));
		
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