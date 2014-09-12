$(document).ready(

    function(){
        $("#piechart").sparkline('html', {
            type: 'pie',
            width: '120',
            height: '120',
            sliceColors: ['#FFFFFF','#3366cc'],
            offset: -90});
        $(".act-border").click(function(){
            $(".act-border").removeClass("selectedarea");
            $(this).addClass("selectedarea");
            $(".actuary1").hide();
            var selfid = $(this).attr("id");
            $("#"+selfid + "-area").show();
        });
    }
)
