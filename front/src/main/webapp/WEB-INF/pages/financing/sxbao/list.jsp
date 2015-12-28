<%@page import="com.dimeng.p2p.front.servlets.financing.sxbao.Index"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="com.dimeng.p2p.utlis.Format"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.service.SxbaoManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>善行创投</title>
<link rel="icon" href="<%=controller.getStaticPath(request)%>/favicon.ico">
<link href="<%=controller.getStaticPath(request)%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/css/layer.css" id="skinlayercss">
<link href="<%=controller.getStaticPath(request)%>/css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/owl.theme.css" rel="stylesheet" type="text/css">
<link href="/css/dialoglink.css" rel="stylesheet" id="dialoglink"/>
</head>
<body>
<!--------顶部栏-------->
<%@include file="/WEB-INF/include/header.jsp"%>
<%
SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
List<SxbaoType> types = sxbaoManage.findAllType();
%>
<div class="wrapper">

 <div class="Middle">
        		<div class="wanto"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;善行宝</div>	
                <div class="Investmentlist">
		        	<ul>
		          		<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">散标投资</a></li> 
		          		<li class="inenow"><a href="javascript:void(0);">善行宝</a></li> 
		         		<li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">债权转让</a></li>
		          	</ul>
		        </div>
                <div class="items">
				<div class="Head">
					<div class="Head_L">
						<h2>项目</h2>
						<a href="javascript:;" class="calculator">理财计算器</a>
					</div>
					<div class="Head_R">
						<a href="/user/financing/zdtb/index.html">设置自动投标</a>
					</div>
				</div>
				<div class="order">
					<ul>
						<li class="er_san">项目名称</li>
						<li class="er_san">状态</li>
						<li class="er_san">已售总额</li>
						<li class="er_san">操作</li>
					</ul>
				</div>
				<div class="list">
					<ul>
					<%
			          if(types!=null){
						  for(SxbaoType sxbaoType : types){
			        		  if (sxbaoType == null) {continue;}
			        %>
						<li><span class="hehe"><%=sxbaoType.name%></span>
						<span class="hehe"><%=sxbaoType.sellStatus == T6230_F13.F? "停售" : "在售"%></span>
						<span class="hehe"><%=Formater.formatAmount(sxbaoType.totalAmount)%>元</span>
						<span investmentstatus=""  class="hehe">
						<a <%=sxbaoType.sellStatus == T6230_F13.S?"class=\"unun\" href=\""+controller.getPagingItemURI(request, Index.class, sxbaoType.id)+"\"":"class=\"unun2\" href=\"javascript:void(0);\""%> >立即购买</a>
						</span>
						</li>
						<%}}%>
					</ul>
				</div>
			</div> 
        </div>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zzsc1016.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/layer.min.js"></script>
<script src="<%=controller.getStaticPath(request)%>/js/public.min.js" type="text/javascript" ></script>
<script  src="/js/lhgdialog.min.js" type="text/javascript"></script>
<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
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