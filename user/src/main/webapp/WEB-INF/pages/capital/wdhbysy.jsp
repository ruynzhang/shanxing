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

	<%
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	int userId=serviceSession.getSession().getAccountId();
	RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
	RedPacketRecord query = new RedPacketRecord();
	query.parse(requestWrapper);//设置界面传来的参数
	query.state=11;
	query.userId=userId;
	//分页对象
	PagingResult<RedPacketRecord> list = manage.getListRecord(query, new Paging() {
		@Override
		public int getSize() {
			return 10;
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
				<li><a href="/user/capital/wdhb.html">未使用</a></li>
				<li class="tabFocus">已使用</li>
				<li><a href="/user/capital/wdhbygq.html">已过期</a></li>
			</ul>
             <div class="line"></div>
			<div class="maincontent" >
		    <!--已使用---->
		    <form action="/user/capital/wdhbysy.html" method="post">
			<div class="content  hb_bottom conFocus">
				<div class="tb-list hb-table">
					<div style="border-radius:0" class="newinfo">
					 <table class="tableOdd mb10 ">
						<tbody>
							<tr>
								<th>使用时间</th>
								<th>类型</th>
								<th>价值</th>
								<th>来源</th>
								<th>摘要</th>
							</tr>
							<%
								int i=1; 
								if(null!=recordArray){
								for(RedPacketRecord record:recordArray){
									int zqid=manage.getZqIdByTzId(record.tzid);
							%>
							<tr class="<%=i%2==1?"tdColor":""%>">
								<td><%=Formater.formatDate(record.updateTime)%></td>
								<td><%=record.type==1?"投资红包":"现金红包"%></td>
								<td>￥<%=record.amount.intValue()%></td>
								<td><%if(record.source==1){out.print("手动发放");}else if(record.source==2){out.print("注册");}else{out.print("推广");}%></td>
								<td>
									<%if(record.state==3){%>
										<a href="/user/financing/wdzq/tzxq/<%=zqid%>.html">查看对应债权</a>
									<%}else{ %>
										已冻结
									<%}%>
								</td>
							</tr>
						 <%i++;}} %>
					 </tbody>
		        </table>
			</div>
			<!------分页---->
			<div class="page">
			<%AbstractCapitalServlet.rendPagingResult(out, list); %>
			</div>

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
		<%@include file="/WEB-INF/include/footer.jsp"%>
		</body>
		</html>