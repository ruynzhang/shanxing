$(function(){
	var data = [{name: '充值金额', data: []},{name: '提现金额', data: []}];
	data[0].data = d1;
	data[1].data = d2;
	createLine('line1', data);
	
	data[0].name = '充值笔数';
	data[1].name = '提现笔数';
	data[0].data = dd1;
	data[1].data = dd2;
	createLine('line2', data);
});
function createLine(id, data){
	var pf = '';
	var yTitle = '';
	if('line1' == id){
		pf = '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	    '<td style="padding:0"><b>{point.y:.2f} 元</b></td></tr>';
		yTitle = '金额（元）';
	}else {
		pf = '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	    '<td style="padding:0"><b>{point.y:.0f} 笔</b></td></tr>';
		yTitle = '交易（笔）';
	}
	 $('#'+id).highcharts({
         title: {
             text: '',
             x: -20 
         },
         subtitle: {
             text: '',
             x: -20
         },
         xAxis: {
             categories: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
         },
         yAxis: {
             title: {
                 text: yTitle
             },
             plotLines: [{
                 value: 0,
                 width: 1,
                 color: '#808080'
             }]
         },
         tooltip: {
        	 headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
             pointFormat: pf,
             footerFormat: '</table>',
             shared: true,
             useHTML: true
         },
         legend: {
             layout: 'vertical',
             align: 'right',
             verticalAlign: 'middle',
             borderWidth: 0
         },
         credits: {
         	enabled: false
         },
         series: data
     });
}