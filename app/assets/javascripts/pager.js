$(document).ready(function () {
    $(function() {
        total_num = $("#investors").attr('num');
        $("#pager").pagination({
            items: total_num,
            itemsOnPage: 8,
            cssStyle: 'light-theme',
            nextText: '下一页 》',
            prevText: '《 上一页',
            onInit: function(){
                $(".investor:lt(8)").show();
            },
            onPageClick: function(number, event){
                start = (number-1) * 8 ;
                end = number * 8;
                $(".investor").hide();
                $(".investor").slice(start, end).show();

            }
        });
    });
});