<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.HfjlView"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.Open"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Attestation"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.TbjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.JkjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.KxrzView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.JbxxView"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.BasicInfo"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YHGL";
		CURRENT_SUB_CATEGORY="GRXX";
		BasicInfo basicInfo = ObjectHelper.convert(request.getAttribute("basicInfo"), BasicInfo.class);
		Attestation[] needAttestations = ObjectHelper.convertArray(request.getAttribute("needAttestation"), Attestation.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
	<div class="main clearfix">
				  
		<div class="wrap">
			<div class="r_main">
				<div class="home_main">
			    	<div class="box box1 mb15">
			 			<div class="atil"><h3>用户详细情况</h3></div>
			     		<div class="con con1">
			     			<ul class="yhxq_li">
						     	<li>用户名：<%StringHelper.filterHTML(out, basicInfo.userName);%></li>      
						     	<li>净资产： <%=Formater.formatAmount(basicInfo.netAssets)%>元</li>              
						    </ul>
						     <ul class="yhxq_li">
						      	<li>账户余额：  <%=Formater.formatAmount(basicInfo.accountBalance)%>元</li>
						      	<li>理财资产： <%=Formater.formatAmount(basicInfo.lczc)%>元</li>
						     </ul>
						     <ul class="yhxq_li">
						     	<li>借款负债： <%=Formater.formatAmount(basicInfo.borrowingLiability)%>元</li>
						  </ul>
						  <ul class="yhxq_li">
						   		<li>必要认证： 
							     <%
							     	int byrztg = basicInfo.byrztg;
							        if(byrztg <= 0){
							     %>
							     	未认证
							     <%
							     	}else{
							     %>
							   	 通过<%=byrztg%>项
							   	 <%
							     	}
							     %>
							   	</li>
						   		<li>可选认证： 
								<%
							     	int kxrztg = basicInfo.kxrztg;
							        if(kxrztg <= 0){
							     %>
							     	未认证
							     <%
							     	}else{
							     %>
							   	 通过<%=kxrztg%>项
							   	 <%
							     	}
							     %>              
							     </li>
						  </ul>
						  <ul class="yhxq_li">
						  	<li>注册时间：  <%=TimestampParser.format(basicInfo.registrationTime)%></li>
						  </ul>
			     		<div class="clear"></div>
			     	</div>
				</div>
                <div class="newsbox">
                  <div class="til clearfix">
                   <div class="Menubox">
                     <ul>
                        <li id="one1" onclick="window.location.href='<%=controller.getURI(request, JbxxView.class)%>?userId=<%=basicInfo.userId%>'">基本信息</li>
                        <li id="one2" class="hover">必要认证（<%=byrztg%>/<%=basicInfo.needAttestation%>）</li>
                        <li id="one3" onclick="window.location.href='<%=controller.getURI(request, KxrzView.class)%>?userId=<%=basicInfo.userId%>'">可选认证（<%=kxrztg%>/<%=basicInfo.notNeedAttestation%>）</li>
                        <li id="one4" onclick="window.location.href='<%=controller.getURI(request, JkjlView.class)%>?userId=<%=basicInfo.userId%>'">借款记录</li>
                        <li id="one5" onclick="window.location.href='<%=controller.getURI(request, TbjlView.class)%>?userId=<%=basicInfo.userId%>'">投资记录</li>
                     	<li id="one6" onclick="window.location.href='<%=controller.getURI(request, HfjlView.class)%>?userId=<%=basicInfo.userId%>'" style="border-right:1px #d7dfe3 solid;">回访记录</li>
                     </ul>
                    </div>     
                  </div>
                  <div class="border p15 Men_bt no_table" id="con_one_2">
                  	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table tc">
                      <tr class="hsbg">
                        <td>项目</td>
                        <td>状态</td>
                        <td>认证时间</td>
                        <td>信用分数</td>
                        <td>操作</td>
                      </tr>
                      <%
                      	if (needAttestations != null) {
                      					int i = 1;
                      					for (Attestation need : needAttestations) {
                      						if (need == null) {
                      							continue;
                      						}
                      %>
                      <tr class="bom">
                        <td><%StringHelper.filterHTML(out, need.attestationName);%></td>
                        <td><%=need.attestationState.getChineseName()%></td>
                        <td><%=TimestampParser.format(need.attestationTime)%></td>
                        <td><%=need.creditGrades%></td>
                        <% String[] attachments = need.attachments;
                        	if(attachments !=null){
                        %>
                        	<td align="center" class="blue">
                        <%
                        		for(int a = 0 ;a<attachments.length ;a++){
                        			String id = attachments[a];
                        			if(!StringHelper.isEmpty(id)){
                        %>
                        		<a target="_blank" href="<%=controller.getURI(request,Open.class)%>?id=<%=id%>">查看证件&nbsp;<%=a+1 %>&nbsp;</a>
                        <%}} %>
                        	</td>
                        <%}else{ %>
                        	<td align="center" class="gray6">查看证件</td>
                        <%} %>
                      </tr>
                      <%
                      	}
                      				}
                      %>
                    </table>
              	  <div class="clear"></div>
                  </div>
                </div>
                <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
        
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>