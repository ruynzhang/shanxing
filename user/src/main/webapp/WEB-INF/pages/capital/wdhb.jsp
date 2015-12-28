<%@page import="com.dimeng.p2p.user.servlets.capital.AbstractCapitalServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S10.entities.RedPacketRecord"%>
<%@page import="com.dimeng.p2p.service.RedPacketManage"%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>
		<head>
		<title><%configureProvider.format(out,SystemVariable.SITE_NAME);%>_我的红包</title>
		<%@include file="/WEB-INF/include/meta.jsp"%>
		<%@include file="/WEB-INF/include/style.jsp"%>

		</head>
		<body>
		<%@include file="/WEB-INF/include/header.jsp"%>
    <%!
    	public String getSource(int num){
    		if(num==1){return "手动发放";}
    		else if(num==2){return "注册";}
    		else if(num==3){return "推广";}
    		return null;
    	}
    %>
	<%
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	int userId=serviceSession.getSession().getAccountId();
	RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
	RedPacketRecord query = new RedPacketRecord();
	query.parse(requestWrapper);//设置界面传来的参数
	query.state=12;
	query.userId=userId;
	//分页对象
	PagingResult<RedPacketRecord> list = manage.getListRecord(query, new Paging() {
		@Override
		public int getSize() {
			return 6;
		}
		@Override
		public int getCurrentPage() {
			return IntegerParser.parse(requestWrapper.getParameter("paging.current"));
		}
	});
	RedPacketRecord[] recordArray = list.getItems();
		//CURRENT_CATEGORY = "WDHB";
	    CURRENT_SUB_CATEGORY = "WDHB";
		//CURRENT_SUB_CATEGORY = "DDCX";
	%>

		<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
		<%@include file="/WEB-INF/include/menu.jsp"%>

		<!---我的红包  右侧内容---->
        <div class="wdhb">
		   <div class="title"><h1>我的红包</h1></div>
		   <!---tabs---->

			<ul class="menu">
				<li class="tabFocus">未使用</li>
				<li><a href="/user/capital/wdhbysy.html">已使用</a></li>
				<li><a href="/user/capital/wdhbygq.html">已过期</a></li>
			</ul>
             <div class="line"></div>
			<div class="maincontent" >
		    <!--未使用---->
		    <form action="/user/capital/wdhb.html" method="post">
			<div class="content  hb_bottom conFocus"> 
			<%
				int i=1; 
				if(null!=recordArray){
				for(RedPacketRecord record:recordArray){
			%>
		      <div class="hb <%=i%2==0?"right_hb":"" %>"> 
		         <div class="<%=record.state==5?"overdue":"back_cash"%>"><h2><%=record.type==1?"投资红包":"现金红包"%></h2><h3>￥<%=record.amount.intValue()%></h3></div>
		         <div class="cash_note">
		         	<p>来源：<%=getSource(record.source)%><%=record.state==5?"(未激活)":""%></p>
		         	<p>时间：<%=Formater.formatDate(record.startTime)%>至<%=Formater.formatDate(record.endTime)%></p>
		         	<p>起投金额：<%=record.ranges.intValue()%>元</p>
		         	<p>
		         		<input type="hidden" id="content_<%=i%>" value="<%StringHelper.filterHTML(out, record.content!=null?record.content:"");%>">
		         		<a href="javascript:;;" onclick="showDiv('<%=i%>','<%=getSource(record.source)%>', '<%=Formater.formatDate(record.startTime)%>至<%=Formater.formatDate(record.endTime)%>')"  class="btn_info">详情</a>
		         	</p>
		         </div>
		      </div>
		     <%i++;}}%>
		     <!------分页---->
			<div class="page">
			<%AbstractCapitalServlet.rendPagingResult(out, list); %>
			</div>
		    </div>
		    </form>
   </div><!---end maincontent--->
		    <!--温馨提示---->
		    <%@include file="/WEB-INF/pages/capital/hb_Rule.jsp"%>
		</div>
		<!-------end------------------>
		</div>
		</div>

		<!------modal container----------->

		<div class="hg-modal hg-content">
			<div class="detail_title">
				<div class="title_name">详情</div>
				<div class="close"></div>
			</div>
			<div class="place_content">
				 <div class="hb-title"> <h1>红包详情</h1></div>
				 <div class="hb-main" id="hb-main">
				 </div>
				 <div class="hb-footer" id="hb-footer"></div>
			</div>
		</div>
		<div class="alert_bg"></div>

		<!-------end------------------>


		<%@include file="/WEB-INF/include/footer.jsp"%>
		<script type="text/javascript">
		$(function(){

		// modal
		$(".btn_info").click(function(){
		$(".hg-content").show();
		$(".alert_bg").show();
		});
		$(".close").click(function(){
		$(".hg-content").hide();
		$(".alert_bg").hide();
		}); //end modal
		});
		
		function showDiv(num,source,date){
			$("#hb-main").empty();
			$("#hb-footer").empty();
			var content=$("#content_"+num).val();
			if(content!=null && content!="null"){
				$("#hb-main").html(content);
			}
			var footer="<p>来源："+source+"</p><p>有效期："+date+"</p>";
			$("#hb-footer").html(footer);
		}

		</script>

		</body>
		</html>