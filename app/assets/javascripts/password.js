$(document).ready(function () {
    show_flash_message();

})

function show_flash_message() {
    if (flash_exist()) {
        $("#flash-message").delay(500).show("slideUp");
        $("#flash-message").delay(2500).hide("slideUp");
    }
}

function flash_exist(){
    return $("#flash-message").children().length > 0;
}