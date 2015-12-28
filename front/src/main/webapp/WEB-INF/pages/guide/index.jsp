<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>新手指引</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
        <!--banner-->
<div class="zq_banner">
<div class="banner3"></div>
</div>
<!--banner-->
	<div class="contain clearfix">
	  <%--
		<div class="lead" style="display:none;">
			<%
				CURRENT_SUB_CATEGORY = "XSZY";
			%>
			<%@include file="/WEB-INF/include/xszy/left.jsp"%>
			<%
				ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
				PagingResult<T5011> result = articleManage.search(T5011_F02.XSZY,new Paging(){public int getCurrentPage(){return 1;}public int getSize(){return 5;}});
				T5011[] articles = result.getItems();
			%>
			<%if(articles!=null&&articles.length>0){%>
				<%if(articles.length==1){%>
					<div class="fr clearfix container">
					<div class="pub_title clearfix"><%StringHelper.filterHTML(out,articles[0].F06);%></div>
					<div id="nav" class="clearfix">
			        <%StringHelper.format(out, articleManage.getContent(articles[0].F01), fileStore);articleManage.view(articles[0].F01);%>
			        </div>
			        </div>
				<%}else{%>
					<div class="fr clearfix ">
						<div class="lead_tab clearfix ">
				             <ul>
				             	<%for(int i=0,idx=1,max=articles.length+1;i<articles.length;i++,idx++){%>
				                <li id="one<%=idx %>" onclick="setTab('one',<%=idx %>,<%=max %>)" <%if(i==0){%>class="hover"<%}%>><%StringHelper.filterHTML(out, articles[i].F06); %></li>
				                <%}%>
				                <li style="border-left:1px solid #d1dfea;padding:0;"></li>
				             </ul>
				         </div>
			         	<%for(int i=0;i<articles.length;i++){%>
				         <div class="container clearfix" id="con_one_<%=i+1%>" <%if(i>0){%>style="display:none;"<%}%>>
				         <%StringHelper.format(out, articleManage.getContent(articles[i].F01), fileStore);articleManage.view(articles[i].F01);%>
				         </div>
		        		<%}%>
		         	</div>
				<%}%>
			<%}else{%>
				<div class="fr clearfix container">
				<div class="pub_title clearfix">新手指导</div>
				<div class="clearfix">善行创投是目前中国互联网金融中P2P信贷行业的最具个性化企业，是一个以个人对个人借贷为主要产品，为借贷两端搭建的公平、高校、个性定制、透明、安全的互联网金融服务平台。借款用户可以在善行创投上获得发布借款请求来实现个人快捷的融资需要；理财用户可以把自己的部分闲余资金通过善行创投平台出借给有抵押标的却又有资金需求的个人，在获得有保障，高收益的理财回报的同时帮助了优质的借款人，并且善行创投准备了高额保障资金，保障投资者的资金安全。
                  <div class="sx_rookie_box">
                  <h1>人人都是投资家</h1>
                  <h2>四步走完，轻松赚取收益</h2><br/>
                  <ul class="sx_rookie_list">
                     <li><span class="sx_rookie1"></span><h3>第一步</h3><p>完成注册成为善行创投用户，完成身份认证</p></li>
                     <li class="sx_rookie_right"><span class="sx_rookie2"></span><h3>第二步</h3><p>选择投资标</p></li>
                     <li><span class="sx_rookie3"></span><h3>第三步</h3><p>账户充值，参与投标</p></li>
                     <li class="sx_rookie_right"><span class="sx_rookie4"></span><h3>第四步</h3><p>投标支付完成</p></li>
                  </ul><br /><br />
                  <div class="clear"></div>
                  <h1>轻松借款，So easy</h1>
                  <br/>
                  <ul class="sx_rookie_list">
                     <li><span class="sx_rookie5"></span><h3>第一步</h3><p>浏览我要借款页面，填写借款人信息，1小时内将接到客服对接电话</p></li>
                     <li class="sx_rookie_right"><span class="sx_rookie6"></span><h3>第二步</h3><p>注册登录善行创投</p></li>
                     <li><span class="sx_rookie7"></span><h3>第三步</h3><p>上传必要申请材料，提交抵押的标</p></li>
                     <li class="sx_rookie_right"><span class="sx_rookie8"></span><h3>第四步</h3><p>通过审核后开始筹标</p></li>
                  </ul>
                  <div class="clear"></div>
                  </div>
		        </div>
		        </div>
			<%}%>
            
		</div>
	   --%>
	</div>
    <!--------新手指引-------->
