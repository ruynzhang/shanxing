<%@page import="com.dimeng.p2p.S61.entities.T6163"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.Enterprise"%>
<%@page import="com.dimeng.p2p.account.front.service.EnterpriseInfoManage"%>
<%{
	com.dimeng.p2p.modules.bid.front.service.BidManage investManage2 = serviceSession.getService(com.dimeng.p2p.modules.bid.front.service.BidManage.class);
	int id2 = IntegerParser.parse(request.getParameter("id"));
	com.dimeng.p2p.modules.bid.front.service.entity.Bdxq creditInfo2 = investManage2.get(id2);
	EnterpriseInfoManage infoManage2 = serviceSession.getService(EnterpriseInfoManage.class);
	T6163[] t6163s = infoManage2.search(creditInfo2.F02);
	if(t6163s != null && t6163s.length>0){	
%>
<div class="pub_title pt10"><span class="fl">账务状况</span></div>
    <div class="plan_tab_con01 clearfix">
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc">
  <tr class="leve_titbj">
    <td>年份</td>
    <td>主营收入(万)</td>
   <!--  <td> 毛利润(万) </td> -->
    <td>净利润(万)</td>
    <td> 总资产(万) </td>
    <td> 净资产(万) </td>
    <td>备注</td>
  </tr>
   <%for(T6163 t6163:t6163s){if(t6163 == null){continue;} %>
  <tr>
    <td><%=t6163.F02 %>年</td>
    <td><%=Formater.formatAmount(t6163.F03) %></td>
<%--     <td><%=Formater.formatAmount(t6163.F04) %></td> --%>
    <td><%=Formater.formatAmount(t6163.F05) %></td>
    <td><%=Formater.formatAmount(t6163.F06) %></td>
    <td><%=Formater.formatAmount(t6163.F07) %></td>
    <td><%StringHelper.filterHTML(out, t6163.F08);%></td>
  </tr>
  <%} %>
</table>
    </div>
<%} }%>

