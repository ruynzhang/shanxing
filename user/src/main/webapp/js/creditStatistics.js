$(function(){
	if(d1_jk != null){
		createPie(d1_jk, "s1_jk");
	}
	if(d2_jk != null){
		createPie(d2_jk, "s2_jk");
	}
	if(d3_jk != null){
		createPie(d3_jk, "s3_jk");
	}
	if(dd1_jk != null){
		createColumn("c1_jk", cc1_jk, dd1_jk, "借款金额", "最近一年成功借款金额分布");
	}
	if(dd2_jk != null){
		createColumn("c2_jk", cc2_jk, dd2_jk, "还款金额", "最近六个月还款金额分布");
	}
});
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
function createColumn(id,categories,data,name,title){
	$("#"+id).highcharts({
		chart: {
            type: 'column'
        },
        title: {
            text: "<p style=\"font-family: \"微软雅黑\";\">"+title+"</p>",
            useHTML: true
        },
        xAxis: {
        	categories:categories
        },
        yAxis: {
            min: 0,
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
        	name: name,
            data: data
        }]
	});
}