function getWeekDay(lang) {
    days = new Array();
    if (arguments.length == 0) {
        days = new Array("星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
    } else {
        days = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
    }
    day = (new Date).getDay(),
    return days[day];
}

function getWeekofYear() {
    var a = new Date;
    b = new Date(a.getFullYear(), 0, 0);
    c = parseInt((a.getTime() - b.getTime()) / 6048e5);
    return c;
}
