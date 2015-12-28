<%@page import="com.dimeng.p2p.account.front.service.entity.Enterprise"%>
<%@page import="com.dimeng.p2p.account.front.service.EnterpriseInfoManage"%>
<%{
	com.dimeng.p2p.modules.bid.front.service.BidManage investManage1 = serviceSession.getService(com.dimeng.p2p.modules.bid.front.service.BidManage.class);
	int id1 = IntegerParser.parse(request.getParameter("id"));
	com.dimeng.p2p.modules.bid.front.service.entity.Bdxq creditInfo1 = investManage1.get(id1);
	EnterpriseInfoManage infoManage1 = serviceSession.getService(EnterpriseInfoManage.class);
	Enterprise enterprise = infoManage1.get(creditInfo1.F02);
	if(enterprise != null){
	%>
    <div class="pub_title pt10"><span class="fl">企业信息</span></div>
    <div class="plan_tab_con clearfix">
    	<div class="plan_p">
        <p>注册年限：<%=enterprise.F07%> 年</p>
        
        <p>注册资金：<%=Formater.formatAmount(enterprise.F08)%> 万元</p>
        <p>资产净值：<%=Formater.formatAmount(enterprise.F14)%> 万元</p>
        <p>上年度经营现金流入：<%=Formater.formatAmount(enterprise.F15)%> 万元</p>
        <p>行业：<%StringHelper.filterHTML(out, enterprise.F09); %></p>
        <p>经营情况：<%StringHelper.filterHTML(out, enterprise.F17); %></p>
        <p>涉诉情况：<%StringHelper.filterHTML(out, enterprise.F18); %></p>
        <p>征信记录：<%StringHelper.filterHTML(out, enterprise.F19); %></p>
        </div>                         
    </div>
<%}} %>

