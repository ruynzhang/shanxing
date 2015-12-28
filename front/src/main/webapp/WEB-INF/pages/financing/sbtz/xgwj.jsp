<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.ViewAnnexMsk"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.ViewAnnexWz"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Annex"%>
<%@page import="com.dimeng.p2p.S62.entities.T6232"%>
<%@page import="com.dimeng.p2p.S62.entities.T6212"%>
<%@page import="com.dimeng.p2p.S62.entities.T6233"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Dbxx"%>
<%@page import="com.dimeng.p2p.S62.entities.T6237"%>
<html>
<head>
<title>散标详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/js/highslide.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highslide-with-gallery.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '<%=controller.getStaticPath(request)%>/js/graphics/';
	hs.align = 'center';
	hs.transitions = ['expand', 'crossfade'];
	hs.wrapperClassName = 'dark borderless floating-caption';
	hs.fadeInOut = true;
	hs.dimmingOpacity = .75;

	// Add the controlbar
	if (hs.addSlideshow) hs.addSlideshow({
		//slideshowGroup: 'group1',
		interval: 5000,
		repeat: false,
		useControls: true,
		fixedControls: 'fit',
		overlayOptions: {
			opacity: .6,
			position: 'bottom center',
			hideOnMouseOut: true
		}
	});
</script>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
        <!--banner-->
<div class="zq_banner">
<div class="banner4"></div>
</div>
<!--banner-->

	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/sbtz/header.jsp"%>
		
		<div class="plan_tab clearfix">
			
			<ul>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq.class, id)%>">标的详情</a></li>
				<%if(creditInfo.F11 == T6230_F11.S){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dbxx.class, id)%>">风控信息</a></li>
				<%} %>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dyxx.class, id)%>">抵押物信息</a></li>
				<%
					}
				%>
				<li class="hover">相关文件</li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Hkjl.class, id)%>">还款计划</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl.class, id)%>">投资记录</a></li>
				<%if(creditInfo.surpriseStatus != null && creditInfo.surpriseStatus != SURPRISE_STATUS.WPZ){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Hjjl.class, id)%>">获奖记录</a></li>
				<%} %>
			</ul>
			
		</div>
		
		    <div class="contain_main clearfix ">
		     <div class="plan_tab_con01 clearfix"> 
		     <%
		          T6250[] tenderRecords = investManage.getRecord(id);
	             T6232[] t6232s = null;
	             T6233[] t6233s = null;
	             
	             boolean isResult=false;
	             if (creditInfo.F20 == T6230_F20.TBZ || creditInfo.F20 == T6230_F20.YFB) {
	             	t6232s = investManage.getFjgk(id);
	             }else if(dimengSession!=null && dimengSession.isAuthenticated()){
	             		int loginId=serviceSession.getSession().getAccountId();
	             		if(tenderRecords!=null && tenderRecords.length>0)
	             		{
	                 		for (T6250 tenderRecord : tenderRecords) {
	                    			if(tenderRecord.F03 == loginId){
	                    				t6233s = investManage.getFjfgk(id);
	                    				isResult=true;
	                    				break;
	                    			}
	                    		}
	                 		if(!isResult){
	                 			t6232s = investManage.getFjgk(id);
	                 		}
	             		}
	             	
	             }else{
	             	t6232s = investManage.getFjgk(id);
	         	}
	             
	             T6212[] t6212s = null;
	             if(isResult){
		             t6212s = investManage.getT6212(id,true);
	             }else{
	            	 t6212s = investManage.getT6212(id,false);
	             }
		     
		     %>
		     
		     <%if(t6212s != null &&t6212s.length >0){ for(T6212 t6212:t6212s){ %>
		     	
		    <div class="pub_title pt10"><%=t6212.F02 %></div>
		    <div class="pt10">
		    <div class="highslide-gallery gyb_wh">
		    		<%
                        if(isResult && t6233s != null && t6233s.length >0){
              	           	 for (T6233 attachment : t6233s) {if (attachment == null || attachment.F03 != t6212.F01) {continue;}%>
              	            	<a href="<%=controller.getURI(request, Annex.class)%>?id=<%=attachment.F01 %>" class="highslide" onclick="return hs.expand(this)">
									<img src="<%=controller.getURI(request, Annex.class)%>?id=<%=attachment.F01 %>" alt="Highslide JS" title="Click to enlarge" width="185" height="116"/>
									<p><%StringHelper.filterHTML(out, attachment.F04);%></p>
								</a>
              	            <%}}else if(t6232s != null && t6232s.length >0){
              	            	for (T6232 attachment : t6232s) {if (attachment == null|| attachment.F03 != t6212.F01) {continue;}%>
           	   			    	<a href="<%=fileStore.getURL(attachment.F04) %>" class="highslide" onclick="return hs.expand(this)">
									<img src="<%=fileStore.getURL(attachment.F04) %>" alt="Highslide JS" title="Click to enlarge" width="185" height="116"/>
									<p><%StringHelper.filterHTML(out, attachment.F05);%></p>
								</a>
           	            <%}} %>   
           	            </div>
		    <div class="clear"></div>
			</div>
	  <%} }%>
    		</div>
   		</div>
		</div>
	<div id="info"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/sbtz.js"></script>
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