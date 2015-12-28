<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.ZqxxEntity"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.wdzq.BackMoney"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的投资-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "WDZQ";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<% 
boolean multiSelect = "1".equals(request.getParameter("w"));
URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.wdzq.Yjqdzq.class),multiSelect,SORT);
	String str=request.getParameter(SORT);
	int sort=0;
	if(str!=null && JfUtil.matches(str, "[0-9]*")){
		   sort=Integer.parseInt(str);
	}
%>
	<div class="contain clearfix">
		<div class="user_top"></div>
   		<div class="about">
     		<%@include file="/WEB-INF/include/menu.jsp"%>
            <%@include file="/WEB-INF/include/wdzq/header.jsp"%>
			<div class="container fr">
            <div class="mainDiv bor1">
            <!--理财管理 S-->
			  <div class="tb-state">
			  投标状态： <a class="butStyle no" avalue="huikuan" href="/user/financing/wdzq/hszdzq.html">回款中</a>
				     <a class="butStyle no" avalue="toubiaozhong" href="/user/financing/wdzq/tbzdzq.html">投标中</a>
				     <a class="butStyle " avalue="yiwancheng">已完成</a>
				     <a class="butStyle no" avalue="toubiaoshibai" href="/user/financing/wdzq/ysbzdzq.html">投标失败</a>
			  </div>
		    </div>
            </div>
       	    <div class="w780 fr">       
         		<div>
   	    		<div class="newsbox">
                  	<div class="til clearfix Men_bt2">
                  	  <div class="tabtit">我的投资</div>                      
               		</div>
               		<form action="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.wdzq.Yjqdzq.class)%>" method="post">
               		<div class="bs_bg pt20">
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc tableOdd">
		                      <tr class="user_lsbg tb_th">
		                        <th>项目名称<a href="/user/financing/wdzq/yjqdzq.html?s=1"><span class="<%=sort==1?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>起息日<a href="/user/financing/wdzq/yjqdzq.html?s=2"><span class="<%=sort==2?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>到期还款日<a href="/user/financing/wdzq/yjqdzq.html?s=3"><span class="<%=sort==3?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>投资金额（元）<a href="/user/financing/wdzq/yjqdzq.html?s=4"><span class="<%=sort==4?"tip-down":"tip-up"%>"></span></a></th>
		                        <th>项目收益（元）</th>
		                        <th>查看详情</th>
		                        
		                      </tr>
		                       <%
		                       PagingResult<ZqxxEntity> list= service.getSettleAssests(sort,paging);
						     	if(list != null && list.getItemCount() >0){
						     		for(ZqxxEntity vo :list.getItems()){
						     			if(vo == null){
						     				continue;
						     			}
						     %>
		                      <tr>
		                        <td><%=vo.F11%><br>
		                        <%if(T6230_F13.F==vo.isSxbao){%>
		                        <a class="blue" href="<%configureProvider.format(out, URLVariable.FINANCING_SBTZ_XQ); %><%=vo.F02 + rewriter.getViewSuffix()%>"><%=vo.F01 %></a>
		                        <%}else{out.print(vo.F01);}%>
		                        
		                        </td>
		                        <td><%=Formater.formatDate(vo.F09)%></td>
		                        <td><%=Formater.formatDate(vo.jq_date)%></td>
		                        <td>￥<%=Formater.formatAmount(vo.F04)%></td>
		                        <td>￥<%=Formater.formatAmount(vo.yzje)%></td>
		                        <td>
		                        <a class="blue" href="/user/financing/wdzq/tzxq/<%=vo.zqid + rewriter.getViewSuffix()%>">详情</a>
		                        <a class="blue" target="_blank" href="<%=controller.getURI(request, com.dimeng.p2p.user.servlets.financing.agreement.Index.class) %>?id=<%=vo.F02 %>" class="blue">合同</a>
		                        </td>
		                      </tr>
		                      <%}}%>
		                    </table>
		            	  </div>
		                    <div class="page">
								<%AbstractFinancingServlet.rendPaging(out, list,controller.getPagingURI(request,com.dimeng.p2p.user.servlets.financing.wdzq.Yjqdzq.class),parameter.getQueryString()); %>
							</div>
		            	  
                  </div>         
                  </form>      
                  <div class="clear"></div>
              </div>
           	</div>            
       	 </div>
       		<div class="clear"></div>
   		</div>
	</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/wdzq.js"></script>
</body>
</html>