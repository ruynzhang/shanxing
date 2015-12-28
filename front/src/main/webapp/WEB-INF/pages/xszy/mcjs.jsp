<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<html>
<head>
<title><%=ArticleType.MCJS.getName()%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%> 
        <!--banner-->
<div class="zq_banner">
<div class="banner2"></div>
</div>
<!--banner-->
	<div class="contain clearfix">
		<div class="lead">
			<%
				CURRENT_SUB_CATEGORY = "MCJS";
			%>
			<%@include file="/WEB-INF/include/xszy/left.jsp"%>
			<%
				ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
				PagingResult<T5011> result = articleManage.search(T5011_F02.MCJS,new Paging(){public int getCurrentPage(){return 1;}public int getSize(){return 5;}});
				T5011[] articles = result.getItems();
			%>
			<%if(articles!=null&&articles.length>0){%>
				<%if(articles.length==1){%>
					<div class="clearfix container">
					<div class="help_title clearfix"><%StringHelper.filterHTML(out,articles[0].F06);%></div>
                    <div class="help_submenu">
                        <ul>
                          <li class="chosen"><a href="#">投资</a></li>
                          <li><a href="#">赎回</a></li>
                          <li><a href="#">充值</a></li>
                          <li><a href="#">提现</a></li>
                        </ul>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="help_ctbox">
                     <ul id="toggle" class="toggle">
                    <li>
                        <div class="link">投资前需要注意什么？<i class="fa fa-chevron-down"></i></div>
                        <div class="h_submenu">
                            您好，您在投资前需要认真阅读该投资项目的详细信息（包括借款金额，年化利率，借款期限、借款者信用等级等），以确定您所要投的标符合您的风险承受能力和所要求的回报率；<br />
            另外还需要认真阅读借款协议（范本），了解其中信息，知道若您所投标的借款人发生违约，自己所获得的保障；<br />
            最后投标前需要核实自己将要投资的金额，确认无误后再进行操作。
                        </div>
                    </li>
                    <li>
                        <div class="link">为什么我投资不成功？<i class="fa fa-chevron-down"></i></div>
                        <div class="h_submenu">
                            导致您投资不成功的原因有：<br />
                            1.您没有通过实名认证；<br />
                            2.您的账户资金不足；<br />
                            3.有其他的借款人和您投资同一笔借款，比您先确认合同；<br />
                            4.借款人放弃借款等。
                        </div>
                    </li>
                    <li>
                        <div class="link">投资有没有限额？最低可以投多少？<i class="fa fa-chevron-down"></i></div>
                        <div class="h_submenu">
                            最低可以投资100元。以1元的整数倍递增。
                        </div>
                    </li>
                    <li>
                        <div class="link">有哪些理财产品？<i class="fa fa-chevron-down"></i></div>
                        <div class="h_submenu">
                            现有的理财产品包括三类：企业标，个人标，线上债权转让。
                        </div>
                    </li>
                 </ul>
                 </div>
					<div id="nav" class="clearfix">
			        <%StringHelper.format(out, articleManage.getContent(articles[0].F01), fileStore);articleManage.view(articles[0].F01);%>
			        </div>
			        </div>
				<%}else{%>
					<div class="clearfix ">
						<div class="lead_tab clearfix ">
				             <ul>
				             	<%for(int i=0,idx=1,max=articles.length+1;i<articles.length;i++,idx++){%>
				                <li id="one<%=idx %>" onclick="setTab('one',<%=idx %>,<%=max %>)" <%if(i==0){%>class="hover"<%}%>><%StringHelper.filterHTML(out, articles[i].F06); %></li>
				                <%}%>
				                <li style="border-left:1px solid #d1dfea;padding:0;"></li>
				             </ul>
				         </div>
			         	<%for(int i=0;i<articles.length;i++){%>
				         <div class="container clearfix" id="con_one_<%=i+1%>" <%if(i>0){%>style="display:none;"<%}%>>
				         <%StringHelper.format(out, articleManage.getContent(articles[i].F01), fileStore);articleManage.view(articles[i].F01);%>
				         </div>
		        		<%}%>
		         	</div>
				<%}%>
			<%}else{%>
				<div class="clearfix container">
				<div class="help_title clearfix"></div>
                <div class="help_submenu">
                        <ul>
                          <li class="chosen"><a href="#">投资</a></li>
                          <li><a href="#">赎回</a></li>
                          <li><a href="#">充值</a></li>
                          <li><a href="#">提现</a></li>
                        </ul>
                        <div class="clear"></div>
                    </div>
				<div id="nav" class="clearfix">
		        </div>
		        </div>
			<%}%>
            <div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/help.js"></script>
</body>
</html>