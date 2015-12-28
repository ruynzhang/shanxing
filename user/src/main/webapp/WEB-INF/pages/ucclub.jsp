<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>


</head>
<body>
<div  style="display: none" >
	<%@include file="/WEB-INF/include/header.jsp"%>
</div>
	<%
	try{
   	 if(accountName != null){
   		// System.out.println("accountName:"+accountName);
			  String phpScript = (String)MerCached.client.get("phpScript:" + accountName);
			  String clubScript = (String)MerCached.client.get("clubScript:" + accountName);
			  if(phpScript != null && phpScript.trim().length() > 0){
				  MerCached.client.delete("phpScript:" + accountName);
				  out.println(phpScript);
			  }
			  if(clubScript != null && clubScript.trim().length() > 0){
				  MerCached.client.delete("clubScript:" + accountName);
				  out.println(clubScript);
			  }
   	 }
	  }catch(Exception e){e.printStackTrace();}
	%>
	<%
	  String slhurl = request.getAttribute("slhurl")==null?"":request.getAttribute("slhurl").toString();
	%>
<%if(slhurl!=null && !"".equals(slhurl)){ 
%>
<div style="text-align:center; font-size:16px;padding:10px; color:#FF313B;">登录成功!</div>
<%}else{ %>
<div style="text-align:center; font-size:16px;padding:10px; color:#FF313B;">登录失败!</div>
<%} %>
<script type="text/javascript">
   setTimeout( function(){
      window.parent.location.href= "<%=slhurl%>";
   },2500);
  
</script>
</body>
</html>
