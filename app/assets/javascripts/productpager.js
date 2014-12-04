$(document).ready(function () {


    $(function () {
        item_page = 10;
        fix_num = $("#fixed").attr('num');
        $("#fixed_pager").pagination({
            items: fix_num,
            itemsOnPage: 10,
            cssStyle: 'light-theme',
            nextText: '下一页',
            prevText: '上一页',
            onInit: function () {
                $(".fixed_item").hide();
                $(".fixed_item:lt(10)").show();
            },
            onPageClick: function (number, event) {
                start = (number - 1) * 10;
                end = number * 10;
                $(".fixed_item").hide();
                $(".fixed_item").slice(start, end).show();

            }
        });
    });

    $(function () {
        month_num = $("#month").attr('num');
        $("#month_pager").pagination({
            items: month_num,
            itemsOnPage: 8,
            cssStyle: 'light-theme',
            nextText: '下一页',
            prevText: '上一页',
            onInit: function () {
                $(".month_item").hide();
                $(".month_item:lt(8)").show();
            },
            onPageClick: function (number, event) {
                start = (number - 1) * 8;
                end = number * 8;
                $(".month_item").hide();
                $(".month_item").slice(start, end).show();

            }
        });
    });


});