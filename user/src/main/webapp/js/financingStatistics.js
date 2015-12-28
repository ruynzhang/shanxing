$(function(){
	createColumn('c1_lc', dd1_lc);
	var categories = ['优选理财计划', '债权'];
	//由于没有了优选理财计划，就不使用DonutPie来显示，全部用普通的Pie来显示
	if(d1_lc != null){
		//var data = makePieData(d1_lc);
		//createDonutPie('s1_lc', data, categories);
		createPie(d1_lc, 's1_lc');
	}
	if(d2_lc != null){
		//var data = makePieData(d2_lc);
		//createDonutPie('s2_lc', data, categories);
		createPie(d2_lc, 's2_lc');
	}
	if(d3_lc != null){
		createPie(d3_lc, 's3_lc');
	}
});
function makePieData(data){
	var colors = Highcharts.getOptions().colors;
	var data1 = [];
	var data2 = [];
	data1.push(data[0]);
	data2.push(data[1]);
	data2.push(data[2]);
	data2.push(data[3]);
	var zqData = data[1] + data[2] + data[3];
	var data = [{
		y: data1,
        color: colors[1],
        drilldown: {
            name: '优选理财计划',
            categories: ['优选理财计划'],
            data: data1,
            color: colors[1]
        }
	},{
		y: zqData,
        color: colors[0],
        drilldown: {
            name: '债权',
            categories: ['信用认证标', '机构担保标', '实地认证标'],
            data: data2,
            color: colors[0]
        }
	}];
	return data;
}
function createPie(data, id){
	$('#'+id).highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: ''
        },
        tooltip: {
        	headerFormat:"",
            pointFormat:'{point.name}:{point.y}元'
        },
		credits: {
            enabled: false
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    distance:3,
                    formatter: function(){
						return this.point.name+":"+this.y+"元";
					}
                }
            }
        },
        series: [{
            type: 'pie',
            name: '',
            data: data
        }]
    });
}
function createColumn(id, data){
	$("#"+id).highcharts({
		chart: {
            type: 'column'
        },
        title: {
            text: "<p style=\"font-family: \"微软雅黑\";\">理财账户收益金额组成</p>",
            useHTML: true
        },
        xAxis: {
        	categories:['已挣利息','已挣罚息','债权转让盈利']
        },
        yAxis: {
            title: {
                text: '金额（元）'
            }
        },
        credits: {
            enabled: false
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} 元</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        series: [{
        	name: '账户收益',
            data: data
        }]
	});
}
function createDonutPie(id, data, categories){
	  var layerData1 = [];
      var layerData2 = [];
      for (var i = 0; i < data.length; i++) {
  
    	  layerData1.push({
              name: categories[i],
              y: data[i].y,
              color: data[i].color
          });
  
          for (var j = 0; j < data[i].drilldown.data.length; j++) {
              var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
              layerData2.push({
                  name: data[i].drilldown.categories[j],
                  y: data[i].drilldown.data[j],
                  color: Highcharts.Color(data[i].color).brighten(brightness).get()
              });
          }
      }
  
      $('#'+id).highcharts({
          chart: {
              type: 'pie'
          },
          title: {
              text: ''
          },
          credits: {
              enabled: false
          },
          plotOptions: {
              pie: {
                  shadow: false,
                  center: ['50%', '50%'],
                  dataLabels: {
                	  distance:3,
                	  enabled: true
                  }
              }
          },
          tooltip: {
          	  headerFormat:"",
              pointFormat:'{point.name}:{point.y}元'
          },
          series: [{
              name: '理财方式',
              data: layerData1,
              size: '60%',
              dataLabels: {
            	  formatter: function() {
                      return this.point.name+":"+this.y+"元";
                  },
                  color: 'white',
                  distance: -16
              }
          }, {
              name: '投标类别',
              data: layerData2,
              size: '80%',
              innerSize: '60%',
              dataLabels: {
                  formatter: function() {
                      return this.point.name+":"+this.y+"元";
                  }
              }
          }]
      });
}