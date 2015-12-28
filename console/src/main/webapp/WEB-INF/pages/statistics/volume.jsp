<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.statistics.VolumeExport"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.VolumeRegion"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.VolumeTimeLimit"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.VolumeType"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.Profile"%>
<%@page import="com.dimeng.p2p.console.servlets.statistics.Volume"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.VolumeManage"%>
<%@page import="com.dimeng.p2p.modules.statistics.console.service.entity.VolumeEntity"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
int year = IntegerParser.parse(request.getParameter("year"));
if(year <= 0){
	Calendar calendar = Calendar.getInstance();
	year = calendar.get(Calendar.YEAR);
}
VolumeManage manage = serviceSession.getService(VolumeManage.class);
VolumeEntity[] vEntities = manage.getVolumeEntities(year);
VolumeEntity[] lvEntities = manage.getLastYearVolumeEntities(year);
Profile profile = manage.getProfile(year);
VolumeType[] volumeTypes = manage.getVolumeTypes(year);
VolumeTimeLimit[] volumeTimeLimits = manage.getVolumeTimeLimits(year);
VolumeRegion[] volumeRegions = manage.getVolumeRegions(year);

int[] options = manage.getStatisticedYear();

CURRENT_CATEGORY = "TJGL";
CURRENT_SUB_CATEGORY = "CJSJTJ";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
	<div class="main clearfix">
	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>成交数据统计</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, Volume.class)%>" method="post">
                    <div class="table">
                    <span>年份：</span>
                    <span>
                    	<select name="year" class="yhgl_sel yw_w1">
                    		<%if(options!=null && options.length>0){
                    			for(int option : options){
                    		%>
                    			<option value="<%=option %>" <%=year==option?"selected=\"selected\"":"" %>><%=option %>年</option>
                    		<%}}else{ %>
                    			<option><%=year %>年</option>
                    		<%} %>
                    	</select>
                    </span>
                     <div class="clear"></div>   
                    <div class="mt10">   
                    	<input name="input" type="submit" class="btn2 mr10" value="搜索" />
                   		<%if(dimengSession.isAccessableResource(VolumeExport.class)){ %>
                    		<a href="<%=controller.getURI(request, VolumeExport.class) %>?year=<%=year %>" class="btn3"><span class="ico"></span>导出</a>
                 		<%} else {%>
						 <a href="javascript:void(0)" class="btn3 mr10 btn5"><span class="ico"></span>导出</a>
						<%} %>
                   </div>               
                    </div>                    	 
                    </form>                    
                    <div class="clear"></div>                    
                  </div>
                </div>
                <div class="box box1 mb15">
                  <div class="con">
                    <div class="f16 fB"><%=year %>年成交金额同比增长柱形图</div>
                    <div class="hsxt"></div>
                    <div>
                      <p class="fl"><%=year %>年成交总额<span class="blue"><%=Formater.formatAmount(profile.totalAmount) %></span>元
                      <%if(profile.amountRate != null && profile.amountRate.floatValue()>1){ %>
                      	，同比增长<span class="blue"><%=(profile.amountRate.setScale(3).floatValue()-1)*100 %>%</span>
                      <%}else if(profile.amountRate != null && profile.amountRate.floatValue()<1){ %>
                      	，同比下降<span class="blue"><%=(1-profile.amountRate.setScale(3).floatValue())*100 %>%</span>
                      <%} %>
                      </p>
                    </div>
                    <div class="clear"></div>
                    <div class="tc mb30">
                    	<div id="column1" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                    </div>
                    <div class="f16 fB"><%=year %>年成交笔数同比增长柱形图</div>
                    <div class="hsxt"></div>
                    <div>
                      <p class="fl"><%=year %>年成交笔数<span class="blue"><%=profile.totalAmount==null?0:profile.totalCount.intValue() %></span>笔
                      <%if(profile.countRate != null && profile.countRate.floatValue()>1){ %>
                      	，同比增长<span class="blue"><%=(profile.countRate.setScale(3).floatValue()-1)*100 %>%</span>
                      <%}else if(profile.countRate != null && profile.countRate.floatValue()<1){ %>
                      	，同比下降<span class="blue"><%=(1-profile.countRate.setScale(3).floatValue())*100 %>%</span>
                      <%} %>
                      </p>
                    </div>
                    <div class="clear"></div>
                    <div class="tc mb30">
                    	<div id="column2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                    </div>
                    <div class="f16 fB"><%=year %>年借款数据统计-按产品类型</div>
                    <div class="hsxt"></div>
                    <div class="mb30">
                  	<div class="w40 fr">
                       	<div id="pie1" style="min-width: 360px; height: 300px; margin: 0 auto"></div>
                    </div>
                        <div class="w56 fl">
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>类型</td>
                          <td>笔数</td>
                          <td>金额（元）</td>
                          </tr>
                        <%for(int i=0; i<3; i++){ %>
	                      <tr class="dhsbg">
	                          <td><%=volumeTypes[i].type.getName() %></td>
	                          <td><%=volumeTypes[i].count %></td>
	                          <td><%=Formater.formatAmount(volumeTypes[i].amount) %></td>
                          </tr>
                          <%} %>
                          <tr>
                          	 <td>总计</td>
                          	 <td><%=volumeTypes[3].count %></td>
                          	 <td><%=Formater.formatAmount(volumeTypes[3].amount) %></td>
                          </tr>
                        </table>
                        </div>
                    <div class="clear"></div>
                    </div>
                    <div class="f16 fB"><%=year %>年借款数据统计-按期限</div>
                    <div class="hsxt"></div>
                    <div class="mb30 mt40">
                        <div class="w40 fr" style="position:relative">
                        	<div id="pie2" style="min-width: 360px; height: 300px; margin: 0 auto"></div>
                        </div>
                        <div class="w56 fl">
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>期限（月）</td>
                          <td>笔数</td>
                          <td>金额（元）</td>
                          </tr>
                        <tr class="dhsbg">
                          <td>1-3</td>
                          <td><%=volumeTimeLimits[0].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[0].amount) %></td>
                        </tr>
                        <tr class="dhsbg">
                          <td>4-6</td>
                          <td><%=volumeTimeLimits[1].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[1].amount) %></td>
                          </tr>
                        <tr class="dhsbg">
                          <td>7-9</td>
                          <td><%=volumeTimeLimits[2].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[2].amount) %></td>
                        </tr>
                        <tr class="dhsbg">
                          <td>10-12</td>
                          <td><%=volumeTimeLimits[3].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[3].amount) %></td>
                        </tr>
                        <tr class="dhsbg">
                          <td>13-15</td>
                          <td><%=volumeTimeLimits[4].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[4].amount) %></td>
                        </tr>
                        <tr class="dhsbg">
                          <td>16-18</td>
                          <td><%=volumeTimeLimits[5].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[5].amount) %></td>
                        </tr>
                        <tr class="dhsbg">
                          <td>19-24</td>
                          <td><%=volumeTimeLimits[6].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[6].amount) %></td>
                        </tr>
                         <tr class="dhsbg">
                          <td>25-36</td>
                          <td><%=volumeTimeLimits[7].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[7].amount) %></td>
                        </tr>
						<tr class="dhsbg">
                          <td>总计</td>
                          <td><%=volumeTimeLimits[8].count %></td>
                          <td><%=Formater.formatAmount(volumeTimeLimits[8].amount) %></td>
                        </tr>
                        </table>
                        </div>
                    <div class="clear"></div>
                    </div>
                    <div class="f16 fB"><%=year %>年借款数据统计-按地域</div>
                    <div class="hsxt"></div>
                    <div class="mb30 mt40">
                        <div class="w40 fr">
                        	<%if(volumeTimeLimits.length>0){ %>
                           <div id="pie3" style="min-width: 360px; height: 300px; margin: 0 auto"></div>
                           <%} %>
                        </div>
                        <div class="w56 fl">
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>地域</td>
                          <td>笔数</td>
                          <td>金额（元）</td>
                          </tr>
                          <%for(VolumeRegion volumeRegion : volumeRegions){ %>
	                       <tr class="dhsbg">
	                          <td><%=volumeRegion.province %></td>
	                          <td><%=volumeRegion.count %></td>
	                          <td><%=Formater.formatAmount(volumeRegion.amount) %></td>
                          </tr>
                          <%} %>
                        </table>
                        </div>
                    <div class="clear"></div>
                    </div>
                  </div>
                </div>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
	<%@include file="/WEB-INF/include/left.jsp" %>
	</div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<script type="text/javascript">
    var y = <%=year %>;
	var columnData1 = [0,0,0,0,0,0,0,0,0,0,0,0];
	var lastData1 = [0,0,0,0,0,0,0,0,0,0,0,0];
	var columnData2 = [0,0,0,0,0,0,0,0,0,0,0,0];
	var lastData2 = [0,0,0,0,0,0,0,0,0,0,0,0];
	<%for(VolumeEntity entity : vEntities){%>
		columnData1[<%=entity.month-1%>] = <%=entity.amount%>;
		columnData2[<%=entity.month-1%>] = <%=entity.count%>;
	<%}%>
	<%for(VolumeEntity entity : lvEntities){%>
		lastData1[<%=entity.month-1%>] = <%=entity.amount%>;
		lastData2[<%=entity.month-1%>] = <%=entity.count%>;
	<%}%>
	var data1 = [
	 			<%for(int i=0; i<3; i++){if(0 == i){%>
	 				['<%=volumeTypes[i].type.getName() %>', <%=volumeTypes[i].amount %>]
	 			<%}else{%>
	 				,['<%=volumeTypes[i].type.getName() %>', <%=volumeTypes[i].amount %>]
	 			<%}}%>
	         ];
	var data2 = [['1-3个月', <%=volumeTimeLimits[0].amount %>],
	             ['4-6个月', <%=volumeTimeLimits[1].amount %>],
	             ['7-9个月', <%=volumeTimeLimits[2].amount %>],
	             ['10-12个月', <%=volumeTimeLimits[3].amount %>],
	             ['13-15个月', <%=volumeTimeLimits[4].amount %>],
	             ['16-18个月', <%=volumeTimeLimits[5].amount %>],
	             ['19-24个月', <%=volumeTimeLimits[6].amount %>],
	             ['25-36个月', <%=volumeTimeLimits[7].amount %>]];
	<%if(volumeTimeLimits.length > 0){ %>
	var data3 = [
             <%int m =0; for(VolumeRegion volumeRegion : volumeRegions){if(0 == m){%>
             	['<%=volumeRegion.province %>', <%=volumeRegion.amount %>]
             <%}else{%>
             	,['<%=volumeRegion.province %>', <%=volumeRegion.amount %>]
             <%}m++;}%>
             ];
	<%}%>
</script>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/volume.js"></script>
</body>
</html>