<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
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
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<html>
<head>
<title>企业标-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
</head>
<%!static final String RATE_KEY="r"; static final String PROGRESS_KEY="p";static final String TYPE_KEY="t";static final String MULTISELECT_KEY="s";
	static final String ORDER_KEY="o";%>
	<%
	
	BidManage bidManage = serviceSession.getService(BidManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	
	Tztjxx total=bidManage.getStatisticsQy();
	T6211[] t6211s= bidManage.getBidType();
	T5124[] t5124s= bidManage.getLevel();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.Index.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,RATE_KEY,PROGRESS_KEY);
	String[] values=requestWrapper.getParameterValues(TYPE_KEY);
	 PagingResult<Bdlb> result = bidManage.searchQy(
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
	},T6110_F06.FZRR, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}
	}); 
	 
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<!--内容-->
<!--banner-->
<div class="zq_banner">
<div class="banner"></div>
</div>
<!--banner-->

<!--计算器-->
<div class="calcul">
	<div class="clearfix mb20"><a href="<%=controller.getURI(request, com.dimeng.p2p.front.servlets.credit.Lcjsq.class)%>" class="an fl"><i class="ico01"></i>理财计算器</a><a href="<%=controller.getViewURI(request, Index.class)%>" class="an fr"><i class="ico02"></i>新手指南</a></div>
    <div class="search clearfix mb10"><input name="" type="text" class="inp" /><input name="" type="button" class="ico03" /></div>
    <div class="clearfix mb20"><span class="f20">筛选条件</span><a href="<%configureProvider.format(out,URLVariable.FINANCING_CENTER);%>" class="green fr mt5">重置</a></div>
    <div class="clearfix screening">
        <dl>
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
        <dl>
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
        <dl>
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
<!--计算器-->

