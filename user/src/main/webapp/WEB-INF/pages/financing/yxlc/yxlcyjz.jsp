<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.EndBestFinacing"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.BestFinacingInfo"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.YxlcManage"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlcsqz"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlccyz"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlcyjz"%>
<%@page import="java.math.BigDecimal"%>
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
                        <li><a href="<%=controller.getViewURI(request, Yxlccyz.class) %>">持有中的优选计划</a></li>
                        <li style="border-right:1px #d7dfe3 solid;" class="hover">已截止的优选计划</li>
                     </ul>
                    </div>                        
               </div>
               <form action="<%=controller.getViewURI(request, Yxlcyjz.class)%>"method="post">
               <div class="bs_bg pt10">
                  <div class="no_table user_bolr bot">
                  	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
                      <tr class="user_lsbg">
                        <td>计划名称</td>
                        <td>加入金额</td>
                        <td>年利率</td>
                        <td>回收金额</td>
                        <td>已赚金额</td>
                        <td>截止时间</td>
                        <td>&nbsp;</td>
                      </tr>
                       <%
                       PagingResult<EndBestFinacing> ebfList= service.getEndBestFinacing(paging);				     	
                      	if(ebfList != null && ebfList.getItemCount() >0){
				     		for(EndBestFinacing ebf :ebfList.getItems()){
				     			if(ebf == null){
				     				continue;
				     			}
				     %>
                      <tr>
                        <td>
                        <a class="blue" href="<%configureProvider.format(out, URLVariable.FINANCING_YX_XQ); %><%=ebf.planId + rewriter.getViewSuffix()%>">
                        <%StringHelper.filterHTML(out, ebf.name);%>
                        </a>
                        </td>
                        <td><%=Formater.formatAmount(ebf.addMoney) %>元</td>
                        <td><%=Formater.formatRate(ebf.rate) %></td>
                        <td><%=Formater.formatAmount(ebf.money) %>元</td>
                        <td><%=Formater.formatAmount(ebf.takeMoney) %>元</td>
                        <td><%=Formater.formatDate(ebf.endTime) %></td>
                        <td><a target="_blank" href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.agreement.Yxlc.class) %>?id=<%=ebf.planId %>">合同</a></td>
                      </tr>
                       <%
				     		}}
                      %>
                    </table>
                  </div>                
                    <div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, ebfList); %>
					</div>
                              
                  </div>               </form>
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