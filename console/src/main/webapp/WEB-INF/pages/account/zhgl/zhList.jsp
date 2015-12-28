<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.Del"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.AddJg"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.AddQy"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.AddGr"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.UnBlack"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.Black"%>
<%@page import="com.dimeng.p2p.S71.entities.T7152"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.UnLock"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.Lock"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddProjectXq"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.Export"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F08"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.ZhList"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.User"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.UserManage"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="ZHGL";
	UserManage userManage = serviceSession.getService(UserManage.class);
	PagingResult<User> list = (PagingResult<User>)request.getAttribute("list");
	User[] userArray = list.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
  
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="form1" action="<%=controller.getURI(request, ZhList.class)%>" method="post">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>用户信息</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                                <p>登录账号：<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" class="yhgl_input mr5" /></p>
                                <p>手机号：<input type="text" name="phone" value="<%StringHelper.filterHTML(out, request.getParameter("phone"));%>" class="yhgl_input mr5" /></p>
                                <p>邮箱：<input type="text" name="eamil" value="<%StringHelper.filterHTML(out, request.getParameter("eamil"));%>" class="yhgl_input mr5" /></p>
                       	    	<p>注册时间：
	                       	    	<input type="text" name="startTime" readonly="readonly" id="datepicker1" class="yhgl_input date" />
	                                <span class="pr10">至</span>
	                                <input readonly="readonly" type="text" name="endTime" id="datepicker2" class="yhgl_input date" />
                                </p>	
                                <p>注册来源：
                                	<select name="zcly" class="yhgl_sel">
                                  	<option value="">全部</option>
                                  	<%
                                  		for (T6110_F08 t6110_F08 : T6110_F08.values()) {
                                  	%>
									<option value="<%=t6110_F08.name()%>" <%if (t6110_F08.name().equals(request.getParameter("zcly"))) {%> selected="selected" <%}%>><%=t6110_F08.getChineseName()%></option>
									<%
										}
									%>                                
                                  </select>
                                </p>
                                 <p>状态：
                                	<select name="status" class="yhgl_sel">
                                  	<option value="">全部</option>
                                  	<%
                                  		for (T6110_F07 t6110_F08 : T6110_F07.values()) {
                                  	%>
									<option value="<%=t6110_F08.name()%>" <%if (t6110_F08.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=t6110_F08.getChineseName()%></option>
									<%
										}
									%>                                
                                  </select>
                                </p>
                                <p>账号类型：
                                	<select name="zhlx" class="yhgl_sel">
                                  	<option value="">全部</option>
                                  	<option value="GR" <%if("GR".equals(request.getParameter("zhlx"))){%>selected="selected" <%}%>>个人</option>
                                  	<option value="QY" <%if("QY".equals(request.getParameter("zhlx"))){%>selected="selected" <%}%>>企业</option>
                                  	<option value="JG" <%if("JG".equals(request.getParameter("zhlx"))){%>selected="selected" <%}%>>机构</option>
                                  </select>
                                </p>
                                <p>投资状态：
                                	<select name="tz_status" class="yhgl_sel">
                                  	<option value="0">全部</option>
                                  	<option value="1" <%if("1".equals(request.getParameter("tz_status"))){%>selected="selected" <%}%>>已投</option>
                                  	<option value="2" <%if("2".equals(request.getParameter("tz_status"))){%>selected="selected" <%}%>>未投</option>
                                  </select>
                                </p>
                                <p>投资时间：
	                       	    	<input type="text" name="tz_startTime" readonly="readonly" id="tz_datepicker1" class="yhgl_input date" />
	                                <span class="pr10">至</span>
	                                <input readonly="readonly" type="text" name="tz_endTime" id="tz_datepicker2" class="yhgl_input date" />
                                </p>
                                <p>实名验证：
                                	<select name="yz_status" class="yhgl_sel">
                                  	<option value="0">全部</option>
                                  	<option value="1" <%if("1".equals(request.getParameter("yz_status"))){%>selected="selected" <%}%>>是</option>
                                  	<option value="2" <%if("2".equals(request.getParameter("yz_status"))){%>selected="selected" <%}%>>否</option>
                                  </select>
                                </p>
                              <div class="clear"></div>
                              <div class="mt10">
                              	<input name="" type="submit" class="btn2 mr10" value="搜索" />
                              	<%
                              		if (dimengSession.isAccessableResource(Export.class)) {
                              	%>
                              	<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
                              	<%
                              		}else{
                              	%>
                              	<span class="btn3 mr10 btn5"><span class="ico"></span>导出</span>
                              	<%
                              		}
                              	%>
                              	<%--
                              		if (dimengSession.isAccessableResource(AddGr.class)) {
                              	%>
                   				<a href="<%=controller.getURI(request,AddGr.class)%>" class="btn3 mr10">增加个人账号</a>
                   				<%
                   					}else{
                   				%>
                              	<span class="btn3 mr10 btn5">增加个人账号</span>
                              	<%
                              		}
                              	--%>
                              		<%
                              			if (dimengSession.isAccessableResource(AddQy.class)) {
                              		%>
                   				<a href="<%=controller.getURI(request,AddQy.class)%>" class="btn3 mr10">增加企业账号</a>
                   				<%
                   					}else{
                   				%>
                              	<span class="btn3 mr10 btn5">增加企业账号</span>
                              	<%
                              		}
                              	%>
                              	<%
                              		if (dimengSession.isAccessableResource(AddJg.class)) {
                              	%>
                   				<a href="<%=controller.getURI(request,AddJg.class)%>" class="btn3 mr10">增加机构账号</a>
                   				<%
                   					}else{
                   				%>
                              	<span class="btn3 mr10 btn5">增加机构账号</span>
                              	<%
                              		}
                              	%>
                   				<div class="clear"></div>
                              </div>
                    	</div>    
                    </div>
                </div>
  				
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>登录账号</td>
                          <td>姓名</td>
                          <td>手机</td>
                          <td>邮箱</td>
                           <td>状态</td>
                          <td>注册来源</td>
                           <td>注册时间</td>
                          <td>用户类型</td>
                          <td>总投资次数</td>
                          <td>操作</td>
                        </tr>
                        <%
                        	if (userArray != null){
                                                		int i = 1;
                                                		for(User user :userArray){
                        %>
                        <tr class="dhsbg">
                          <td><%=i++%></td>
                          <td><%
                          	StringHelper.filterHTML(out, user.F02);
                          %></td>
                          <td><%
                          	StringHelper.filterHTML(out, user.name);
                          %></td>
                          <td><%
                          	StringHelper.filterHTML(out, user.F03);
                          %></td>
                          <td><%
                          	StringHelper.filterHTML(out, user.F04);
                          %></td>
                          <td><%
                          	StringHelper.filterHTML(out, user.F06.getChineseName());
                          %></td>
                          <td><%
                          	StringHelper.filterHTML(out, user.F07.getChineseName());
                          %></td>
                          <td><%=DateTimeParser.format(user.F08)%></td>
                          <td>
                          	<%
                          		T6110_F06 yhlx = user.F05;
                          	                          		T6110_F10 dbf =  user.F09;
                          	                          		if(yhlx == T6110_F06.ZRR){
                          	                          			out.print("个人");
                          	                          		}else if(yhlx == T6110_F06.FZRR && dbf == T6110_F10.F){
                          	                          			out.print("企业");
                          	                          		}else if(yhlx == T6110_F06.FZRR && dbf == T6110_F10.S){
                          	                          			out.print("机构");
                          	                          		}
                          	%>
                          </td>
                          <td><%=user.tz_count%></td> 
                          <td>
                          	<%
                          		Boolean tg = BooleanParser.parseObject(configureProvider
                    				.getProperty(SystemVariable.SFZJTG));
                          		if (dimengSession.isAccessableResource(AddProjectXq.class)&&user.F06 != T6110_F07.HMD &&user.F06 != T6110_F07.SD&&!(yhlx == T6110_F06.FZRR && dbf == T6110_F10.S)) {
                          			if(!(tg && !userManage.isTg(user.F01)))
                          			{
                          	%>
                          		<span class="blue"><a href="<%=controller.getURI(request,AddProjectXq.class)%>?userId=<%=user.F01%>&userType=<%=yhlx%>" class="mr10">新建借款</a></span>
                         	<%
                         		}
                          		}
                         	%>
                         		
                         	<%
                         		                         		if (T6110_F07.QY == user.F06){
                         		                         	                         			if (dimengSession.isAccessableResource(Lock.class)) {
                         		                         	%>
		                          	<span class="blue"><a href="javascript:void(0)" onclick="showSd('<%=i%>')" class="mr10">锁定</a></span>
		                          	<%
		                          		}else{
		                          	%>
		                          	<span class="disabled"  class="mr10">锁定</span>
                         	<%
                         		}
                         	                         		}else if(T6110_F07.SD == user.F06){
                         	                         			if (dimengSession.isAccessableResource(UnLock.class)) {
                         	%>
	                          	<span class="blue"><a href="javascript:void(0)" onclick="showJs('<%=i%>')" class="mr10">解锁</a></span>
	                          	<%
	                          		}else{
	                          	%>
	                          	<span class="disabled"  class="mr10">解锁</span>
                         	<%
                         		}
                         	                         		}
                         	%>
                          	<%
                          		if(T6110_F07.HMD != user.F06 && user.isYzyq){
                          	%>
                          		<%
                          			if (dimengSession.isAccessableResource(Black.class)) {
                          		%>
                          		<span class="blue"><a href="javascript:void(0)" onclick="showYzyqLh('<%=i%>')" class="mr10">拉黑</a></span>
                          		<%
                          			}else{
                          		%>
                          		<span class="disabled" class="mr10">拉黑</span>
                          		<%
                          			}
                          		%>
                          	<%
                          		}else if(T6110_F07.HMD != user.F06 && !user.isYzyq){
                          	%>
                          		<%
                          			if (dimengSession.isAccessableResource(Black.class)) {
                          		%>
                          		<span class="blue"><a href="javascript:void(0)" onclick="showLh('<%=i%>')" class="mr10">拉黑</a></span>
                          		<%
                          			}else{
                          		%>
                          		<span class="disabled" class="mr10">拉黑</span>
                          		<%
                          			}
                          		%>
                          	<%
                          		}
                          	%>
                          	
                         <%--  	<%
                          	                          		if (dimengSession.isAccessableResource(Del.class)) {
                          	                          	%>
                          		<span class="blue"><a href="javascript:void(0)" onclick="showDel('<%=i %>')" class="mr10">删除</a></span>
                          		<%}else{ %>
                          		<span class="disabled" class="mr10">删除</span>
                          		<%} %> --%>
                          </td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                
                <%
                	AbstractConsoleServlet.rendPagingResult(out, list);
                %>
                </form>       
				 <%
                        	if (userArray != null){
                        		int i = 1;
                        		for(User user :userArray){
                        			i++;
                 %>
				<div class="wrap" id="sd_<%=i%>" style="display: none">
					<div class="popup_bg"></div>
					<form action="<%=controller.getURI(request, Lock.class)%>" method="post"  class="form1">
			        <input type="hidden" name="userId" value="<%=user.F01%>"/>
			        <input type="hidden" name="paging.current" value="<%=list.getCurrentPage()%>"/>
					<div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
				      <div class="tit">
				         <span class="fl pl15">锁定</span>
				         <span class="fr pr15 close" onclick="javascript:document.getElementById('sd_<%=i%>').style.display='none';return false;"><a href="#">关闭</a></span>
				      </div>
				      <div id="js" class="info clearfix">
				      	<div class="clearfix">
				            <span class="icon_cw" style="display:none;"></span>
				            <span class="icon_yw" style="display:none;"></span>
				            <span class="icon_cg" style="display:none;"></span>							            
				            <span class="fl tips"><span class="icon_gt" ></span>确定锁定用户“<span id="a"><%
				            	StringHelper.filterHTML(out, user.F02);
				            %></span>”吗？</span>
				        </div>
         			    <div class="clear"></div>				        
				        <div class="dialog_btn"><input type="submit" value="提交" class="btn4 ml50 sumbitForme" fromname="form1"/></div> 
				      </div>
					</div>
					</form>
			    </div>
			    
			    <div class="wrap" id="del_<%=i%>" style="display: none">
					<div class="popup_bg"></div>
					<form action="<%=controller.getURI(request, Del.class)%>" method="post"  class="form1">
			        <input type="hidden" name="userId" value="<%=user.F01%>"/>
					<div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
				      <div class="tit">
				         <span class="fl pl15">删除</span>
				         <span class="fr pr15 close" onclick="javascript:document.getElementById('del_<%=i%>').style.display='none';return false;"><a href="#">关闭</a></span>
				      </div>
				      <div id="js" class="info clearfix">
				      	<div class="clearfix">
				            <span class="icon_cw" style="display:none;"></span>
				            <span class="icon_yw" style="display:none;"></span>
				            <span class="icon_cg" style="display:none;"></span>							            
				            <span class="fl tips"><span class="icon_gt" ></span>确定删除用户“<span id="a"><%
				            	StringHelper.filterHTML(out, user.F02);
				            %></span>”吗？</span>
				        </div>
         			    <div class="clear"></div>				        
				        <div class="dialog_btn"><input type="submit" value="提交" class="btn4 ml50 sumbitForme" fromname="form1"/></div> 
				      </div>
					</div>
					</form>
			    </div>
			    
			    <div class="wrap" id="js_<%=i%>" style="display: none">
			    	<div class="popup_bg"></div>
			        <div class="r_main">
			            <div class="home_main">
			            	<div class="box box1">
			            	<form action="<%=controller.getURI(request, UnLock.class)%>" method="post"   class="form1">
			            		<input type="hidden" name="userId" value="<%=user.F01%>"/>
			            		<input type="hidden" name="paging.current" value="<%=list.getCurrentPage()%>"/>
			                    <div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
							      <div class="tit">
							         <span class="fl pl15">解锁</span>
							         <span class="fr pr15 close" onclick="javascript:document.getElementById('js_<%=i %>').style.display='none';return false;"><a href="#">关闭</a></span>
							      </div>
							      <div id="js" class="info clearfix">
							        <div class="clearfix">
							            <span class="icon_cw" style="display:none;"></span>
							            <span class="icon_yw" style="display:none;"></span>
							            <span class="icon_cg" style="display:none;"></span>
							            <span class="fl tips"><span class="icon_gt" ></span>确定解锁用户“<span id="a"><%StringHelper.filterHTML(out, user.F02);%></span>”吗？</span>
							        </div>
							        <div class="dialog_btn"><input type="submit" value="提交"  class="btn4 ml50 sumbitForme"  fromname="form1"/></div> 
							      </div>
								</div>
							</form> 
			                </div>
			            	<div class="mb15"></div>
			                <div class="box2 clearfix"></div>
			            </div>
			        </div>   
			    </div>
			   <%
			   T7152[] csjllist = userManage.csjlSearch(user.F01);
			   %>
				<div id="lh_<%=i %>" style="display: none">
					<div class="popup_bg"></div>
					<div class="w650 thickbox thickpos" style='margin: -310px 0 0 -325px;'>
					<form action="<%=controller.getURI(request, Black.class)%>" method="post" class="form1">
					<input type="hidden" name="type" value="1"/>
					<input type="hidden" name="userId" value="<%=user.F01%>"/>
					<input type="hidden" name="state" value="LH"/>
					<input type="hidden" name="paging.current" value="<%=list.getCurrentPage()%>"/>
					<div class="tit">
						<span class="fl pl15">拉黑</span><span class="fr pr15 close" onclick="javascript:document.getElementById('lh_<%=i %>').style.display='none';return false;"><a href="#">关闭</a></span>
					</div>
					<div class="info clearfix">
						<div class="tc">
							<span class="mr50">用户名：<%StringHelper.filterHTML(out, user.F02); %></span>
						</div>
						<div class="tips_con">
							<div class="bigtit mt10 clearfix">
								<span class="fl">拉黑说明</span>
							</div>
							<div class="tc pt10">
								<textarea name="blacklistDesc" cols="" rows="" class="area required max-length-255"></textarea>
								<p tip></p>
								<p errortip class="" style="display: none"></p>
							</div>
							<div class="dialog_btn">
								<input type="submit" value="确定" class="btn4 fl mr10 sumbitForme" fromname="form1"/> 
								<input type="button" class="btn5 fl" value="取消" onclick="document.getElementById('lh_<%=i %>').style.display='none'"/>
								<div class="clear"></div>
							</div>
							<div class="mt10">
								<p>最近催收记录（所有借款）：</p>
								<table width="100%" border="0" cellspacing="0" class="ratetable">
									<tr class="titbj">
										<td>序号</td>
										<td>催收时间</td>
										<td>催收方式</td>
										<td>催收人</td>
										<td>结果概要</td>
									</tr>
									<%if (csjllist != null) {for (int n = 0,length=Math.min(csjllist.length, 3);n < length;n++) {T7152 t7152 = csjllist[n];if (t7152 == null) {continue;}%>
					             	<tr>
						                <td><%=n+1%></td>
						                <td><%=TimestampParser.format(t7152.F08,"yyyy-MM-dd") %></td>
						                <td><%=t7152.F04.getChineseName() %></td>
						                <td><%StringHelper.filterHTML(out, t7152.F05); %></td>
						                <td title="<%StringHelper.filterHTML(out, t7152.F06);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(t7152.F06, 15));%></td>
					              	</tr>
					              <%}}%>
								</table>
								<p class="tr mt5">共<%=csjllist==null?0:csjllist.length %>条记录 | <a href="<%=controller.getURI(request, CsList.class)%>?userName=<%=user.F02%>">查看全部&gt;&gt;</a></p>
							</div>
						</div>
					</div>
					</form>
					</div>
				</div>
				<%}}%>
            </div>
        </div>   
    </div>
        
    <%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
		    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
		    
		    $("#tz_datepicker1").datepicker({inline: true,
				onSelect : function(selectedDate) {
		            $("#tz_datepicker2").datepicker("option", "minDate", selectedDate); 
		        }
			});
		    $('#tz_datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#tz_datepicker2").datepicker({inline: true});
		    $('#tz_datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#tz_datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("tz_startTime"));%>");
		    $("#tz_datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("tz_endTime"));%>");
		    $("#tz_datepicker2").datepicker('option', 'minDate',$("#tz_datepicker1").datepicker().val());
		});
		
		function showExport()
		{
			document.getElementById("form1").action ="<%=controller.getURI(request, Export.class)%>";
			$("#form1").submit();
			document.getElementById("form1").action ="<%=controller.getURI(request, ZhList.class)%>";
		}
		
		function showSd(i)
		{
			$("#sd_"+i).show();
		}
		
		function showJs(i)
		{
			$("#js_"+i).show();
		}
		
		function showLh(i)
		{
			if(confirm("此账号无逾期情况，请慎重操作！"))
		    {
			$("#lh_"+i).show();
		    }
		}
		
		function showDel(i)
		{
			if(confirm("删除后不能恢复，确定删除此账号？"))
		    {
			$("#del_"+i).show();
		    }
		}
		
		function showYzyqLh(i)
		{
			if(confirm("此账号有严重逾期情况，是否拉黑！"))
		    {
			$("#lh_"+i).show();
		    }
		}
	</script>
</body>
</html>