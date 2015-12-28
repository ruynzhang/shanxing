$(function(){
	$('#container').highcharts({
        title: {
            text: '',
            x: -20 
        },
        subtitle: {
            text: '',
            x: -20
        },
        xAxis: {
            categories: ['0:00时','1:00时','2:00时','3:00时','4:00时','5:00时','6:00时','7:00时','8:00时','9:00时','10:00时','11:00时',
                         '12:00时','13:00时','14:00时','15:00时','16:00时','17:00时','18:00时','19:00时','20:00时','21:00时','22:00时',
                         '23:00时'],
            labels: {
            	rotation: 45
            }
        },
        yAxis: {
            title: {
                text: '人数 （人）'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        credits: {
        	enabled: false
        },
        legend: {
        	enabled: false
        },
        tooltip: {
            formatter: function() {
                return this.x+': 在线用户'+this.y+'人';
            }
        },
        series: [{
        	name: "ds",
        	data: data
        }]
    });
});
