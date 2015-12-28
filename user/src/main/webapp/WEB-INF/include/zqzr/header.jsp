<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.SellFinacingInfo"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.ZqzrManage"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Zqzrz"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Zqyzr"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Zqyzc"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zqzr.Zqkzc"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
  <%
	final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
  	ZqzrManage service=serviceSession.getService(ZqzrManage.class);
	Paging paging=new Paging(){
		public int getCurrentPage(){
			return currentPage;
		}
		
		public int getSize(){
			return 10;
		}
	};
%>
 <div class="container fr mb15 bor1">
     	<%
	     	SellFinacingInfo bfInfo=service.getSellFinacingInfo();
	      	if(bfInfo != null){
        %>
   		  <div class="user_bgls fl">
            	<div class="mt40 ml40">
                <div class="f20"><span class="fl">债权转让盈亏</span><a href="javascript:void(0)" class="tx_an1" ></a></div>
                	 <div class="pop-con" style="margin-left:165px; display: none;" >
                          <div class="fl pop-pic"></div>
                          <div class="pop-info">债权转让盈亏=债权折溢价交易盈亏-债权交易费用</div>
                     </div>
                <br />
                <div class="clear"></div> 
                <div class="red"><%=bfInfo.money %>元</div><br />
               
                </div>
      		</div>
            <div class="hzcx_st fl"></div>
            <div class="fl">
            <ul class="zqjl pl40 bom">
            <li>成功转入金额<br><%=bfInfo.inMoney %>元</li>
            <li>债权转入盈亏<br><%=bfInfo.inAssetsMoney %>元</li>
            <li>已转入债权笔数<br><%=bfInfo.inNum %>笔</li>
            </ul>
            <ul class="zqjl pl40">
            <li>成功转出金额<br><%=bfInfo.outMoney %>元</li>
            <li>债权转出盈亏<br><%=bfInfo.outAssetsMoney %>元</li>
            <li>已转出债权笔数<br><%=bfInfo.outNum %>笔</li>
            </ul>
         </div>
         <%}else{
         %>
         <div class="user_bgls fl">
            	<div class="mt40 ml40">
                
                 <div class="f20"><span class="fl">债权转让盈亏</span><a href="javascript:void(0)" class="tx_an1"></a></div>
                           <div class="pop-con" style="margin-left:165px;display: none;">
                           <div class="fl pop-pic"></div>
                           <div class="pop-info">债权转让盈亏=债权折溢价交易盈亏-债权交易费用</div>
                           </div>
                           <br />   
                           <div class="clear"></div>                       
                <div class="red">0元</div> 
               
                </div>
      		</div>
            <div class="hzcx_st fl"></div>
            <div class="fl">
            <ul class="zqjl pl40 bom">
            <li>成功转入金额<br>0元</li>
            <li>债权转入盈亏<br>0元</li>
            <li>已转入债权笔数<br>0笔</li>
            </ul>
            <ul class="zqjl pl40">
            <li>成功转出金额<br>0元</li>
            <li>债权转出盈亏<br>0元</li>
            <li>已转出债权笔数<br>0笔</li>
            </ul>
         </div>
         <%
         }
         %>
       </div>     
     
