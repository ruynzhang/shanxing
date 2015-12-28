<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.common.enums.PlanState"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F14"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.InBestFinacing"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlccyz"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlcyjz"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlcsqz"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.BestFinacingInfo"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.YxlcManage"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>优选理财计划-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
	YxlcManage service=serviceSession.getService(YxlcManage.class);
	Paging paging=new Paging(){
		public int getCurrentPage(){
			return currentPage;
		}
		
		public int getSize(){
			return 10;
		}
	};
	
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "YXLCJH";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="w994 pb5"><span class="f16"><a href="<%=controller.getViewURI(request, Index.class) %>">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %></a></span> &gt; 理财管理 &gt; 优选理财计划</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
     <div class="container fr mb15">
      <%
      	BestFinacingInfo bfInfo=service.getBestFinacingInfo();
      	if(bfInfo != null){
      %>
   		  <div class="user_bgls fl">
            	<p class="mt20 ml20">
                <span class="f20">优选计划已赚总金额</span><br />
                <span class="red"><%=bfInfo.makeMoney %>元</span><br />
                <span class="mr15">优选理财账户资产</span><%=bfInfo.accountMoney %>元<br />  
                <span class="mr15">平均收益率</span>  <%=Formater.formatRate(bfInfo.rate)  %><br />
                </p>
      </div>
            <div class="hzcx_st fl"></div>
            <div class="fl">
            <ul class="hzcx_li pl40">
            <li>持有中的计划数量<br><%=bfInfo.num %>个</li>
            <li>加入费用<br><%=bfInfo.addMoney %>元</li>
            </ul>
                     </div>
       <%
      	}else{
       %> 
   		  <div class="user_bgls fl">
            	<p class="mt20 ml20">
                <span class="f20">优选计划已赚总金额</span><br />
                <span class="red">0元</span><br />
                <span class="mr15">优选理财账户资产</span>0.00元<br />  
                <span class="mr15">平均收益率</span>  0.00%<br />
                </p>
      </div>
            <div class="hzcx_st fl"></div>
            <div class="fl">
            <ul class="hzcx_li pl40">
            <li>持有中的计划数量<br>0元</li>
            <li>加入费用<br>0个</li>
            </ul>
          </div>
       <%
      	}
       %>
       </div>    
   <div class="w780 fr">       
      <div>
   	    <div class="newsbox">
                  <div class="til clearfix Men_bt">
                   <div class="Menubox">                   
                     <ul>
                     	<li><a href="<%=controller.getViewURI(request, Yxlcsqz.class) %>">申请中的优选计划</a></li>
                        <li  class="hover">持有中的优选计划</li>
                        <li  style="border-right:1px #d7dfe3 solid;"><a href="<%=controller.getViewURI(request, Yxlcyjz.class) %>">已截止的优选计划</a></li>
                     </ul>
                    </div>                        
               </div>
               <form action="<%=controller.getViewURI(request, Yxlccyz.class)%>"method="post">
               <div class="bs_bg pt10">
                  <div class="no_table user_bolr bot">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
                      <tr class="user_lsbg">
                        <td>计划名称</td>
                        <td>加入金额</td>
                        <td>年利率</td>
                        <td>待收本息</td>
                        <td>月收本息</td>
                        <td>剩余期数</td>
                        <td>下个还款日</td>
                        <td>状态</td>
                        <td>&nbsp;</td>
                      </tr>
                      <%
                       PagingResult<InBestFinacing> ibfList= service.getInBestFinacing(paging);				     	
                      if(ibfList != null && ibfList.getItemCount() >0){
				     		for(InBestFinacing ibf :ibfList.getItems()){
				     			if(ibf == null){
				     				continue;
				     			}
				     			InBestFinacing syfs=service.getSyTime(ibf.planId);
				     %>
                      <tr>
                        <td>
                        <a class="blue" href="<%configureProvider.format(out, URLVariable.FINANCING_YX_XQ); %><%=ibf.planId + rewriter.getViewSuffix()%>">
                        <%StringHelper.filterHTML(out, ibf.name); %>
                        </a>
                        </td>
                        <td><%=Formater.formatAmount(ibf.addMoney) %>元</td>
                        <td><%=Formater.formatRate(ibf.rate) %></td>
                        <td><%=Formater.formatAmount(ibf.notMoney) %>元</td>
                        <td><%=Formater.formatAmount(ibf.monthMoney) %>元</td>
                        <td>
                        	<%if(ibf.type == T6410_F14.YCXHBFX){ %>
                        	1/1<%}else{ %><%=syfs.num %>/<%=ibf.jkTime %><%}%>
                        	</td>
                        <td><%=DateParser.format(ibf.nextDay) %></td>
                        <td><%if(ibf.status == PlanState.YSX){ %>回款中<%}else{ %>申请中<%} %></td>
                        <td><a target="_blank" href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.agreement.Yxlc.class) %>?id=<%=ibf.planId %>">合同</a></td>
                      </tr>
                      <%
				     		}}
                      %>
                    </table>
            	  </div>
                    <div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, ibfList); %>
					</div>
                  </div>         </form>      
                  <div class="clear"></div>
        </div>
         </div>            
       	 </div><div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>