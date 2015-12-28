<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.HfjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.TbjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.JkjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.KxrzView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.ByrzView"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.BasicInfo"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YHGL";
		CURRENT_SUB_CATEGORY="GRXX";
		BasicInfo basicInfo = ObjectHelper.convert(request.getAttribute("basicInfo"),BasicInfo.class);
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
						     	<li>冻结金额： <%=Formater.formatAmount(basicInfo.freeze)%>元</li>
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
                        <li id="one1" class="hover">基本信息</li>
                        <li id="one2" onclick="window.location.href='<%=controller.getURI(request, ByrzView.class)%>?userId=<%=basicInfo.userId%>'">必要认证（<%=byrztg%>/<%=basicInfo.needAttestation %>）</li>
                        <li id="one3" onclick="window.location.href='<%=controller.getURI(request, KxrzView.class)%>?userId=<%=basicInfo.userId%>'">可选认证（<%=kxrztg%>/<%=basicInfo.notNeedAttestation %>）</li>
                        <li id="one4" onclick="window.location.href='<%=controller.getURI(request, JkjlView.class)%>?userId=<%=basicInfo.userId%>'">借款记录</li>
                        <li id="one5" onclick="window.location.href='<%=controller.getURI(request, TbjlView.class)%>?userId=<%=basicInfo.userId%>'">投资记录</li>
                     	<li id="one6" onclick="window.location.href='<%=controller.getURI(request, HfjlView.class)%>?userId=<%=basicInfo.userId%>'" style="border-right:1px #d7dfe3 solid;">回访记录</li>
                     </ul>
                    </div>     
                  </div>
                  <div class="border p30 Men_bt" id="con_one_1">
                  	<ul class="cell noborder no_xq">
                    <li>
                        <div class="til"><span class="red">*</span>  昵称：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.userName);%>
                        </div>                        
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 真实姓名：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.realName);%>
                        </div>
                        <div class="tir">
                        <%
                        	if ("WYZ".equals(basicInfo.isSmrz)) {
                        %>
                        <span class="ico_2"></span>未认证
                        <%
                        	}else if("YYZ".equals(basicInfo.isSmrz)){
                        %>
                        <span class="ico_1"></span>已认证   
                        <%
                        	}
                        %> 
                        </div>                
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 身份证号：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.identityCard);%>
                        </div>
                        <div class="tir">
                        <%
                        	if ("WYZ".equals(basicInfo.isSmrz)) {
                        %>
                        <span class="ico_2"></span>未认证
                        <%
                        	}else if("YYZ".equals(basicInfo.isSmrz)){
                        %>
                        <span class="ico_1"></span>已认证   
                        <%
                        	}
                        %> 
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 手机号码：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.msisdn);%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 邮箱地址：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.mailbox);%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 性   别：</div>
                        <div class="info"><%=basicInfo.sex!=null?basicInfo.sex.getName():""%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 出生日期：</div>
                        <div class="info"><%=DateParser.format(basicInfo.birthDate)%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 毕业学校：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.graduateSchool);%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 公司行业：</div>
                        <div class="info">
                        <%StringHelper.filterHTML(out, basicInfo.companyBusiness);%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 公司规模：</div>
                        <div class="info">
                        	<%if(!StringHelper.isEmpty(basicInfo.companyScale)){
                        		StringHelper.filterHTML(out, basicInfo.companyScale);
                        	%>人
                        	<%} %>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 职   位：</div>
                        <div class="info"><%StringHelper.filterHTML(out, basicInfo.position);    %>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til">拉黑原因：</div>
                        <div class="info">
                        	<%StringHelper.filterHTML(out, basicInfo.blacklistDesc);%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    </ul>
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