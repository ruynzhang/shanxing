$(function(){
	$("#wdzq1").mouseover(function(){
		$("#wdzqyz1").show();
	});
	$("#wdzq1").mouseout(function(){
		$("#wdzqyz1").hide();
	});
	$("#wdzq2").mouseover(function(){
		$("#wdzqyz2").show();
	});
	$("#wdzq2").mouseout(function(){
		$("#wdzqyz2").hide();
	});
	$(".tableOdd tr:odd").addClass("tdColor");
});
