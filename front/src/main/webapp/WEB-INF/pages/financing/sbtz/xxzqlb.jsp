<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.S62.entities.T6240"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.xxzq.Xxzq"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.QyBidQuery"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.common.enums.CreditTerm"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.BidQuery"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Tztjxx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<html>
<head>
<title>线下债权转让-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%!static final String RATE_KEY="r"; static final String PROGRESS_KEY="p";static final String TYPE_KEY="t";static final String MULTISELECT_KEY="s";
	static final String ORDER_KEY="o";%>
	<%
	BidManage bidManage = serviceSession.getService(BidManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	Tztjxx total=bidManage.getStatisticsXxzq();
	T6211[] t6211s= bidManage.getBidType();
	T5124[] t5124s= bidManage.getLevel();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,RATE_KEY,PROGRESS_KEY);
	String[] values=requestWrapper.getParameterValues(TYPE_KEY);
	PagingResult<Bdlb> result = bidManage.searchXXZQ(
	new QyBidQuery() {
		public int getRate() {
			int rate=IntegerParser.parse(requestWrapper.getParameter(RATE_KEY));
			return rate;
			}
		public int getJd() {
			int progress=IntegerParser.parse(requestWrapper.getParameter(PROGRESS_KEY));
			return progress;
			}
		public T6230_F20 getStatus() {
			return EnumParser.parse(T6230_F20.class, requestWrapper.getParameter(TYPE_KEY));
			}
		public int getOrder(){
			return 0;
		}
	}, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}
	});