<div class="sx_rookie">
   <div class="sx_rookie_block1">
      <h1 class="sx_t1">什么是善行创投？</h1>
      <p>当投资邂逅融资，带来前所未有的投资体验！</p>
   </div>
   <div class="sx_rookie_block2">
       <img src="/images/sx_newguied.jpg" alt="" />
   </div>
   
  <div class="sx_rookie_block3">
   <div class="sx_intro_advantage">
      <ul>
        <li>
           <span class="it1"></span>
           <h2>年化收益率8%-15%</h2>
           <p><b>40</b>倍银行存款利息，<br /><b>100</b>元起步</p>
        </li>
        <li class="sx_advantage_middle">
           <span class="it2"></span>
           <h2>最安全的网上理财</h2>
           <p><b>7道</b>独创审核体系，<br /><b>100%本息保障</b></p>
        </li>
        <li>
           <span class="it3"></span>
           <h2>随时随地赎回投资</h2>
           <p>突然急用钱想收回投资？<br />最快<b>当天到账</b></p>
        </li>
      </ul>
      <div class="clear"></div>
    </div>
  </div>
   
  <div class="sx_rookie_block4">
   <div class="sx_rookie_channels">
       <ul>
          <li>
             <h2>新手投资</h2>
             <p class="sx_baseMoney"><b>100元起</b></p>
             <h3>项目</h3>
             <p>1.周期短</p>
             <p>2.门槛低</p>
          </li>
          <li class="sx_rookie_channels_middle">
             <h2>资深投资</h2>
             <p class="sx_baseMoney"><b>500元起</b></p>
             <h3>项目</h3>
             <p>1.丰富多种</p>
             <p>2.自由投资</p>
          </li>
          <li>
             <h2>VIP投资</h2>
             <p class="sx_baseMoney"><b>50,000元起</b></p>
             <h3>项目</h3>
             <p>1.金额大</p>
             <p>2.独享VIP投资</p>
          </li>
       </ul>
       <div class="clear"></div>
    </div>
  </div>
  
  <div class="sx_rookie_block5">
     <div class="sx_rookie_qbox">
        <h1>什么是新手投资？</h1>
        <p>新手投资是从资深投资的项目中抽取出来，专门为首次投资者定制的专区，让其享受低门槛也能高收益的乐趣。</p>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_rookie_tab">
          <tr>
            <td width="7%"><span>面向对象：</span></td>
            <td width="42%">首次投资者或新注册用户以及对P2P行业不了解的会员</td>
            <td width="2%">&nbsp;</td>
            <td width="7%"></td>
            <td width="40%">&nbsp;</td>
          </tr>
          <tr>
            <td><span>起投金额：</span></td>
            <td>100元</td>
            <td>&nbsp;</td>
            <td><span>&nbsp;&nbsp;&nbsp;周期短：</span></td>
            <td>不长于6个月</td>
          </tr>
          <tr>
            <td><span>保障级别：</span></td>
            <td>本息有保障</td>
            <td>&nbsp;</td>
            <td><span>投资上限：</span></td>
            <td>每标一万</td>
          </tr>
          <tr>
            <td><span>投资期限：</span></td>
            <td>标的的贷款期限</td>
            <td>&nbsp;</td>
            <td><span>会员特权：</span></td>
            <td>专业投资理财客服指导您学习如何投资。</td>
          </tr>
          <tr>
            <td><span>退出机制：</span></td>
            <td>到期客户可选择继续投资或通过债权转让退出。</td>
            <td>&nbsp;</td>
            <td></td>
            <td>&nbsp;</td>
          </tr>
        </table>
     </div>
     <div class="sx_rookie_qbox">
        <h1>什么是资深投资？</h1>
        <p>资深投资是对已经在善行创投平台上投资或对P2P有一定了解的会员，已注册用户可随时加入资深投资。</p>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_rookie_tab">
          <tr>
            <td width="7%"><span>面向对象：</span></td>
            <td width="42%">对P2P有一定了解的会员</td>
            <td width="2%">&nbsp;</td>
            <td width="7%"></td>
            <td width="40%">&nbsp;</td>
          </tr>
          <tr>
            <td><span>起投金额：</span></td>
            <td>500元</td>
            <td>&nbsp;</td>
            <td><span>&nbsp;&nbsp;&nbsp;周期短：</span></td>
            <td>最长24个月</td>
          </tr>
          <tr>
            <td><span>保障级别：</span></td>
            <td>本息有保障</td>
            <td>&nbsp;</td>
            <td><span>投资上限：</span></td>
            <td>无上限</td>
          </tr>
          <tr>
            <td><span>投资期限：</span></td>
            <td>标的的贷款期限</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td><span>会员特权：</span></td>
            <td>可以参与平台大部分投资标的投资；享用自动投标专权；有机会参与善林投资酒会；有专业投资理财顾问提供咨询。</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td><span>退出机制：</span></td>
            <td>到期客户可选择继续投资或通过债权转让退出。</td>
            <td>&nbsp;</td>
            <td></td>
            <td>&nbsp;</td>
          </tr>
        </table>
     </div>
     <div class="sx_rookie_qbox">
        <h1>什么是VIP投资？</h1>
        <p>VIP投资是是拥有诸多特权的投资人，成为VIP可以享受专人服务，为其定推项目标的及预约标的提醒，在平台投资总额超过20万可成为VIP，已注册用户可随时申请加入VIP投资，申请费用为100元。</p>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_rookie_tab">
          <tr>
            <td width="7%"><span>面向对象：</span></td>
            <td width="42%">具有一定资金实力的会员以及需要专人服务的百忙投资人</td>
            <td width="2%">&nbsp;</td>
            <td width="7%"></td>
            <td width="40%">&nbsp;</td>
          </tr>
          <tr>
            <td><span>起投金额：</span></td>
            <td>50000元</td>
            <td>&nbsp;</td>
            <td><span>&nbsp;&nbsp;&nbsp;周期短：</span></td>
            <td>最长24个月</td>
          </tr>
          <tr>
            <td><span>保障级别：</span></td>
            <td>本息有保障</td>
            <td>&nbsp;</td>
            <td><span>投资上限：</span></td>
            <td>无上限</td>
          </tr>
          <tr>
            <td><span>投资期限：</span></td>
            <td>标的的贷款期限</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td><span>会员特权：</span></td>
            <td>有机会参与平台重大投资；可优先预约标；可优先转让债权；配套客户经理；享用自动投标专权；专享理财顾问。</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td><span>退出机制：</span></td>
            <td>到期客户可选择继续投资或通过债权转让退出。</td>
            <td>&nbsp;</td>
            <td></td>
            <td>&nbsp;</td>
          </tr>
        </table>
     </div>
  </div>
  <div class="sx_rookie_block6">
  <h1 class="sx_t1">如何投资？</h1>
  <div class="sx_rookie_box">
                  <h1>人人都是投资家</h1>
                  <h2>四步走完，轻松赚取收益</h2><br/>
                  <ul class="sx_rookie_list">
                     <li><span class="sx_rookie1"></span><h3>第一步</h3><p>完成注册成为善行创投用户，完成身份认证</p></li>
                     <li class="sx_rookie_right"><span class="sx_rookie2"></span><h3>第二步</h3><p>选择投资标</p></li>
                     <li><span class="sx_rookie3"></span><h3>第三步</h3><p>账户充值，参与投标</p></li>
                     <li class="sx_rookie_right"><span class="sx_rookie4"></span><h3>第四步</h3><p>投标支付完成</p></li>
                  </ul><br /><br />
                  <div class="clear"></div>
       <h4 class="sx_rookie_orangeText">最后注册投资看看吧</h4>
        <p><a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="sx_rookie_regBt">立即注册</a></p>
    </div>
    </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>