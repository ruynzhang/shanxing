// common js
$(document).ready(function(){
    $(".back_top").click(function(){
	    $('body,html').animate({scrollTop:0},600);
	})
    var mW=$("#sx_m_main").width();
	$(".sx_input").css("width", mW -60+"px");
	
	$(".toReg2").mousemove(function(){
	    $(".overlay").show();
		$(".sx_popup").css("display","block");
		event.preventDefault();
	})
	$(".sx_err_btn").click(function(){
		$(".sx_popup").css("display","none");
		$(".overlay").hide();
	})
			
	$(".sx_m_showbox").css("height", screen.height*0.6+"px");
	$(".toReg").click(function(event){	
		event.preventDefault();
		$('html,body').animate({scrollTop:$(this.hash).offset().top-40},1000);
	});
	$(".showText").click(function(){
		$(".sx_m_showbox").fadeIn();
		$(".overlay").show();
		$(".sx_m_close").show();
	})
	$(".sx_m_close").click(function(){
	    $(".sx_m_showbox").fadeOut();
		$(".overlay").hide();
		$(this).hide();	
	})
	$("#redux").css("width",mW*0.8+"px");
	$(".container").css("height", mW*0.8*0.52+"px");
	$(".sx_reg_word2").click(function(){
	    $(".overlay").show();
		$(".sx_m_showShare").css("display","block");
	})
	$(".sx_m_showShare").click(function(){
	    $(this).css("display","none");
		$(".overlay").hide();
	})
})