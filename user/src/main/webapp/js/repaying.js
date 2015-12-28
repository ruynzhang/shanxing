$(function(){
	$("div.dialog_close").click(function(){
		$(this).parent().hide();
	});
});
function open(id){
	$("div.dialog").hide();
	$("#"+id).show();
}