<!--债权转让列表-->
<div  class="w1002 pb30">
	<div class="zq_title clearfix">
    <div class="zq_tab" >
    <ul>
      <li id="one1" onclick="setTab('one',1,5)" class="hover">企业标</li>
      <li id="one2" onclick="setTab('one',2,5)"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Grlb.class)%>">个人标</a></li>
      <li id="one3" onclick="setTab('one',3,5)"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">债权转让</a></li>
    </ul>
    <div class="clear"></div>
    </div>
    
    <div class="bd jtab-con" id="con_one_1">
        <ul class="zq_li">
        <%
          Bdlb[] creditInfos=result.getItems();
          if(creditInfos!=null){
        	  for (int i=0;i<creditInfos.length;i++) {
        		  Bdlb creditInfo = creditInfos[i];
        		  if (creditInfo == null) {continue;}
        %>
        <li class="clearfix">
        <div class="content">
       	  <div class="w112 fl mr40"><img src="<%=controller.getStaticPath(request)%>/images/zq_img01.jpg" width="112" height="128" /></div>
            <div class="w180 fl mt20">
            	<p class="zq_tilist"><a href="javascript:void(0);" onclick="openShutManager(this,'box<%=i%>',false)"><%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 10));%></a></p>
                <p class="f12 blue_ls"><a href="#" class="blue_ls">贷款信息</a> | <a href="#" class="blue_ls">审核记录</a> | <a href="#" class="blue_ls">投标记录</a></p>
            </div>
      		<div class="w150 fl ml20 mt20">
            	<p class="clearfix">
            	    <span class="xin mr10 ml10">
            	   <%if(creditInfo.F16 == T6230_F11.S || creditInfo.F17 == T6230_F13.S){%>保
            <%}else if(creditInfo.F18 == T6230_F14.S ){%>实
            <%}else{%>信<%}%>
            	    </span>
            	    <span class="f18"><%=Formater.formatRate(creditInfo.F07,false)%></span><span class="f12">%</span>
            	</p>
                <p>
                                                贷款金额：
                  <%if(creditInfo.F11 == T6230_F20.HKZ || creditInfo.F11 == T6230_F20.YJQ || creditInfo.F11 == T6230_F20.YDF){
            		creditInfo.F06 = creditInfo.F06.subtract(creditInfo.F08);
            		creditInfo.proess = 1;
            		creditInfo.F08 = new BigDecimal(0);
            	}
            	if(creditInfo.F06.doubleValue()>=10000){%><span class="f18"><%=creditInfo.F06.doubleValue()/10000%></span>
            	<span class="f12">万元</span>
            	<%}else{%><span class="f18"><%=Formater.formatAmount(creditInfo.F06)%></span><span class="f12">元</span><%}%>
                </p>
            </div>
            
     		 <div class="w170 fl ml20 mt20 tc">
     		 
                贷款期限：<span class="f18"><%if(T6231_F21.S == creditInfo.F19){out.print(creditInfo.F20 + "<span class=\"f12\">天<span>");}else{out.print(creditInfo.F10 + "<span class=\"f12\">个月</span>");} %></span><br/>
               还需金额：<%
            	if(creditInfo.F08.doubleValue()>=10000){%><span class="f18"><%=creditInfo.F08.doubleValue()/10000%></span>
            	<span class="f12">万元</span>
            	<%}else{%><span class="f18"><%=Formater.formatAmount(creditInfo.F08)%></span><span class="f12">元</span><%}%>
            <br/>
            </div>
     		 <div class="w150 fl ml20 mt20">
     		 
     		     <%if(creditInfo.F11 != T6230_F20.YFB) {
            	%>
            	<div class="clearfix mb10">
                  <div class="progress_bg">
                        <div class="progress" style="width:<%=(int)(creditInfo.proess*100)%>%;"></div>
                  </div>
                </div>
	            <%}else{ %>
	            	<span class="ln24"><%=TimestampParser.format(creditInfo.F13,"yyyy-MM-dd HH:mm")%>即将开启</span>
	            <%} %>
            </div>
            <div class="zq_st ml15"></div>
            <div class="zq_jt">
              
              <%if(creditInfo.F11 == T6230_F20.TBZ){%>
            	<span><a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" class="btn btn01">立即投标</a></span>
            	<%}else{%>
            	<%if(creditInfo.F11 == T6230_F20.HKZ) {%><span class="btn btn02 ml15">还款中</span><%}else{%><span class="btn btn06 ml10"><%=creditInfo.F11.getChineseName() %></span><%}%><%}%>
            </div>
            <div class="clear"></div>
          </div>
            <div id="box<%=i%>" class="zq_con clearfix" style=" display:none">
                <div class="zq_left">
                    <div class="bom">
                      <span>贷款编号：<%=creditInfo.F02%></span>
                      <span>贷款期限：<%if(T6231_F21.S == creditInfo.F19){out.print(creditInfo.F20 + "天");}else{out.print(creditInfo.F10 + "个月");} %></span>
                      <span>贷款类型：<%=creditInfo.F01%></span>
                      <%
	                    BidManage investManage = serviceSession.getService(BidManage.class);
	                    com.dimeng.p2p.modules.bid.front.service.entity.Bdxq credit = investManage.get(creditInfo.F02);
	                    T6231 t6231 = investManage.getExtra(creditInfo.F02);
                        %>
                      <span>还款方式：<%=credit.F10.getChineseName()%></span>
                      <br/>
                      <span>募标起始日：<%=TimestampParser.format(credit.F22,"yyyy-MM-dd") %></span>
                      <%
	                     Calendar calendar = Calendar.getInstance();
	                     calendar.setTime(credit.F22);
	                     if(t6231.F21 == T6231_F21.S){
	    	             calendar.add(Calendar.DAY_OF_MONTH, t6231.F22);
	                     }else{
	    	             calendar.add(Calendar.MONTH, creditInfo.F09);
	                     }
                      %>
                      <span>募标结束日：<%=DateParser.format(calendar.getTime(),"yyyy-MM-dd") %></span>
                    </div>
                    <div class="tc">贷款描述：<%StringHelper.filterHTML(out, t6231.F09); %><br/>
                    <%if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
                                                             您尚未<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>" class="blue_ls">登录</a>，或者您长时间未进行操作，登录信息已过期，请重新 登录 以获取详细的借款者信息！
                    <%}%> 
                    </div> 
                </div>  
                <div class="fr mt20"><a title="<%=creditInfo.F04%>" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.F02)%>" class="btn btn09">更多详情</a></div>                  
        	</div>
        </li>
       <%}}%>
       
        
        
        </ul>
        <%AbstractFinancingServlet.rendPaging(out, result,controller.getPagingURI(request, com.dimeng.p2p.front.servlets.financing.Index.class),parameter.getQueryString());%>
       </div>
   
    </div>
</div>
<!--债权转让列表-->


<!--内容-->
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/common.js"></script>
</body>
</html>