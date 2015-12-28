<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.base.front.service.entity.HelpCenterVO"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.HelpCenterManage"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<%
				String sel_str="MCJS";
				String name="名词解释";
				int id = IntegerParser.parse(request.getParameter("id"));
				if(id==0){id=1;}
				int pid = IntegerParser.parse(request.getParameter("pid"));
				if(id==2){
					sel_str="PTJS";
					name="常见疑问";
				}else if(id==3){
					sel_str="LXHFY";
					name="利息和费用";
				}else if(id==4){
					sel_str="WYJK";
					name="我要借款";
				}else if(id==5){
					sel_str="WYLC";
					name="我要理财";
				}else if(id==6){
					sel_str="WDWZH";
					name="平台账户";
				}
				CURRENT_SUB_CATEGORY = sel_str;
			%>
<html>
<head>
<title><%=name%></title>
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
			<%@include file="/WEB-INF/include/xszy/left.jsp"%>
					<div class="clearfix container">
					<div class="help_title clearfix"><%=name%></div>
                    <div class="help_submenu">
                        <ul>
                        <% 
                       		HelpCenterManage manage = serviceSession.getService(HelpCenterManage.class);
	                		Map<Integer, String> l2Map=manage.getSublevel(id);
                        	if(l2Map.size()>0){
                        		Object s[] = l2Map.keySet().toArray();
                        		if(pid==0){
                            		pid=(int)s[0];
                            	}
                        		for(int i=0;i<l2Map.size();i++){
                        		if(!name.equals(l2Map.get(s[i]))){
                        %>
                          <li id="li_<%=s[i]%>"><a href="<%=controller.getURI(request, Help.class)%>?id=<%=id%>&pid=<%=s[i]%>"><%=l2Map.get(s[i])%></a></li>
                          <%}}} %>
                        </ul>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="help_ctbox">
                     <ul id="toggle" class="toggle">
                     <%
                          List<HelpCenterVO> list=manage.list(pid);
                     	  if(null!=list && l2Map.size()>0){
                 		 	 for(HelpCenterVO vo:list){
                     %>
                    <li id="link_<%=vo.id %>">
                    	<%if(!name.equals(vo.title)){ %>
                        	<div class="link"><%=vo.title %><i class="fa fa-chevron-down"></i></div>
                        	<div class="h_submenu" id="div_<%=vo.id %>"><%=vo.content%></div>
                        <%}else{ %>
                          <div><%=vo.content%></div>
                        <%} %>
                    </li>
                    <%}} %>
                 </ul>
                 </div>
			        </div>
            <div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/help.js"></script>
    <script type="text/javascript">
    $(".help_submenu li").removeClass("chosen");
    $("#li_<%=pid%>").addClass("chosen");
    $("#link_<%=request.getParameter("cid")%>").addClass("open");
    $("#div_<%=request.getParameter("cid")%>").attr("style","display: block;");
    </script>
</body>
</html>