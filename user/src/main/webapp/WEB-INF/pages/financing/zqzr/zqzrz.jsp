<%@page import="com.dimeng.p2p.S62.enums.T6260_F07"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Bdxq"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.ZrzdzqEntity"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Cancel"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>债权转让-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "ZQZR";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
     <%@include file="/WEB-INF/include/menu.jsp"%>
		<%@include file="/WEB-INF/include/zqzr/header.jsp"%>
<div class="container fr">
          <div class="mainDiv bor1">
          <!--理财管理 S-->
	  <div class="tb-state">
	  债权状态： <a class="butStyle" avalue="huikuan">转让中</a>
		     <a class="butStyle no" avalue="toubiaozhong" href="/user/financing/zqzr/zqkzc.html">可转出</a>
		     <a class="butStyle no" avalue="yiwancheng" href="/user/financing/zqzr/zqyzc.html">已转出</a>
		     <a class="butStyle no" avalue="toubiaoshibai" href="/user/financing/zqzr/zqyzr.html">已转入</a>
	  </div>
    </div>
</div>
     <div class="w780 fr">       
     <form action="<%=controller.getViewURI(request, Zqzrz.class)%>"method="post">
     <input type="hidden" name="zcbId" id="zcbId" value="">
      <div id="funds" class="mainDiv min400">
			<p class="title1"><b>我的转让</b></p>
				<div class="tb-list">
					
					<table class="tableOdd">
					  <tbody>
					  <tr>
						<th width="20%">投资项目</th>
						<th width="15%">年利率</th>
                        <th width="15%">借款期限</th>
                        <th width="15%">剩余本金</th>
						<th width="20%">申请转让时间</th>
						<th width="15%">操作</th>
					  </tr>
					   <%
                       BidManage bidManage = serviceSession.getService(BidManage.class);
                      	PagingResult<ZrzdzqEntity> sfList= service.getSellFinacing(paging);				     	
                                             if(sfList != null && sfList.getItemCount() >0){
                      		     		for(ZrzdzqEntity sf :sfList.getItems()){
                      		     			if(sf == null){
                      		     				continue;
                      		     			}
                      		     			Bdxq bdxq =bidManage.get(sf.F10); 	
                      		     			T6231 t6231 =bidManage.getExtra(sf.F10);
                      %>
                      <tr>
						<td><a target="_blank" class="blue" href="<%configureProvider.format(out, URLVariable.FINANCING_SBTZ_XQ); %><%=sf.F10 + rewriter.getViewSuffix()%>"><%=bdxq.F03 %></a></td>
						<td><%=Formater.formatRate(bdxq.F06) %></td>
                        <td><%=bdxq.F09>0?bdxq.F09+"个月":t6231.F22+"天" %></td>
                        <td>￥<%=Formater.formatAmount(sf.F14)%></td>
						<td><%=Formater.formatDate(sf.F05)%></td>
						<td><a onclick="Cancel(<%=sf.F01 %>)" class="blue" style="cursor: pointer;" id="qxButton">取消</a></td>
					  </tr>
					  <%}}%>
					</tbody>
					</table>
				</div>
				<div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, sfList); %>
				</div>
		</div>   
		</form>         
       	 </div><div class="clear"></div>
   </div>
</div>

<div class="popup_bg"  style="display: none;"></div>
<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;display: none;">
	<div class="dialog_close fr"><a href="#"></a></div>
    <div class="con clearfix">
      <div class="d_perfect fl"></div>
      <div class="info fr">
        <p class="f20 gray33">是否执行“取消转让”债权操作？</p>
      </div>
      <div class="clear"></div>
      <div class="dialog_btn"><a href="javascript:void(0)" id="ok" class="btn btn001">是</a><a href="javascript:void(0)" id="cancel" class="btn btn05">否</a></div> 
    </div>
</div>
<div id="info"></div>
<script type="text/javascript">
	var url_del = "<%=controller.getURI(request, Cancel.class)%>";
</script>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqzrz.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zqzr.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>

	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#sbSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
</body>
</html>