<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.TransferRecordInfo"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.TransferRecord"%>
<%@page import="com.dimeng.p2p.modules.financial.console.service.entity.ViewTransfer"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewLoan"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewTransferRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewCreditor"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewRefundRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl.ViewTenderRecord"%>
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
	TransferRecord transferRecord = (TransferRecord)request.getAttribute("transferRecord");
	TransferRecordInfo[] transferRecordInfos = transferRecord.refundInfos;
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
           	          <li id="one1" onclick="window.location.href='<%=controller.getURI(request, ViewLoan.class)%>?transferId=<%=viewTransfer.id%>'" >借款详情</li>
           	          <li id="one2" onclick="window.location.href='<%=controller.getURI(request, ViewTenderRecord.class)%>?transferId=<%=viewTransfer.id%>'" >投资记录</li>
           	          <li id="one3" onclick="window.location.href='<%=controller.getURI(request, ViewRefundRecord.class)%>?transferId=<%=viewTransfer.id%>'" >还款计划</li>
           	          <li id="one4" onclick="window.location.href='<%=controller.getURI(request, ViewCreditor.class)%>?transferId=<%=viewTransfer.id%>'" >债权信息</li>
           	          <li id="one5"  class="hover" style="border-right:1px #d7dfe3 solid;" >转让记录</li>
       	            </ul>
       	          </div>
       	        </div>
           	    <div class="border p15-30 Men_bt no_table" id="con_one_5">
           	      <div class="fr mb10"> <span class="mr10">交易总金额<em class="f18 orange"><%=transferRecord.totalDealMoney %></em></span></div>
           	      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table tc mb15">
                      <tr class="hsbg">
                        <td>债权买入者</td>
                        <td>债权买出者</td>
                        <td>交易金额</td>
                        <td>交易时间</td>
                      </tr>
                      <%if (transferRecordInfos != null) {for (int i = 0;i < transferRecordInfos.length;i++) {TransferRecordInfo transferRecordInfo = transferRecordInfos[i];if (transferRecordInfo == null) {continue;}%>
                      <tr>
                        <td><%StringHelper.filterHTML(out, transferRecordInfo.transferCome); %></td>
                        <td><%StringHelper.filterHTML(out, transferRecordInfo.transferOut); %></td>
                        <td><%=Formater.formatAmount(transferRecordInfo.dealMoney) %></td>
                        <td><%=TimestampParser.format(transferRecordInfo.dealTime) %></td>
                      </tr>
                      <%}} %>     
              	 	  </table>
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