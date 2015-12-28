<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.AssetsInfo"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.WdzqManage"%>
<div class="container fr mb15 bor1">
<%!static final String SORT="s";%>
     <%
     	WdzqManage service=serviceSession.getService(WdzqManage.class);
     	AssetsInfo ai= service.getAssetsInfo();
    	final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
    	Paging paging=new Paging(){
    		public int getCurrentPage(){
    			return currentPage;
    		}
    		
    		public int getSize(){
    			return 10;
    		}
    	};
     	if(ai != null){
     %>
   		  <div class="user_bgls fl">
            	<div class="mt20 ml20">
                <p><span class="f20 fl">投资已赚金额</span>
                <a href="javascript:void(0)" class="tx_an1" id="wdzq1"></a></p>
                       <div class="pop-con" style="margin-left:170px;display: none;" id="wdzqyz1">
                       <div class="fl pop-pic"></div>
                       <div class="pop-info">投资已赚金额=投资已赚利息罚息及违约金+债权转让盈亏</div>
                       </div>
                       <div class="clear"></div>
                <span class="red"><%=ai.makeMoney %>元</span><br />
                <p><span class="mr5 fl">利息收益</span><a href="javascript:void(0)" class="tx_an1" id="wdzq2"></a><%=ai.accMakeMoney %>元</p>
               			<div class="pop-con" style="margin-left:110px;margin-top:-53px;display: none;" id="wdzqyz2">
                       <div class="fl pop-pic"></div>
                       <div class="pop-info">利息收益=投资已赚利息罚息+违约金</div>
                       </div>
                       <div class="clear"></div>
                <p><span class="mr15">债权转让盈亏</span>  <%=ai.sellMakeMoney %>元</p>
                </div>
      	</div>
            <div class="hzcx_st fl"></div>
            <div class="fl">
            <ul class="zqjl pl40 bom">
            <li>投资账户资产<br><%=ai.money %>元</li>
            <li>回收中的投资数量<br><%=ai.assetsNum %>个</li>
            </ul>
            <ul class="pl40 pt20">
            <li>没时间亲自投标？试试<%configureProvider.format(out,SystemVariable.SITE_NAME); %>自动投标功能吧。<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.zdtb.Index.class)%>" class="btn01 fr mr40" style="cursor: pointer;">自动投标</a></li>
            </ul>
         </div>
     <%
     	}else{
     %>
     	<div class="user_bgls fl">
            	<div class="mt20 ml40">
                <p><span class="f20 fl">投资已赚金额</span>
                <a href="javascript:void(0)" class="tx_an1" id="wdzq1"></a></p>
                       <div class="pop-con" style="margin-left:170px;display: none;" id="wdzqyz1">
                       <div class="fl pop-pic"></div>
                       <div class="pop-info">投资已赚金额=投资已赚利息罚息及违约金+债权转让盈亏</div>
                       </div>
                <span class="red">0元</span><br />
                <p><span class="mr5 fl">利息收益</span><a href="javascript:void(0)" class="tx_an1" id="wdzq2"></a>0元</p>
               			<div class="pop-con" style="margin-left:110px;margin-top:-53px;display: none;" id="wdzqyz2">
                       <div class="fl pop-pic"></div>
                       <div class="pop-info">利息收益=投资已赚利息罚息+违约金</div>
                       </div>
                       <div class="clear"></div>
                <p><span class="mr15">债权转让盈亏</span>  0元</p>
                </div>
      </div>
            <div class="hzcx_st fl"></div>
            <div class="fl">
            <ul class="zqjl pl40 bom">
            <li>投资账户资产<br>0元</li>
            <li>回收中的投资数量<br>0个</li>
            </ul>
            <ul class="pl40 pt20">
            <li>没时间亲自投标？试试<%configureProvider.format(out,SystemVariable.SITE_NAME); %>自动投标功能吧。<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.zdtb.Index.class)%>" class="btn01 fr mr40" style="cursor: pointer;">自动投标</a></li>
            </ul>
         </div>
     <%
     	}
     %>
       </div>