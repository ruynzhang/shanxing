<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.variables.defines.URLVariable"%>
<%{
	BidManage investManage = serviceSession.getService(BidManage.class);
%>
<div class="clear"></div>
<div class="invest_con">
	<div class="tit">
		<span class="fl">投资列表</span><span class="fr f14"><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">更多&gt;&gt;</a></span>
	</div>
	<div class="info">
		<table width="100%" align="center" cellspacing="0">
			<tr class="big_tit">
				<td width="229">借款标题</td>
				<td width="152">金额</td>
				<td width="92">年利率</td>
				<td width="101">期限</td>
				<td width="106">还需金额</td>
				<td width="98" class="w100">进度</td>
				<td width="105" class="w120"></td>
			</tr>
			<%PagingResult<Bdlb> crePagingResult = investManage.searchAll(null, AbstractFrontServlet.INDEX_PAGING);Bdlb[] credits = crePagingResult.getItems();if (credits != null) {for (Bdlb credit : credits) {%>
			<tr class="all_bj">
				<td><div class="w250"><span class="xin ml30 mr10">
				<%if(credit.F16 == T6230_F11.S || credit.F17 == T6230_F13.S){%>保
	            <%}else if(credit.F18 == T6230_F14.S ){%>实
	            <%}else{%>信<%}%>
				
				</span><span class="w200"><a title="<%StringHelper.filterHTML(out, credit.F04);%>" href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class,credit.F02)%>">
			            <%StringHelper.filterHTML(out, StringHelper.truncation(credit.F04, 10));%></a></span></div></td>
				<td><span class="f16"><%=Formater.formatAmount(credit.F06) %></span><span class="f12">元</span></td>
				<td><span class="f16"><%=Formater.formatRate(credit.F07,false) %></span><span class="f12">%</span></td>
				<td><span class="f16"><%if(T6231_F21.S == credit.F19){out.print(credit.F20 + "<span class=\"f12\">天<span>");}else{out.print(credit.F10 + "<span class=\"f12\">个月</span>");} %></span></td>
				<td><span class="f16"><%=credit.F08%></span><span class="f12">元</span></td>
				<td>
					<%
					if(credit.F11 != T6230_F20.YFB) {%>
					<div class="pl30">
						<span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=(int)(credit.proess*100)%>"><em><%=Formater.formatProgress(credit.proess)%></em></strong></span>
					</div>
					 <%}else{ %>
	            	<span class="ln24"><%=TimestampParser.format(credit.F13,"yyyy-MM-dd HH:mm")%>即将开启</span>
	            <%} %>
				</td>
				<td>
					<span>
					<%if(credit.F11 == T6230_F20.TBZ){%><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class,credit.F02)%>" class="btn btn01 ml10">立即投标</a>
					<%}else if(credit.F11 == T6230_F20.DFK){ %><span class="btn btn06 ml10"><%=credit.F11.getChineseName() %></span>
					<%}else{ %><span class="btn btn02 ml10"><%=credit.F11.getChineseName() %></span>
					<%}%>
					</span>
				</td>
			</tr>
			<%}}%>
		</table>
	</div>
</div>
<%}%>