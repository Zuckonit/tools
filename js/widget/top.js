//copy from http://www.sharetk.com/html/code/jquery/6094.html
//dependence: jquery
$(document).scroll(function(){
var offset = $(document).scrollTop();
if (offset >= 500){
    $('#backtop').css('display','inherit');
}else{
    $('#backtop').css('display','none');
}
})
