$(document).ready(
    function(){

        $(".act-border").click(function(){
            $(".act-border").removeClass("selectedarea");
            $(this).addClass("selectedarea");
            $(".actuary1").hide();
            var selfid = $(this).attr("id");
            $("#"+selfid + "-area").show();
        });
    }
)
