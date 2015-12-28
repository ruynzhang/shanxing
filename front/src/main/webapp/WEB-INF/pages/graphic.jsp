<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.AreasMapentity"%>
<%@page import="com.dimeng.p2p.JsonMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.EnStaticData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看统计数据</title>
    <link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
    <style>
    body{ font: 14px Microsoft YaHei, Helvetica, Tahoma;color: #475058;overflow-x:hidden}
    ul li{list-style:none;}
    #dateTime,#mapTime,#ratioTime{
    color: #b2b5b7;
    margin-top: -15px;
    float: right;

    }
    .tc_left {
    position: absolute;
    float: left;
    overflow: hidden;
    box-sizing: border-box;
    margin: -430px 0 0 2%;
    width: 380px;
    display: inline;

    }
   .tc_left ul li {
    margin-top: 5px;
    overflow: hidden;
    zoom: 1;
    }
    .tc_left ul li .sort {
    width: 24px;
    height: 20px;
    font-size: 13px;
    display: inline-block;
    text-align: center;
    }
    .tc_left ul li .province {
    margin-left: 20px;
    }
    .tc_left ul li .sortbg {
    color: #fff;
    font-size: 13px;
    line-height: 24px;
    background: url("/images/sortbg.png") no-repeat center center;
    }
    .tc_left ul li .sum {
    float: right;
    text-align: right;
    display: inline-block;
    }
    .tc_left ul .tcl_fgx {
    width: 100%;
    border-bottom: 1px solid #e7ecee;
    padding: 0 0 7px 0;
    margin-bottom: 7px;
    box-sizing: border-box;
    margin-top: 0;
    display: inline-block;
    }
    #main{width:1200px!important;margin:0 auto!important;}
    #mainMap{width:800px!important; margin-left: 37%!important;}
    #mainpeople{border:none!important}
    #mainpeople h2{text-align: left;margin-top: 30px; }
    #mainpeople h5 {
    font-size: 18px;
    color: #475058;
    text-align: center;
    font-weight: normal;
    padding-top: 20px;
    }
    .slp_left{  padding: 30px 0 0 0;}
    .slp_left ul li {
    margin-top: 24px;
    overflow: hidden;
    }
    .slp_left ul li .money {
    width: 112px;
    color: #475058;
    line-height: 15px;
    text-align: right;
    display: inline-block;
    float: left;
    overflow: hidden;
    /* background: #309; */
    }
    ul li .percentage {
    color: #475058;
    float: left;
    line-height: 15px;
    }
    ul li .sc_i {
    height: 15px;
    border-radius: 5px;
    display: inline-block;
    float: left;
    position: absolute;
    top: -1px;
    left: -1px;
    }
    .slp_left ul li .value_inw {
    width: 18%;
    background: #ffc64c;
    }
     ul li .inlc_color {
    color: #00a8dd;
    }
    ul li .scale {
    width: 290px;
    height: 16px;
    background:#f0f4f7;
    border: 1px solid #e8ecef;
    border-radius: 5px;
    display: inline-block;
    float: left;
     verflow: hidden;
    margin: 0 10px;
    box-sizing: border-box;
    padding-right: 2px;
    position: relative;
    }
    .slp_right{ margin-top: 50px!important;margin-right: -100px;}
    .slp_right ul {
    box-sizing: border-box;
    }
    .slp_right ul li {
    margin-top: 24px;
    overflow: hidden;
    }

    .slp_right .woman {
    width: 19px;
    height: 42px;
    display: inline-block;
    background: url("/images/inc.png") no-repeat;
    float: left;
    }
    .slp_right ul li .inrw_scale {
    margin: 14px 10px 10px 10px;
    box-sizing: border-box;
    }
    .slp_right ul li .inc_colorw {
    line-height: 42px;
    color: #fb8836;
    }
    .slp_right .man {
    width: 19px;
    height: 42px;
    display: inline-block;
    background: url("/images/inc.png") no-repeat 0 -48px;
    float: left;
    }
    .slp_right ul li .inrw_scale {
    margin: 14px 10px 10px 10px;
    box-sizing: border-box;
    }
    .slp_right ul li .value_inrw2 {
    width: 64%;
    background: #00a8dd;
    }
    .slp_right ul li .inc_colorm {
    line-height: 42px;
    color: #00a8dd;
    }
    .slp_right ul li .value_inrw1 {
    width: 36%;
    background: #fb914b ;
    }
    </style>
