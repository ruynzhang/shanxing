<%@page import="com.dimeng.p2p.account.user.service.LetterManage"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.LetterEntity"%>
<%@page import="com.dimeng.p2p.common.enums.LetterStatus"%>
<%@page import="com.dimeng.p2p.user.servlets.letter.Delete"%>
<%@page import="com.dimeng.p2p.user.servlets.letter.Update"%>
<%@page import="com.dimeng.p2p.user.servlets.AbstractUserServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.letter.Index"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%
	configureProvider.format(out,SystemVariable.SITE_NAME);
%>
	站内消息
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		LetterManage letterManage = serviceSession.getService(LetterManage.class);
		int unread = letterManage.getUnReadCount();
		int count = letterManage.getCount();
		final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
		Paging paging = new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}
			
			@Override
			public int getCurrentPage() {
				return currentPage;
			}
		};
		String status = request.getParameter("status");
		LetterStatus letterStatus = null;
		if(!StringHelper.isEmpty(status)){
			letterStatus = LetterStatus.valueOf(status);
		}
		PagingResult<LetterEntity> letters = letterManage.search(letterStatus, paging);
			
			CURRENT_CATEGORY = "XXGL";
			CURRENT_SUB_CATEGORY = "ZNXX";
	%>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=controller.getViewURI(request, Index.class)%>"
				method="post">
				<div class="container fr bor1">
					<div class="zn_li">
						<ul>
							<li class="p10-20">
								<p class="zn_ico1">
									Hi，您共收到了<%=count%>条站内消息，<span id="unread"><%=unread%></span>条未读站内公告，请注意查看哦。如发现异常，
								</p>
								<p>
									请联系<%
									configureProvider.format(out,SystemVariable.SITE_NAME);
								%>客服:
									<%
									configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);
								%>
								</p>
							</li>
							<li class="zn_lsbg p10-20"><input id="checkAll"
								type="checkbox" value="" class="mr20" /> <label class="mr30"
								for="checkAll">全选</label> 
								<a href="javascript:void(0);" class="user_sc mr15" onclick="delAll()">删除</a>
								<select name="status" class="yhgl_ser" style="width: 90px;">
									<option value=""
										<%=StringHelper.isEmpty(status)?"selected=\"selected\"":""%>>全部消息</option>
									<option value="<%=LetterStatus.YD.toString()%>"
										<%=LetterStatus.YD.toString().equals(status)?"selected=\"selected\"":""%>>已读消息</option>
									<option value="<%=LetterStatus.WD.toString()%>"
										<%=LetterStatus.WD.toString().equals(status)?"selected=\"selected\"":""%>>未读消息</option>
							    </select>
							</li>
							<%
								LetterEntity[] letterEntities = letters.getItems();
													if (letterEntities != null&&letterEntities.length>0) {for (LetterEntity letter : letterEntities) {if(letter==null){continue;}
							%>
							<li>
								<div class="inp">
									<input name="letterId" type="checkbox" value="<%=letter.id%>" />
								</div>
								<div style="cursor: pointer;" onclick="openLetter(this,'<%=letter.status.toString()%>','<%=letter.id%>')">
								<div class="til">
									<span
										class='<%=letter.status==LetterStatus.YD?"zn_ico3":"zn_ico2"%>'></span><%=configureProvider.format(SystemVariable.SITE_NAME) %></div>
								<div class="info a1">
									<span>
										<%
											StringHelper.filterHTML(out, letter.title);
										%>
									</span>
								</div>
								</div>
								<div class="time">
									<span class="mr20"><%=DateParser.format(letter.sendTime)%></span><%=TimeParser.format(letter.sendTime)%></div>
								<div class="clear"></div>
								<div id="_<%=letter.id%>" class="b1 p30 ln30 bot"><%=letter.content==null?"":letter.content%></div>
								<div class="clear"></div>
							</li>
							<%
								}}
							%>
						</ul>
						<div class="clear"></div>
						<div class="page p15">
							<%
								AbstractUserServlet.rendPagingResult(out, letters);
							%>
						</div>
					</div>
				</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<div class="dialog w510 thickpos"
		style="margin: -100px 0 0 -255px; display: none;">
		<div class="dialog_close fr">
			<a href="#"></a>
		</div>
		<div class="con clearfix">
			<div class="d_perfect fl"></div>
			<div class="info fr">
				<p class="f20 gray33">确定要删除选中的站内信吗？</p>
			</div>
			<div class="clear"></div>
			<div class="dialog_btn">
				<a href="javascript:void(0)" id="ok" class="btn btn001">确定</a> <a
					href="javascript:void(0)" id="cancel" class="btn btn001">关闭</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var url_update = "<%=controller.getURI(request, Update.class)%>";
		var url_del = "<%=controller.getURI(request, Delete.class)%>";
		var url_self = "<%=controller.getViewURI(request, Index.class)%>";
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/zhankai.js"></script>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/letter.js"></script>
</body>
</html>