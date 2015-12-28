<%@page import="com.dimeng.p2p.user.servlets.account.gzxx.Gzxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.xlxx.Xlxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.fcxx.Fcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.Ccxx"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.UserBase"%>
<%@page import="com.dimeng.p2p.account.user.service.UserBaseManage"%>
<%@page import="com.jhlabs.image.ScaleFilter"%>
<%@page import="com.dimeng.p2p.common.enums.MarriageStatus"%>
<%@page import="com.dimeng.p2p.user.servlets.account.*"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%!public static String getBirthday(String cardID) {
		StringBuffer tempStr = new StringBuffer("");
		if (cardID != null && cardID.trim().length() > 0) {
			if (cardID.trim().length() == 15) {
				tempStr.append(cardID.substring(6, 12));
				tempStr.insert(4, '-');
				tempStr.insert(2, '-');
				tempStr.insert(0, "19");
			} else if (cardID.trim().length() == 18) {
				tempStr = new StringBuffer(cardID.substring(6, 14));
				tempStr.insert(6, '-');
				tempStr.insert(4, '-');
			}
		}
		
		return tempStr.toString();
	}%>
	<%
		UserBaseManage userManage = serviceSession.getService(UserBaseManage.class);
			UserBase data = userManage.getUserBase();
			CURRENT_CATEGORY = "ZHGL";
			CURRENT_SUB_CATEGORY = "GRJCXX";
	%>
	<div class="w994 pb5">
		<span class="f16"><a href="#">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a></span> &gt; <a href="#">账户管理</a> &gt;个人基础信息
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
			
				<div class="til clearfix Men_bt">
	                   <div class="Menubox">                   
		                     <ul>
		                     	<li class="hover">个人基本信息</li>
								<li><a href="<%=controller.getURI(request, Xlxx.class) %>">个人学历信息</a></li>
								<li><a href="<%=controller.getURI(request, Gzxx.class) %>">个人工作信息</a></li>
								<li><a href="<%=controller.getURI(request, Fcxx.class) %>">房产信息</a></li>
								<li style="border-right: 1px #d7dfe3 solid;"><a href="<%=controller.getURI(request, Ccxx.class) %>">车产信息</a></li>
		                     </ul>
	                    </div>                        
               	</div>
               		
				<div class="p30">
					<div class="fl jc_l">
						<div class="user_img tc">
							<%if(StringHelper.isEmpty(data.icon)) {%>
							<img src="<%=controller.getStaticPath(request)%>/images/index_dlimg.jpg" width="120" height="120" />
							<%}else{%>
							<img src="<%=fileStore.getURL(data.icon)%>" width="120" height="120" />
							<%}%>
						</div>
						<div>
							<a href="javascript:void(-1);" onclick="addCard();" class="s_btn" style="margin: auto">上传头像</a>
						</div>
						<div>未选择文件（您可以上传JPG、GIF或PNG文件上传图片最大4M)</div>
					</div>
					<div class="jc_z fl">
						<ul>
							<li>
								<div class="til"><span class="red">*</span>昵称：</div>
								<div class="info">
									<%StringHelper.filterHTML(out,data.userName);
									if(StringHelper.isEmpty(data.userName)){
									%>
									&nbsp;
									<%}%>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>真实姓名：
								</div>
								<div class="info">
									<%
										if(!StringHelper.isEmpty(data.name)){
																		StringHelper.filterHTML(out, data.name.substring(0, 1)+"**");
																	}else{
									%>
									&nbsp;
									<%
										}
									%><br />
								</div> <%
 	if(StringHelper.isEmpty(data.name)){
 %>
								<div class="tir jc_ico2">
									<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>">去绑定</a>
								</div> <%
 	}else{
 %>
								<div class="tir jc_ico1">已认证</div> <%
 	}
 %>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>身份证号：
								</div>
								<div class="info">
									<%
										if(!StringHelper.isEmpty(data.idCard)){
																		StringHelper.filterHTML(out, data.idCard);
																	}else{
									%>
									&nbsp;
									<%
										}
									%>
								</div> <%
 	if(StringHelper.isEmpty(data.idCard)){
 %>
								<div class="tir jc_ico2"><a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>">去绑定</a></div> <%
 	}else{
 %>
								<div class="tir jc_ico1">已认证</div> <%
 	}
 %>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>手机号码：
								</div>
								<div class="info">
									<%
									     String str = data.phoneNumber;
										if(!StringHelper.isEmpty(data.phoneNumber) && str.length() == 11){
																		StringHelper.filterHTML(out, data.phoneNumber.substring(0, 3)+" **** "+data.phoneNumber.substring(8, 11));
																	}else{
									%>
									&nbsp;
									<%
										}
									%>
								</div> <%
 	if(StringHelper.isEmpty(data.phoneNumber)){
 %>
								<div class="tir jc_ico2"><a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>">去绑定</a></div> <%
 	}else{
 %>
								<div class="tir jc_ico1">已认证</div> <%
 	}
 %>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>邮箱地址：
								</div>
								<div class="info">
									<%
										StringHelper.filterHTML(out, data.emil);
																if(StringHelper.isEmpty(data.emil)){
									%>
									&nbsp;
									<%
										}
									%>
								</div> <%
 	if(StringHelper.isEmpty(data.emil)){
 %>
								<div class="tir jc_ico2"><a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>">去绑定</a></div> <%
 	}else{
 %>
								<div class="tir jc_ico1">已认证</div> <%
 	}
 %>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>性别：
								</div>
								<div class="info">
									<%
										if(!StringHelper.isEmpty(data.sfzh)){
											data.sfzh=StringHelper.decode(data.sfzh);
											if(Integer.parseInt(data.sfzh.substring(data.sfzh.length() - 2, data.sfzh.length() - 1)) % 2 != 0){
												StringHelper.filterHTML(out, "男");
											}
											else{
												StringHelper.filterHTML(out, "女");
											}
										}
									%>
								</div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>出生日期：
								</div>
								<div class="info"><%=getBirthday(data.sfzh)%></div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							</ul>
						</div>
					
							</div>
						
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="clear"></div>

	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	
	function addCard() {
		global_art = art.dialog.open("<%=controller.getViewURI(request, Upload.class)%>",{
			id : 'uploadImg',
			title : '上传图像',
			opacity : 0.1,
			width : 580,
			height : 440,
			lock : true,
			close : function() {
				window.location.reload();
			}

		}, false);
	}
	</script>	
		
</body>
</html>