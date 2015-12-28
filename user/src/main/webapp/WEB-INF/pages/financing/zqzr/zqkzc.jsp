<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Bdxq"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.MaySettleFinacing"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Transfer"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>债权转让-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "ZQZR";
	int zqId=0;
	BigDecimal zqValue=new BigDecimal(0);
	int kzNum=0;
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
	  债权状态： <a class="butStyle no" avalue="huikuan" href="/user/financing/zqzr/zqzrz.html">转让中</a>
		     <a class="butStyle " avalue="toubiaozhong">可转出</a>
		     <a class="butStyle no" avalue="yiwancheng" href="/user/financing/zqzr/zqyzc.html">已转出</a>
		     <a class="butStyle no" avalue="toubiaoshibai" href="/user/financing/zqzr/zqyzr.html">已转入</a>
	  </div>
    </div>
</div> 
     <div class="w780 fr">     
     <form action="<%=controller.getViewURI(request, Zqkzc.class)%>" method="post">  
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
						<th width="20%">待收本息</th>
						<th width="15%">操作</th>
					  </tr>
					   <%
					   BidManage bidManage = serviceSession.getService(BidManage.class);
					   PagingResult<MaySettleFinacing> msfList= service.getMaySettleFinacing(paging);				     	
                       if(msfList != null && msfList.getItemCount() >0){
				     		for(MaySettleFinacing msf :msfList.getItems()){
				     			if(msf == null){
				     				continue;
				     			}
				     			Bdxq bdxq =bidManage.get(msf.F02); 	
          		     			T6231 t6231 =bidManage.getExtra(msf.F02);
                      %>
                      <tr>
						<td><a target="_blank" class="blue" href="<%configureProvider.format(out, URLVariable.FINANCING_SBTZ_XQ); %><%=msf.F02 + rewriter.getViewSuffix()%>"><%=bdxq.F03 %></a></td>
						<td><%=Formater.formatRate(bdxq.F06) %></td>
                        <td><%=bdxq.F09>0?bdxq.F09+"个月":t6231.F22+"天" %></td>
                        <td>￥<%=Formater.formatAmount(msf.F03)%></td>
						<td>￥<%=Formater.formatAmount(msf.money)%></td>
						<td><a class="blue" onclick="Transfer(<%=msf.F08%>,<%=msf.F03%>)" class="blue" style="cursor: pointer;" id="qxButton">转让</a></td>
					  </tr>
					  <%}}%>
					</tbody>
					</table>
				</div>
				<div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, msfList); %>
				</div>
		</div>       
		</form>       
       	 </div><div class="clear"></div>        
       	 </div>
   </div>

<form action="<%=controller.getURI(request, Transfer.class)%>" method="post" class="form1">
   <input type="hidden" name="zqId" id="zqId" value="">
   <input type="hidden" name="zqValue" id="zqValue" value="">

<div class="popup_bg"  style="display: none;"></div>
<div class="dialog d_error w380 thickpos" style="margin:-150px 0 0 -190px;display: none;">
  <div class="dialog_close fr"><a href="#"></a></div>
  <div class="con clearfix">
    <div class="clearfix">
      <table width="100%" border="0" cellspacing="0" >
        <tr>
          <td>债权价值：</td>
          <td><span id="zqjz"></span>元</td>
        </tr>
        <tr>
          <td>转让费率：</td>
          <td><%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.ZQZRGLF_RATE))*100 %>%</td>
        </tr>
        <tr>
          <td>转让价格：</td>
          <td><input type="text" name="zrValue" id="zrValue"/><span class="ml5">元</span>
       		  <p tip></p>
			  <p errortip class="" style="display: none"></p>
          
          </td>
        </tr>
      </table>
    </div>
    <div class="clear"></div>
    <div class="dialog_btn">
    	<input type="submit" class="btn001 sumbitForme" fromname="form1" style="cursor: pointer;" value="转让">
    	<input type="button" id="cancel" class="btn05" style="cursor: pointer;" value="取消">
    </div>
  </div>
</div>
</form>
<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqkzc.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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