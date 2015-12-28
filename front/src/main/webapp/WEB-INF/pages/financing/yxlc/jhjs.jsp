<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>优选理财计划<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="contain clearfix">
   <div class="w1002 top_title">
      <span class="fl"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.Index.class)%>">我要理财</a> &gt;   优选理财计划</span>
   </div>
   
   
   <div class="contain_main clearfix plan_intr">
       <div class="pub_title">计划介绍</div>
       <div class="tc pt10"><img src="<%=controller.getStaticPath(request)%>/images/financial01.jpg" width="910" height="284" /></div>  
   </div>
   
   <div class="contain_main clearfix plan_intr">
       <div class="pub_title">计划介绍</div>
       <div class="pt10">
        1．加入费用：a%；加入计划金额的a%，期初额外收取，即加入计划金额为10万元，则另行收取（10万*a%）元作为加入计划费用归<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>所有。<br/>
		2．服务费用：b%；即计划中投标所得利息收入的b%作为服务费用归<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>所有。<br/>
		3．退出费用：c%；退出计划时按退出计划金额的c%收取退出费用归<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>所有。
       </div>
   </div>
   
    <!--费用说明-->
   <div class="contain_main clearfix plan_intr">
       <div class="pub_title">退出规则</div>
       <div class="pt10">
        <p>	1．退出时间：锁定期结束日的12:00后，该期优选理财计划将进入开放期；理财人可以随时退出处于开放期中的理财计划。<br/>
			2．退出规则：理财人只能选择全部退出，不支持部分退出。<br/>
			3．退出方式：债权转让（理财计划的债权转让不受90天锁定期的限制，不收取债权转让手续费）。<br/>
			4．退出回款方式：理财人在退出时可选择的退出回款方式包括：提取至<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>主账户和提取至银行卡，退出回款方式一经选定将无法修改。<br/></p>
       <p class="pl20 f12 pt10">
         	(1) 提取至<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>主账户规则：在理财人选择退出优选理财计划后，系统每天定时将优选理财计划账户中的可用资金（含债权转让所得资金及投资回款所得资金等）扣除退出费用后转至理财人主账户，直到优选理财计划持有的债权全部转让完成且优选理财计划账户中的资金全部转至理财人主账户为止。<br/>
			(2) 提取至银行卡规则：在理财人选择退出优选理财计划后，若优选理财计划持有的债权全部转让完成，系统将发起一次提现操作；若没有将全部债权转出，则系统将每7天发起一次提现操作，直至该优选理财计划持有的债权全部转让完成。<br/>
			<br/>
			注1：若优选理财计划账户的可用资金不足以支付退出费用和提现费用时，将不进行提现操作；若该优选理财计划持有的债权全部转让完成且账户内的可用资金依然小于1块钱，则将余额转至理财人的主账户。<br/>
			注2：每次提现至银行卡的费用将由申请退出计划的理财人承担，具体费用详见网站的提现费用说明。<br/>
			注3：提现至银行卡的资金到账时间与用户发起的一般提现相同，一般为1~2个工作日，具体规则详见网站提现说明。<br/>
       </p>
       </div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
	
</body>
</html>


