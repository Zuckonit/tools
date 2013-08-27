//get the weather from tecent
//jQuery required
jQuery.getScript("http://weather.news.qq.com/js/gn_24.js",
    function(){
        var city=''; //weather of such city
        var nj = v.find(city).w.split("<br/>");
        var nj_weather = nj[1].split(':')[1];
        var nj_tmp = nj[2].split(':')[1].replace('～', ' ~ ');
});
