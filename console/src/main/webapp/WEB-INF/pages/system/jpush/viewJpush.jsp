<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.JpushAttr"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.JpushManage"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Jpush"%>
<%@page import="com.dimeng.p2p.console.servlets.system.jpush.ImportJpush"%>
<%@page import="com.dimeng.p2p.console.servlets.system.jpush.AddJpush"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp"%>
</head>
<body>
    <%
    Jpush jpush = ObjectHelper.convert(
			request.getAttribute("jpush"), Jpush.class);
	if (jpush == null) {
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
	
	JpushManage jpushManage = serviceSession.getService(JpushManage.class);
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "JGTS";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
						<div class="atil">
	              				<h3>APP推送详情</h3>
	           				 </div>
							<div class="con">
								<div class="clear"></div>
									<ul class="cell xc_jcxx ">
									     <li>
											<div class="til">
												发送对象：
											</div>
											<div class="info">
											  <%
											    if("ZDR".equals(jpush.sendType.name())) {%>
												<input type="radio" value="ZDR" name="sendType"
													 checked="checked"
													/>指定人<%}else{ %>
													<input type="radio" value="SY" name="sendType"
													 checked="checked"
													/>所有人	
											<%} %>
												
											</div>
											<div class="clear"></div>
										</li>
								   <li>
											<div class="til">
												发送个数：
											</div>
											<div class="info">
											  <%=jpush.sendCount%>
												
											</div>
											<div class="clear"></div>
										</li>
								 <%if("ZDR".equals(jpush.sendType.name())) {%>
										<li id="letterLi">
											<div class="til">
												用户名：
											</div>
											<div class="info">
												<textarea name="userName" id="username" cols="45" rows="5" class="border fl mr10 yw_w5 required"><%
												if(jpush.pushUser!=null){
													String[] users=jpush.pushUser.split(",");
													for(int i=0;i<users.length;i++){  %>
													<%=users[i]+"\n" %>	
												<%	}
												}
												%></textarea>
												<p tip></p>
			
											</div>
											<div class="clear"></div>
										</li>
								 <%}%>
										<li>
											<div class="til">
												推送类型：
											</div>
											<div class="info">
												<select id="jtype" name="jtype">
												    <%if("1".equals(jpush.jtype)) {%>
														<option value="1">内部内容</option>
													<%}else if("2".equals(jpush.jtype)){%>
														<option value="2">内部模块</option>
													<%}else if("3".equals(jpush.jtype)){ %>
														<option value="3">外部推送</option>
													<%}%>	
												</select>
												
											</div>
											<div class="clear"></div>
										</li>
									<%if("3".equals(jpush.jtype)){ %>
										<li id="urlli" style="display: none">
											<div class="til">
												<span class="red">*</span>推送路径：
											</div>
											<div class="info">
												<label> <%
											 	    StringHelper.filterHTML(out,jpush.url);
											     %>
											    </label>
											</div>
											<div class="clear"></div>
										</li>
									 <%}%>
									 
									<%if("2".equals(jpush.jtype)){  
									%>
										<li id="insilli">
											<div class="til">
												内部模块：
											</div>
											<div class="info">
											  <%if(jpush.jumpModule==1){  %>
												 主界面:<input type="radio" value="1"  name="insiModel"  checked="checked"/>
											  <%}else if(jpush.jumpModule==2){  %>
												  用户中心:<input type="radio" value="2"  name="insiModel" checked="checked"/>
											  <%}else if(jpush.jumpModule==3){  %>
												体验标:<input type="radio" value="3"  name="insiModel"  checked="checked"/>
											  <%}else if(jpush.jumpModule==4){  %>
												普通标:<input type="radio" value="4"  name="insiModel"  checked="checked"/>
											  <%}else if(jpush.jumpModule==5){  %>
												善行宝:<input type="radio" value="5"  name="insiModel"  checked="checked"/>
											 <%} %>
											</div>
											<div class="clear"></div>
										</li>
									<%} %>	
										
										
									    <li>
											<div class="til">
												推送标题：
											</div>
											<div class="info">
												<label> <%
											 	StringHelper.filterHTML(out, jpush.title);
											 %>
											</label>
											</div>
											<div class="clear"></div>
										</li>
										
					<% List<JpushAttr> lists = jpushManage.getJpushAttr(jpush.id);
					   if(lists!=null){%>
										<li>
											<ul id="extaddjpu">
											<%
											 
											  for(int i=0;i<lists.size();i++){
												  JpushAttr jattr=lists.get(i);
											%>
											 <li><%if(i==0){ %>
											 <div class="til">附加字段：</div>
											 <%}else{ %>
											  <div class="til">&nbsp;</div>
											 <%} %>>
											 <div class="info">
											     键:&nbsp;&nbsp;<%=jattr.jkey %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;值:&nbsp;&nbsp;<%=jattr.jvalue %>
											 </div>
											 <div class="clear"></div>
											 </li>
											 <%} %>
											 
											</ul>
										</li>
							<%} %>		
										<li>
											<div class="til">
												推送内容：
											</div>
											<div class="info orange">
												<textarea name="content" id="content" cols="80" rows="9"
													><%StringHelper.filterHTML(out, jpush.content);%></textarea></textarea>
												<p id="errorContent">&nbsp;</p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
									<input type="button" onclick="location.href='<%=controller.getURI(request, JpushList.class) %>'" class="btn4" value="返回" />
								</div>
									<div class="clear"></div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>

		
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	</script>
</body>
</html>