<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.letter.ViewLetter"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Letter"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.AddLetter"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.LetterList"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<Letter> result = (PagingResult<Letter>) request
					.getAttribute("result");
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "ZNXTG";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, LetterList.class)%>" method="post">
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>发送站内信息</h3>
	           				 </div>
			                  <div class="con">
									 <div class="admin_input admin_pb">
					                     <p>标题：<input type="text" name="title" value="<%StringHelper.filterQuoter(out, request.getParameter("title"));%>" id="textfield" class="yhgl_input" /></p>
					                     <p>时间：<input type="text" name="createTimeStart" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterQuoter(out,
						request.getParameter("createTimeStart"));%>" />
					                       <span class="mr5">至</span>
					                       <input type="text" name="createTimeEnd" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterQuoter(out,
						request.getParameter("createTimeEnd"));%>" />
					                     </p>
					                     <div class="clear"></div>
					                   </div>
					                   <div class="mt10">
					                   	 <%
										if(dimengSession.isAccessableResource(AddLetter.class))
										{
									    %>
										 <a href="<%=controller.getURI(request, AddLetter.class)%>" class="btn3 mr10"><span class="ico1"></span>添加</a>
										<%}else{ %>
										<span class="btn3 mr10 btn5"><span class="ico1"></span>添加</span>
										<%} %>
										
										<button type="submit" class="btn2 fl mr10">查找</button>
					                   </div>
					                   <div class="clear"></div>
					            </div>
			                 </div>
						
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
									<tr class="hsbg">
										<td>序号</td>
										<td>标题</td>
										<td>内容</td>
										<td>管理员</td>
										<td>发送对象</td>
										<td>发送数量</td>
										<td>创建时间</td>
										<td>操作</td>
									</tr>
									<%
										Letter[] letters = result.getItems();
											if (letters != null) {
												int i = 1;
												for (Letter letter : letters) {
													if (letter == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td>
											<%
												StringHelper.filterHTML(out, letter.title);
											%>
										</td>
										<td title="<%StringHelper.filterHTML(out, letter.content);%>">
											<%StringHelper.filterHTML(out, StringHelper.truncation(letter.content, 15));%>
										</td>
										<td><%
												StringHelper.filterHTML(out, letter.name);
											%></td>
										<td>
											<%=letter.sendType.getName()
											%>
										</td>
										<td><%=letter.count%></td>
										<td><%=DateTimeParser.format(letter.createTime)%></td>
										<td><span>
											<%
												if(dimengSession.isAccessableResource(ViewLetter.class))
												{
											%>
											<a href="<%=controller.getURI(request, ViewLetter.class)%>?id=<%=letter.id %>" class="mr10 blue">查看</a>
											<%}else{ %>
											<span class="disabled">查看</span>
											<%} %>
										</span></td>
										<%
											}
												}
										%>
									
								</table>
							</div>
							<%
								AbstractConsoleServlet.rendPagingResult(out, result);
							%>
						</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({inline: true,
			onSelect : function(selectedDate) {
	            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
	        }
		});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	</script>
</body>
</html>