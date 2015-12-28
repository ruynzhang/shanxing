$(function(){
	var data = [{name: '', data: []},{name: '', data: []}];
	data[0].name = y-1+'年度';
	data[1].name = y+'年度';
	data[0].data = lastData1;
	data[1].data = columnData1;
	createColumn('column1', data);
	data[0].data = lastData2;
	data[1].data = columnData2;
	createColumn('column2', data);
	
	createPie('pie1', '按产品类型', data1);
	createPie('pie2', '按期限', data2);
	if(data3.length > 0){
		createPie('pie3', '按地域', data3);
	}
});
function createColumn(id, data){
	var pf = '';
	var yTitle = '';
	if('column1' == id){
		pf = '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	    '<td style="padding:0"><b>{point.y:.2f} 元</b></td></tr>';
		yTitle = '金额（元）';
	}else {
		pf = '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	    '<td style="padding:0"><b>{point.y:.0f} 笔</b></td></tr>';
		yTitle = '交易（笔）';
	}
	
	$('#'+id).highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        credits: {
        	enabled: false
        },
        xAxis: {
            categories:['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
        },
        yAxis: {
            min: 0,
            title: {
                text: yTitle
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: pf,
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: data
    });
}
function createPie(id, name, data){
	 $('#'+id).highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: 0,
	            plotShadow: false
	        },
	        title: {
	            text: '',
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        credits: {
	        	enabled: false
	        },
	        plotOptions: {
	            pie: {
	                dataLabels: {
	                    enabled: true,
	                    distance: -30,
	                    style: {
	                        fontWeight: 'bold',
	                        color: 'white',
	                        textShadow: '0px 1px 2px black'
	                    }
	                },
	                startAngle: -180,
	                endAngle: 180
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: name,
	            innerSize: '50%',
	            data: data
	        }]
	    });
}