</head>
<body>

    <!--------顶部栏-------->
    <%@include file="/WEB-INF/include/header.jsp"%>
  <%
     EnStaticData enStaticData=(EnStaticData)request.getAttribute("enStaticData");
  %>
   

 <!--Step:1 Prepare a dom for ECharts which (must) has size (width & hight)-->
    <!--Step:1 为ECharts准备一个具备大小（宽高）的Dom-->
 <div class="container">
       <h2 style="text-align: left; margin-top: 30px;">累计投资金额</h2>
       <div id="dateTime">*数据截止至<%=TimestampParser.format(enStaticData.createtime,"yyyy-MM-dd")%></div>

    <div id="main" style="height:500px;border:0px solid #ccc;">
    </div>
</div>


    <div class="container">
      <h2  style="text-align: left;margin-top: 30px;">投资地域分布</h2>
      <div id="mapTime">*数据截止至 <%=TimestampParser.format(enStaticData.createtime,"yyyy-MM-dd")%></div>

    <div id="mainMap" style="height:500px;border:0px solid #ccc;padding:10px;"> 
    </div>
    <div class="tc_left">
    <ul id="provinceSort">
     <% 
             //把string转化成map;
             JsonMapper jsonMapper = JsonMapper.normalMapper();
           
             Map<String, Object> map = new LinkedHashMap<String, Object>();
             map = jsonMapper.fromJson(enStaticData.areadata, LinkedHashMap.class);
             List<AreasMapentity> list=new ArrayList<AreasMapentity>();
             for (String key : map.keySet()) {  
            	 AreasMapentity entity=new AreasMapentity();
            	 entity.F01=key;
            	 entity.F02=new BigDecimal(map.get(key).toString());
            	 list.add(entity);       
              }  
          
         
              %>
             <% for(int m=0;m<10;m++){
            	 
            	 if(m==0 || m==1){
             %>
                  <li><span class="sort sortbg"><%=m+1 %></span><span class="province"><%=list.get(m).F01 %></span><span class="sum">￥<%=Formater.formatAmount(list.get(m).F02) %></span></li>
             <%}else if(m==2){ %>
             
                   <li><p class="tcl_fgx"><span class="sort sortbg"><%=m+1 %></span><span class="province"><%=list.get(m).F01 %></span><span class="sum">￥<%=Formater.formatAmount(list.get(m).F02) %></span></p></li>
             <%}else{ %>
             
                    <li><span class="sort"><%=m+1 %></span><span class="province"><%=list.get(m).F01 %></span><span class="sum">￥<%=Formater.formatAmount(list.get(m).F02) %></span></li>
             <%}} %>
             
 
    </ul>
    </div>
    </div>
           <% 
               DecimalFormat df = new DecimalFormat("0.00");  
              //60后
              double sixin=(double)enStaticData.sint/(double)enStaticData.icount*100;
               
              //70后
              double sevin=(double)enStaticData.seint/(double)enStaticData.icount*100;
              //80后
              double eigin=(double)enStaticData.eint/(double)enStaticData.icount*100;
              //90后
              double niin=(double)enStaticData.nint/(double)enStaticData.icount*100;
              
              
              //女生
              double wmint=(double)enStaticData.womanint/(double)enStaticData.icount*100;
              
              //男生
              double mint=(double)enStaticData.manint/(double)enStaticData.icount*100;
             
           
               
               %>


  <div id="mainpeople" style="height:350px;text-align:center;border:1px solid #ccc;padding:10px;">
     <div class="container">
      <h2>累计投资金额</h2>
       <div id="ratioTime">*数据截止至<%=TimestampParser.format(enStaticData.createtime,"yyyy-MM-dd")%></div>

        <div class="slp_left" style="float: left;overflow: hidden;">
        <ul>
           <li><span class="money">60后</span>
               <span class="scale inlw_scale"><i class="sc_i value_inw" style="width:<%= df.format(sixin)%>%"></i></span>
               <span class="percentage inlc_color"><%= df.format(sixin)%>%</span>
           </li>
           <li><span class="money">70后</span>
               <span class="scale inlw_scale"><i class="sc_i value_inw" style="width:<%=df.format(sevin)%>%"></i></span>
               <span class="percentage inlc_color"><%=df.format(sevin)%>%</span>
           </li>
           <li><span class="money">80后</span>
               <span class="scale inlw_scale"><i class="sc_i value_inw" style="width:<%=df.format(eigin)%>%"></i></span>
               <span class="percentage inlc_color"><%=df.format(eigin)%>%</span>
           </li>
           <li><span class="money">90后</span>
               <span class="scale inlw_scale"><i class="sc_i value_inw" style="width:<%=df.format(niin)%>%"></i></span>
               <span class="percentage inlc_color"><%=df.format(niin)%>%</span>
           </li> 
        </ul>
         <h5>年龄分布</h5>
        </div>  
        <div class="slp_right" style="float: right;overflow: hidden;margin-top: 14px;">
          <ul id="investGender">
                  <li>
                     <span class="woman"></span>
                           <span class="scale inrw_scale">
                              <i class="sc_i value_inrw1" style="width:<%=df.format(wmint)%>"></i>
                                   </span>
                                          <span class="percentage inc_colorw"><%=df.format(wmint)%>%</span>
                       </li>
                        <li>
                                       <span class="man"></span>
                                                 <span class="scale inrw_scale">
                                         <i class="sc_i value_inrw2" style="width:<%=df.format(mint)%>"></i>
                                                      </span>
                                  <span class="percentage inc_colorm"><%=df.format(mint)%>%</span>
                        </li>
           </ul>
          <h5>性别分布</h5>
        </div>

    </div>
   </div>
    <!--Step:2 Import echarts.js-->
    <!--Step:2 引入echarts.js-->
    <script src="/js/echarts.js"></script>
    
    <script type="text/javascript">
    var arrx = new Array(); 
    var arry = new Array();
    var spedata="<%=enStaticData.columdata%>";
    var strx= new Array();
    var styy = new Array();
    // 柱状图
    strx=spedata.split(",");
   
    for (var i=0;i<strx.length;i++ )   
    {  
   	
  	   styy=strx[i].split(":");
  	   arrx[i]=styy[0];
  	   arry[i]=styy[1];
    }
    
   

    // Step:3 conifg ECharts's path, link to echarts.js from current page.
    // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
    require.config({
        paths: {
            echarts: './js'
        }
    });
    
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
            'echarts',
            'echarts/chart/bar',
            'echarts/chart/line',
            'echarts/chart/map'
        ],
        function (ec) {
            //--- 折柱 ---
            var myChart = ec.init(document.getElementById('main'));
            myChart.setOption({
                tooltip : {
                	show: true
                },
                legend: {
                    data:[]
                    
                },
                xAxis : [
                    {
                        type : 'category',
                        splitLine:{ 
                     
                            show:false

                                },

                        data : arrx
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                       
                    }
                ],
                series : [
                 {
                        name:'投资额',
                        type:'bar',
                        barMaxWidth:30,
                        // itemStyle:{
                        //  normal:{color:'orange'}
                        // },
                        data:arry
                    }
                ]
            });
            
            //map地图
            var maparry=new Array();
            var mapdatajson=JSON.parse("<%=enStaticData.areadata.replace("\"","\\\"")%>");
            for(var p in mapdatajson){
            	 var valmap = mapdatajson[p];
            	if(p.indexOf('省')>-1){
            		p=p.replace('省','');
            	}else if(p.indexOf('市')>-1){
            		p=p.replace('市','');
            	}else if(p.indexOf('宁夏')>-1){
            		p='宁夏';
            	}else if(p.indexOf('新疆')>-1){
            		p='新疆';
            	}else if(p.indexOf('广西')>-1){
            		p='广西';
            	}else if(p.indexOf('西藏')>-1){
            		p='西藏';
            	}else if(p.indexOf('内蒙古')>-1){
            		p='内蒙古';
            	}
            	
            	maparry.push(eval('(' +"{name:'"+p+"',value:"+valmap+"}"+')'));
            }
            
            
            // --- 地图 --
          //  var iceArr = new Array();
            
         //   for(var j=0;j<maparry.length;j++){
            	//iceArr.push(eval('(' + maparry[j] + ')'));
         //   }
            
 
            
            
            var myChart2 = ec.init(document.getElementById('mainMap'));
            myChart2.setOption({
                tooltip : {
                    trigger: 'item',
                    formatter: '{b}:{c}'
                },
                dataRange: {
                    show:false, 
                    min: 0,
                    max: 1000000,
                    x: 'left',
                    y: 'bottom',
                    text:['高','低'],           // 文本，默认为数值文本
                    calculable : true
                },
                series : [
                    {
                        name: '中国',
                        type: 'map',
                        mapType: 'china',
                        selectedMode : 'multiple',
                        itemStyle:{
                            normal:{label:{show:true}},
                            emphasis:{
                            	areaStyle:{color:'#0199e8'},
                            	label:{show:true}}
                        },
                        data:maparry
                    }
                ]
            });
        }
    );
    </script>
    <%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>