///<jscompress sourcefile="jquery.tabs.js" />
/* =================================================
 // jQuery Tabs Plugins 1.0
 // author:chenyg@5173.com
 // URL:http://stylechen.com/jquery-tabs.html
 // 4th Dec 2010
 // =================================================*////<jscompress sourcefile="jquery.tabs2.js" />
/* =================================================
 // jQuery Tabs Plugins 1.0
 // author:chenyg@5173.com
 // URL:http://stylechen.com/jquery-tabs.html
 // 4th Dec 2010
 // =================================================*/(function(b){b.fn.extend({Tabs:function(a){a=b.extend({event:"mouseover",timeout:0,auto:0,callback:null},a);var c=b(this),g=c.children("div.tab_box").children("div"),h=c.children("ul.tab_menu"),e=h.find("li"),d,k=function(a){a.siblings("li").removeClass("current").end().addClass("current");g.siblings("div").addClass("hide").end().eq(a.index()).removeClass("hide")},m=function(a,f){f?setTimeout(function(){k(a)},f):k(a)},l=function(){a.auto&&(d=setInterval(n,a.auto))},n=function(){var a=h.find("li.current"),f=e.eq(0),b=e.length,c=a.index()+1,f=c===b?f:a.next("li"),b=c===b?0:c;a.removeClass("current");f.addClass("current");g.siblings("div").addClass("hide").end().eq(b).removeClass("hide")};e.bind(a.event,function(){m(b(this),a.timeout);a.callback&&a.callback(c)});a.auto&&(l(),c.hover(function(){clearInterval(d);d=void 0},function(){l()}));return this}})})(jQuery);(function(b){b.fn.extend({Tabss:function(a){a=b.extend({event:"mouseover",timeout:0,auto:0,callback:null},a);var c=b(this),g=c.children("div.tab_box2").children("div"),h=c.children("div.tab_menu2"),e=h.find("li"),d,k=function(a){a.siblings("li").removeClass("current").end().addClass("current");g.siblings("div").addClass("hide").end().eq(a.index()).removeClass("hide")},m=function(a,b){b?setTimeout(function(){k(a)},b):k(a)},l=function(){a.auto&&(d=setInterval(n,a.auto))},n=function(){var a=h.find("li.current"),b=e.eq(0),c=e.length,d=a.index()+1,b=d===c?b:a.next("li"),c=d===c?0:d;a.removeClass("current");b.addClass("current");g.siblings("div").addClass("hide").end().eq(c).removeClass("hide")};e.bind(a.event,function(){m(b(this),a.timeout);a.callback&&a.callback(c)});a.auto&&(l(),c.hover(function(){clearInterval(d);d=void 0},function(){l()}));return this}})})(jQuery);