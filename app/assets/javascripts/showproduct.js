$(document).ready(function () {
    $(".explain").popover();
    show_flash_message();
    $("#product_value").bind("keyup", function () {
        v = $("#product_value").val();
        p = $("#profit_rate").html();
        if (isNaN(v) || isNaN(p)) {
            $("#profit_value").html("0.00");
        }
        else {
            if (v > 0 && p > 0) {
                $("#profit_value").html(round(v * p, 2));
            }
            else {
            }
        }
    });

})


function round(number, fractionDigits) {
    with (Math) {
        var rv = round(number * pow(10, fractionDigits)) / pow(10, fractionDigits);
        return rv;
    }
}

function show_flash_message() {
    if (flash_exist()) {
        $("#flash-message").delay(500).show("slideUp");
        $("#flash-message").delay(2500).hide("slideUp");
    }
}

function flash_exist(){
    return $("#flash-message").children().length > 0;
}