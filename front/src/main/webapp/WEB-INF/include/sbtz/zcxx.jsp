<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdysx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdylx"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.Enterprise"%>
<%@page import="com.dimeng.p2p.account.front.service.EnterpriseInfoManage"%>
<%{
	com.dimeng.p2p.modules.bid.front.service.BidManage investManage3 = serviceSession.getService(com.dimeng.p2p.modules.bid.front.service.BidManage.class);
	int id3 = IntegerParser.parse(request.getParameter("id"));
	com.dimeng.p2p.modules.bid.front.service.entity.Bdxq creditInfo3 = investManage3.get(id3);
	Bdylx[] dyxxs = investManage3.getDylb(id3);
	if(dyxxs != null && dyxxs.length >0){
		for(Bdylx dyxx:dyxxs){
	%>
		<br/><br/><%=dyxx.dyName %><br/><br/>
		<%Bdysx[] dysxs= investManage3.getDysx(dyxx.F01);
			if(dysxs != null && dysxs.length >0){
				for(Bdysx bdysx:dysxs){
		%>
		<%=bdysx.dxsxName %>：<%=bdysx.F04 %><br/>
		<%} %>

	<%}}} }%>

