/*
*author:Null
*DATE:2013.5.24
*/

$(function(){		   
//头页登录
$("#navul > li").not(".navhome").hover(function(){$(this).addClass("navmoon")},function(){$(this).removeClass("navmoon")})


var maxwidth = 580;
$(".news_text img").each(function(){
  if ($(this).width() > maxwidth) {
   $(this).width(maxwidth);}
   }); 
}); 
function $tomato(id) {
	return document.getElementById(id);
}
function runCode(obj) {
	var winname = window.open('', "_blank", '');
	winname.document.open('text/html', 'replace');
	winname.document.writeln(obj.value);
	winname.document.close();
}

(function($){
    $.fn.capacityFixed = function(options) {
        var opts = $.extend({},$.fn.capacityFixed.deflunt,options);
        var FixedFun = function(element) {
            var top = opts.top;
            element.css({
                "top":50
            });
            $(window).scroll(function() {
                var scrolls = $(this).scrollTop();
                if (scrolls > top) {
                    var r;
					for(var i=1; i<5; i++) {
					   if(scrolls>=$("#tyj_ranklist"+i).offset().top)	{ r=i; }
					}
					for(var i=0; i<4; i++)
	                { $("#rank_nav a").eq(i).removeClass("chose");}
                    $("#rank_nav a").eq(r-1).addClass("chose");
					$(".sx_rank_data").css("margin-bottom","90px");
                    if (window.XMLHttpRequest) {
                        element.css({
                            position: "fixed",
                            top: "0",
							width: "100%",
							left: "50%",
							marginLeft: "-50%"						
                        });
                    } else {
                        element.css({
                            top: scrolls
                        });
                    }
                }else {
                    element.css({
                        position: "relative",
                        top: 50	
                    });
					for(var i=0; i<4; i++)
	                { $("#rank_nav a").eq(i).removeClass("chose");}
					$(".sx_rank_data").css("margin-bottom","0");
                }
            });
            element.find(".close-ico").click(function(event){
                element.remove();
                event.preventDefault();
            })
        };
        return $(this).each(function() {
            FixedFun($(this));
        });
    };
    $.fn.capacityFixed.deflunt={
		left : "50%",//相对于页面宽度的右边定位
        top:900
	};
})(jQuery);