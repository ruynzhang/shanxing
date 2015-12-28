<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.common.enums.Sex"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewTransferRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewCreditor"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewRefundRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewTenderRecord"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.AttestationCheck"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.ViewLoanRecord"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.ViewTransfer"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="ZQZRGL";
	ViewTransfer viewTransfer = (ViewTransfer)request.getAttribute("viewTransfer");
	ViewLoanRecord viewLoanRecord = (ViewLoanRecord)request.getAttribute("viewLoanRecord");
	AttestationCheck[] attestationChecks = viewLoanRecord.attestationCheck;
%>
<%@include file="/WEB-INF/include/header.jsp"%>

<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
          <div class="atil">
            <h3>转让中的债权详情</h3>
          </div>
          <div class="con">
            <div class="clear"></div>
            <div class="contain_main clearfix">
              <div class="pub_title clearfix"> <span class="fl"><em class="xin mr10">信</em> <span class="f16 fB"><%StringHelper.filterHTML(out, viewTransfer.loanRecordTitle);%></span> <a href="#" class="ml30 blue"><%StringHelper.filterHTML(out, viewTransfer.userName);%></a></span> <span class="fr f14"><a href="#" class="blue">债权转让及受让协议（范本）</a></span></div>
              <div class="hsxt"></div>
              <div class="plan_given clearfix">
                <ul class="cend w490 fl clearfix">
                  <li><div>剩余期限：<%=viewTransfer.residueDeadline %>/<%=viewTransfer.loanDeadline %>个月</div><div>转让价格：<span class="f18 gray3"><%=Formater.formatAmount(viewTransfer.transferPrice) %></span>元</div></li>
                  <li><div>下一还款日：<%=TimestampParser.format(viewTransfer.refundDay) %></div><div>债权价值：<span class="f18 gray3"><%=viewTransfer.residueValue %></span>元</div></li>
                  <li class="mb10"><div>原始投标金额：<%=Formater.formatAmount(viewTransfer.tenderMoney) %>元</div></li>
                  <div class="li30 f16 gray3">原始借款标的详情</div>
                  <li><div>借款用户：<%StringHelper.filterHTML(out, viewTransfer.userName);%> </div><div>借款期限：<%=viewTransfer.loanDeadline %>个月</div></li>
                  <li><div>年利率：<%=Formater.formatRate(viewTransfer.yearRate) %> </div><div>还款方式：<%=viewTransfer.repaymentType.getChineseName() %></div></li>
                  <li><div>保障方式：<%=viewTransfer.safeguardWay.getChineseName() %></div><div>提前还款费率：<%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.FANACING_PREPAYMENT_RATES))*100%>%</div></li>
                  <li><div>借款金额：<%=Formater.formatAmount(viewTransfer.repaymentMoney) %>元</div></li>
                </ul>
                <div class="fr submission mt15">
                    <div class="text">
                      <ul class="text_li">
                      <li>购买总需：<span class="f18 gray3"><%=Formater.formatAmount(viewTransfer.gmzx) %></span>元</li>
                      </ul>
                     </div>
                </div>
              </div>
            </div>
            <div class="clear"></div>
          </div>
        </div>
           	  <div class="newsbox">
           	    <div class="til clearfix">
           	      <div class="Menubox">
           	        <ul>
           	          <li id="one1" class="hover" >借款详情</li>
           	          <li id="one2" onclick="window.location.href='<%=controller.getURI(request, ViewTenderRecord.class)%>?transferId=<%=viewTransfer.id%>'" >投资记录</li>
           	          <li id="one3" onclick="window.location.href='<%=controller.getURI(request, ViewRefundRecord.class)%>?transferId=<%=viewTransfer.id%>'" >还款计划</li>
           	          <li id="one4" onclick="window.location.href='<%=controller.getURI(request, ViewCreditor.class)%>?transferId=<%=viewTransfer.id%>'" >债权信息</li>
           	          <li id="one5" onclick="window.location.href='<%=controller.getURI(request, ViewTransferRecord.class)%>?transferId=<%=viewTransfer.id%>'" style="border-right:1px #d7dfe3 solid;" >转让记录</li>
       	            </ul>
       	          </div>
       	        </div>
           	    <div class="border p15-30 Men_bt no_table" id="con_one_1">
           	      <div class="pub_title pt15 f16 fB"><span class="fl">用户信息</span><span class="ml30 f14 gray33">ID:<%=viewLoanRecord.userId %></span></div>
           	      <div class="hsxt" style="margin-bottom:0"></div>
           	      <div class="plan_tab_con clearfix">
           	        <table width="100%" border="0" cellspacing="0">
           	          <tr>
           	            <td><span class=" dian"></span>用户名：</td>
           	            <td><span class="fl"><%StringHelper.filterHTML(out, viewTransfer.userName);%></span><%if(viewLoanRecord.sex!=null){if(viewLoanRecord.sex.equals(Sex.M)){ %><i class="ui_plan_bj ui_boy ml10 mt5"></i><%}else{ %><i class="ui_plan_bj ui_girl ml10 mt5"></i><%}} %></td>
           	            <td><span class=" dian"></span>公司行业：</td>
           	            <td><%StringHelper.filterHTML(out, viewLoanRecord.companyBusiness);%></td>
       	              </tr>
           	          <tr>
           	            <td><span class=" dian"></span>年&nbsp;&nbsp;&nbsp;&nbsp;龄：</td>
           	            <td><%=viewLoanRecord.age %></td>
           	            <td><span class=" dian"></span>公司规模：</td>
           	            <td><%StringHelper.filterHTML(out, viewLoanRecord.companyScale);%>人</td>
       	              </tr>
           	          <tr>
           	            <td><span class=" dian"></span>工作城市：</td>
           	            <td><%StringHelper.filterHTML(out, viewLoanRecord.workCity);%></td>
           	            <td><span class=" dian"></span>岗位职责：</td>
           	            <td><%StringHelper.filterHTML(out, viewLoanRecord.position);%></td>
       	              </tr>
           	          <tr>
           	            <td><span class=" dian"></span>学&nbsp;&nbsp;&nbsp;&nbsp;校：</td>
           	            <td><%StringHelper.filterHTML(out, viewLoanRecord.graduateSchool);%></td>
       	              </tr>
       	            </table>
       	          </div>
           	      <div class="pub_title pt15"><span class="fl f16 fB">审核状态</span></div>
           	      <div class="clear"></div>
           	      <div class="plan_tab_con01 clearfix">
           	        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table mt10">
           	          <tr class="hsbg">
           	            <td><span class="ml100">审核项目</span></td>
           	            <td align="center" class="w50">状态</td>
           	            <td align="center">通过日期</td>
       	              </tr>
       	              <%if (attestationChecks != null) {for (int i = 0;i < attestationChecks.length;i++) {AttestationCheck attestationCheck = attestationChecks[i];if (attestationCheck == null) {continue;}%>
           	          <tr>
           	            <td><span class="ml100"><%StringHelper.filterHTML(out, attestationCheck.shxm); %></span></td>
           	            <td align="center"><i class="ui_plan_bj ui_plan_right tl ml20"></i></td>
           	            <td align="center"><%=TimestampParser.format(attestationCheck.rzsj) %></td>
       	              </tr>
           	          <%}} %>
       	            </table>
           	        <p class="pt10 li30"><span class=" dian"></span><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，<br />
           	          但不保证审核信息100%无误。<br />
           	          <span class=" dian"></span>借入者若长期逾期，其个人信息将被公布。</p>
       	          </div>
           	      <div class="pub_title pt15 f16 fB">借款描述</div>
           	      <div class="hsxt"></div>
           	      <div class="plan_tab_con01 mb20 li30"><%StringHelper.filterHTML(out, viewTransfer.jkms);%></div>
           	      <div class="clear"></div>
       	        </div>
           	    <div class="clear"></div>
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