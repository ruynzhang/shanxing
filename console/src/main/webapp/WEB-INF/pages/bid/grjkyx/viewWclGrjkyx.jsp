<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Grjkyx"%>
<%@page import="com.dimeng.util.Formater"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="GRJKYX";
	Grjkyx grjkyx = (Grjkyx)request.getAttribute("grjkyx");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1">
                	<div class="atil">
                    	<h3>个人借款意向详情</h3>
                    </div>
                    <div class="con">
                    <form>
                    <ul class="cell noborder yw_jcxx">
                    <%if(grjkyx.F02>0){%>
                    <li>
                        <div class="til">会员帐号：</div>
                        <div class="info"><%StringHelper.filterHTML(out, grjkyx.hyzh);%></div>
                        <div class="clear"></div>
                    </li>
                    <%}%>
                    <li>
                        <div class="til">联系人：</div>
                        <div class="info"><%StringHelper.filterHTML(out, grjkyx.F03);%></div>
                         <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til">手机号码：</div>
                        <div class="info"><%StringHelper.filterHTML(out, grjkyx.F04);%></div>
                         <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">意向借款金额：</div>
                        <div class="info"><%=Formater.formatAmount(grjkyx.F06)%>元</div>
                         <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">借款类型：</div>
                        <div class="info">个人借款意向</div>
                         <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">所在城市：</div>
                        <div class="info"><%StringHelper.filterHTML(out, grjkyx.szcs);%></div>
                         <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">预期筹款期限：</div>
                        <div class="info"><%=grjkyx.F09%></div>
                         <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">借款描述：</div>
                        <div class="info"><%StringHelper.filterHTML(out, grjkyx.F10);%></div>
                         <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">提交时间：</div>
                        <div class="info"><%=TimestampParser.format(grjkyx.F13)%></div>
                         <div class="clear"></div>
                    </li>
                    </ul>
                    <div class="tc w220"><input type="button" onclick="window.location.href='<%=controller.getURI(request, GrjkyxList.class)%>'" class="btn4" value="返回列表" /></div>
                    <div class="clear"></div>
                    </form>                  
                    </div>
                </div>
            	<div class="mb15"></div>
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