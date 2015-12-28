$(function(){
	var categories1 = ['一季度','二季度','三季度','四季度'];
	var data =  [
	             {
	             	 name: '平台自然人',
	                 data: [],
	                 stack: 0
	             }, {
	             	 name: '平台法人',
	                 data: [],
	                 stack: 0},
	             {
	                 name: '新增平台自然人',
	                 data: [],
	                 stack: 1
	             }, {
	             	name: '新增平台法人',
	                 data: [],
	                 stack: 1
	             }];
	data[0].data = q0;
	data[1].data = q1;
	data[2].data = q2;
	data[3].data = q3;
	create('quarter', categories1, data);
	
	var categories2 = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'];
	data[0].data = m0;
	data[1].data = m1;
	data[2].data = m2;
	data[3].data = m3;
	create('month', categories2, data);
});
function create(id, categories, data){
	$('#'+id).highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: categories
        },
        yAxis: {
            min: 0,
            title: {
                text: '数量(人)'
            }
        },
        credits: {
        	enabled: false
        },
        legend: {
        	enabled: true
        },
        plotOptions: {
            column: {
                stacking: 'normal'
            }
        },
        series: data
    });
}