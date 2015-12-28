<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdlb"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.CreditLevelManage"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.UserInfo"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<html>
<head>
<title>用户信息-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
   <div class="w1002 top_title">
      <span class="fl"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.Index.class) %>">首页</a> &gt;  用户信息</span>
   </div>
   <%
   		int userId = IntegerParser.parse(request.getParameter("id"));
   		UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
   		BidManage bidManage = serviceSession.getService(BidManage.class);
   		CreditLevelManage levelManage = serviceSession.getService(CreditLevelManage.class);
   		UserInfo userInfo = userInfoManage.search(userId);
   		if(userInfo==null){
   			response.sendError(HttpServletResponse.SC_NOT_FOUND );
   			return;
   		}
   		final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
   		PagingResult<Bdlb> result = bidManage.searchCredit(userId, new Paging() {
   			public int getCurrentPage() {return currentPage;}
   			public int getSize() {return 10;}
   		});
   		
   %>
   <div class="contain_main clearfix">
       <div class="pub_title">
         <h3 class="fl navtit"><%StringHelper.filterHTML(out, userInfo.F02); %></h3>
         <%StringHelper.filterHTML(out, levelManage.getXydj(userInfo.xyjf)); %>
       </div>
       <div class="uselist">
         <table width="100%" border="0" align="left" cellspacing="0">
              <tr>
                <td width="188" valign="top" class="w150 line">
                   <span class="pic"><img src="<%if(StringHelper.isEmpty(userInfo.F15)){%><%=controller.getStaticPath(request)%>/images/tx.jpg<%}else{%><%=fileStore.getURL(userInfo.F15) %><%}%>" width="127" height="125" class="pic_img"/></span>
                </td>
                <td width="24%" valign="top" class="line">
                  <div class="tit">理财统计</div>
                  <div class="clearfix"><span class="fl w230">持有债权数量（笔）</span><span class="fl tl"><%=userInfo.cyzqsl %></span></div>
                  <div class="clearfix"><span class="fl w230">持有理财计划数量（笔）</span><span class="fl tl"><%=userInfo.cylcjhsl %></span></div>
                </td>  
                <td valign="top">
                  <div class="tit">借款统计</div>
                  <div class="clearfix">
                     <div class="mr20 w220 fl"><span class="fl w150">发布借款数量（笔）</span><span class="fl tl"><%=userInfo.fbjksl %></span></div>
                     <div class="mr20 w220 fl"><span class="fl w150">逾期次数（次）</span><span class="fl tl"><%=userInfo.yqcs %></span></div>
                  </div>
                  <div class="clearfix">
                     <div class="mr20 w220 fl"><span class="fl w150">成功借款数量（笔）</span><span class="fl tl"><%=userInfo.cgjksl %></span></div>
                     <div class="mr20 w220 fl"><span class="fl w150">逾期金额（元）</span><span class="fl tl"><%=Formater.formatAmount(userInfo.yqje)%></span></div>
                  </div>
                  <div class="clearfix">
                     <div class="mr20 w220 fl"><span class="fl w150">未还清借款数量（笔）</span><span class="fl tl"><%=userInfo.whqjksl %></span></div>
                     <div class="mr20 w220 fl"><span class="fl w150">严重逾期笔数（笔）</span><span class="fl tl"><%=userInfo.yzyqcs %></span></div>
                  </div>
                </td>
              </tr>
         </table>
       </div>  
       

   </div>
   
   <!--投资列表-->
   <div class="contain_main clearfix">
     <div class="pt15 clearfix">
        <div class="pub_title">借款列表</div>
      </div>
      <div class="invest_con">
        <div class="info">  
          <table width="100%" cellspacing="0">
         <tr class="big_tit">
            <td width="209">贷款用途 </td>
            <td width="98" class="w100">年利率（%）</td>
            <td width="109" >金额（元）</td>
            <td width="63">期限（月) </td>
            <td width="134">借款时间</td>
            <td width="154" class="w150"></td>
          </tr> 
           <%
           
           Bdlb[] creditInfos=result.getItems();if(creditInfos!=null){for (Bdlb creditInfo : creditInfos) {if (creditInfo == null) {continue;}
           %>
          
          <tr class="all_bj">
            <td><div class="w250"><span class="xin ml30 mr10">
            	<%if(creditInfo.F16 == T6230_F11.S || creditInfo.F17 == T6230_F13.S){%>保
	            <%}else if(creditInfo.F18 == T6230_F14.S ){%>实
	            <%}else{%>信<%}%>
            </span><span class="w200"><a title="<%=creditInfo.F04%>" href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq.class,creditInfo.F02)%>"><%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F04, 10));%></a></span></div></td>
            <td><%=Formater.formatRate(creditInfo.F07)%></td>
            <td>
            	<%if(creditInfo.F06.doubleValue()>=10000){%>
            	<span class="f16"><%=Formater.formatAmount(creditInfo.F06.doubleValue()/10000)%></span><span class="f12">万元</span>
            	<%}else{%>
            	<span class="f16"><%=Formater.formatAmount(creditInfo.F06)%><span class="f12">元</span></span>
            	<%}%>
           </td>
           
            <td><span class="f16"><%=creditInfo.F10%></span><span class="f12">个月</span></td>
            <td><span class="f16"><%=DateParser.format(creditInfo.F13) %></span> </td>
            <td>
            
            <%if(creditInfo.F11 == T6230_F20.TBZ){%>
            	<span><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq.class,creditInfo.F02)%>" class="btn btn01 ml15">立即投标</a></span>
           	<%}else{%>
           		<span class="btn btn02 ml15">
	           	<%StringHelper.filterHTML(out, creditInfo.F11.getChineseName());  %>
	           	</span>
           	<%}%>
            </td>
          </tr>
         <%}} %>
    </table>
        </div>
        <%AbstractFrontServlet.rendPaging(out, result,controller.getPagingURI(request, com.dimeng.p2p.front.servlets.financing.UserInfo.class));%>
      </div>
   </div>
   
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>