%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
   <div class="w1002 clearfix">
     <div>
       <div class="item_list">
        <div class="plan_tab clearfix">
        <ul>
          
          <li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>">企业标</a></li>
          <li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Grlb.class)%>">个人标</a></li>
          <li class="hover">线下债权转让</li>
          <li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">线上债权转让</a></li>
          <li style="border-left:1px solid #ddd;padding:0;"></li>
        </ul>
        </div>
         <div class="bd jtab-con" >
           <div class="screening">
             <div class="til">筛选投资项目</div>
             <div class="con">
               <dl class="filtrate">
                 <dt>年化收益</dt>
                 
                 	<dd>
                 	<%if(parameter.contains(RATE_KEY)){parameter.remove(RATE_KEY);%>
				         <a href="<%=parameter.toString()%>">不限</a>
				         <%}else{%>
				        <a class="cur" href="<%=parameter.toString()%>">不限</a>
				         <%}%>
							<%if(parameter.contains(RATE_KEY, "1")){parameter.remove(RATE_KEY, "1");%>
					         <a class="cur" href="<%=parameter.toString()%>">10%以下</a>
					         <%} else { parameter.set(RATE_KEY, "1");%>
					         <a href="<%=parameter.toString()%>">10%以下</a>
					         <%}%>
							<%if(parameter.contains(RATE_KEY, "2")){parameter.remove(RATE_KEY, "2");%>
					          <a class="cur" href="<%=parameter.toString()%>">10%-15%</a> 
					         <%} else { parameter.set(RATE_KEY, "2");%>
					         <a href="<%=parameter.toString()%>">10%-15%</a> 
					         <%}%>
							<%if(parameter.contains(RATE_KEY, "3")){parameter.remove(RATE_KEY, "3");%>
					          <a class="cur" href="<%=parameter.toString()%>">15%-20%</a> 
					         <%} else { parameter.set(RATE_KEY, "3");%>
					        <a href="<%=parameter.toString()%>">15%-20%</a> 
					         <%}%>
					         <%if(parameter.contains(RATE_KEY, "4")){parameter.remove(RATE_KEY, "4");%>
					          <a class="cur" href="<%=parameter.toString()%>">20%以上</a> 
					         <%} else { parameter.set(RATE_KEY, "4");%>
					        <a href="<%=parameter.toString()%>">20%以上</a> 
					         <%}%>
                 	</dd>
               </dl>
               <dl class="filtrate">
                 <dt>融资进度</dt>
                 <dd>
                 <%if(parameter.contains(PROGRESS_KEY)){parameter.remove(PROGRESS_KEY);%>
				         <a  href="<%=parameter.toString()%>">不限</a>
				         <%}else{%>
				         <a class="cur" href="<%=parameter.toString()%>">不限</a>
				         <%}%>
							<%if(parameter.contains(PROGRESS_KEY, "1")){parameter.remove(PROGRESS_KEY, "1");%>
					          <a class="cur" href="<%=parameter.toString()%>">50%以下</a>
					         <%} else { parameter.set(PROGRESS_KEY, "1");%>
					         <a href="<%=parameter.toString()%>">50%以下</a>
					         <%}%>
							<%if(parameter.contains(PROGRESS_KEY, "2")){parameter.remove(PROGRESS_KEY, "2");%>
					          <a class="cur" href="<%=parameter.toString()%>">50%-80%</a>
					         <%} else { parameter.set(PROGRESS_KEY, "2");%>
					         <a  href="<%=parameter.toString()%>">50%-80%</a>
					         <%}%>
					         <%if(parameter.contains(PROGRESS_KEY, "3")){parameter.remove(PROGRESS_KEY, "3");%>
					          <a class="cur" href="<%=parameter.toString()%>">80%以上</a>
					         <%} else { parameter.set(PROGRESS_KEY, "3");%>
					         <a href="<%=parameter.toString()%>">80%以上</a>
					         <%}%>
					</dd>         
               </dl>
               <dl class="filtrate">
                 <dt>项目状态</dt>
                 <dd>
                 <%if(parameter.contains(TYPE_KEY)){parameter.remove(TYPE_KEY);%>
				         <a href="<%=parameter.toString()%>">不限</a> 
				         <%}else{%>
				          <a class="cur" href="<%=parameter.toString()%>">不限</a> 
				         <%}%>
						<%if(parameter.contains(TYPE_KEY, "TBZ")){parameter.remove(TYPE_KEY, "TBZ");%>
				          <a href="<%=parameter.toString()%>" class="cur">可投资</a> 
				         <%} else { parameter.set(TYPE_KEY, "TBZ");%>
				         <a href="<%=parameter.toString()%>">可投资</a> 
				         <%}%>
						<%if(parameter.contains(TYPE_KEY, "HKZ")){parameter.remove(TYPE_KEY, "HKZ");%>
				          <a href="<%=parameter.toString()%>" class="cur">还款中</a> 
				         <%} else { parameter.set(TYPE_KEY, "HKZ");%>
				         <a href="<%=parameter.toString()%>">还款中</a> 
				         <%}%>
						<%if(parameter.contains(TYPE_KEY, "YJQ")){parameter.remove(TYPE_KEY, "YJQ");%>
				          <a href="<%=parameter.toString()%>" class="cur">已还款</a> 
				         <%} else { parameter.set(TYPE_KEY, "YJQ");%>
				         <a href="<%=parameter.toString()%>">已还款</a>
				         <%}%>
					 </dd>
               </dl>
             </div>
           </div>
           <div class=" w1002">
           <div class="clearfix">
             <div class="tzlc_bg">
               <div class="tzlb_title fl">投资列表<a target="_blank" href="<%=controller.getURI(request, com.dimeng.p2p.front.servlets.credit.Lcjsq.class)%>" class="multi">理财计算器</a></div>
               <ul class="total_money fr tc pb20">
                   <li><span class="mt10">累计成交总金额<br/>
                   <%if(total.totleMoney.doubleValue()>=100000000){%>
		        	   <em class="f24"><%=Formater.formatAmount(total.totleMoney.doubleValue()/100000000)%></em>亿元
		        	<%}else if(total.totleMoney.doubleValue()>=10000 && total.totleMoney.doubleValue() <100000000){%>
		        		<em class="f24"><%=Formater.formatAmount(total.totleMoney.doubleValue()/10000)%></em>万元
		        	<%}else{%>
		        		<em class="f24"><%=Formater.formatAmount(total.totleMoney)%></em>元
		        	<%}%>
                   </span><span class="line ml30"></span></li>
                   <li><span class="mt10">累计成交总笔数<br/><em class="f24"><%=total.totleCount%></em>笔</span><span class="line ml30"></span></li>
                   <li><span class="mt10">为用户累计赚取<br/>
                   <%
		           if(total.userEarnMoney.doubleValue()>=100000000){%>
		        	   <em class="f24"><%=Formater.formatAmount(total.userEarnMoney.doubleValue()/100000000)%></em>亿元
		        	<%}else if(total.userEarnMoney.doubleValue()>=10000 && total.userEarnMoney.doubleValue() <100000000){%>
		        		<em class="f24"><%=Formater.formatAmount(total.userEarnMoney.doubleValue()/10000)%></em>万元
		        	<%}else{%>
		        		<em class="f24"><%=Formater.formatAmount(total.userEarnMoney)%></em>元
		        	<%}%>
                   </span></li>
               </ul>
               <div class="clear"></div>
               <div class="invest_con">
                 <div class="invest_con">
        <div class="info">  
          <table width="100%" cellspacing="0">
         <tr class="big_tit">
            <td width="212">转让标题</td>
            <td width="111" >贷款金额</td>
            <td width="79">年利率</td>
            <td width="81">贷款期限</td>
            <td width="89">还需金额</td>
            <td width="131" class="w100">进度</td>
            <td width="101" class="w150"></td>
          </tr> 
           <%
          Bdlb[] creditInfos=result.getItems();if(creditInfos!=null){for (Bdlb creditInfo : creditInfos) {if (creditInfo == null) {continue;}
           %>
          <tr class="all_bj">
            <td><div class="w250"><span class="xin ml30 mr10">
            <%if(creditInfo.F16 == T6230_F11.S || creditInfo.F17 == T6230_F13.S){%>保
            <%}else if(creditInfo.F18 == T6230_F14.S ){%>实
            <%}else{%>信<%}%>
            <%
            T6240 t6240 = bidManage.getT6240(creditInfo.F02);
            %>
            </span><span class="w200"><a title="<%=t6240.F05%>" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>">
            <%StringHelper.filterHTML(out, StringHelper.truncation(t6240.F05, 10));%>
            </a></span></div></td>
            <td><%
            	if(creditInfo.F06.doubleValue()>=10000){%><span class="f16"><%=creditInfo.F06.doubleValue()/10000%></span>
            	<span class="f12">万元</span>
            	<%}else{%><span class="f16"><%=Formater.formatAmount(creditInfo.F06)%></span><span class="f12">元</span><%}%>
            </td>
            <td><span class="f16"><%=Formater.formatRate(creditInfo.F07,false)%></span><span class="f12">%</span></td>
            <%-- <td><span class="f16"><%=creditInfo.F10%></span><span class="f12">个月</span> </td> --%>
            <td><span class="f16"><%if(T6231_F21.S == creditInfo.F19){out.print(creditInfo.F20 + "<span class=\"f12\">天<span>");}else{out.print(creditInfo.F10 + "<span class=\"f12\">个月</span>");} %></span></td>
            <td><%
            	if(creditInfo.F08.doubleValue()>=10000){%><span class="f16"><%=creditInfo.F08.doubleValue()/10000%></span>
            	<span class="f12">万元</span>
            	<%}else{%><span class="f16"><%=Formater.formatAmount(creditInfo.F08)%></span><span class="f12">元</span><%}%></td>
            <td>
            	<%if(creditInfo.F11 != T6230_F20.YFB) {%>
	            <div class="pl30"><span class="ui-list-field w110">
	            <strong class="ui-progressbar-mid ui-progressbar-mid-<%=(int)(creditInfo.proess*100)%>"><em><%=Formater.formatProgress(creditInfo.proess)%></em></strong></span>
	            </div>
	            <%}else{ %>
	            	<span class="ln24"><%=TimestampParser.format(creditInfo.F13,"yyyy-MM-dd HH:mm")%>即将开启</span>
	            <%} %>
            </td>
            <td><%if(creditInfo.F11 == T6230_F20.TBZ){%>
            	<span><a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" class="btn btn01 ml15">立即投标</a></span>
            	<%}else{%>
            	<%if(creditInfo.F11 == T6230_F20.HKZ) {%><span class="btn btn02 ml15">还款中</span><%}else{%><span class="btn btn06 ml10"><%=creditInfo.F11.getChineseName() %></span><%}%><%}%>
            </td>
          </tr>
           <%}}%>
    </table>
        </div>
       <%AbstractFinancingServlet.rendPaging(out, result,controller.getPagingURI(request, Xxzqlb.class),parameter.getQueryString());%>

      </div>
               </div>
               <div class="clear"></div>
             </div>
           </div>
           </div>
         </div>
         
       </div>
       <!--投资项目列表-->
     </div>
  </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>