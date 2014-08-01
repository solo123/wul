function charge() {
    if ($("#charge_num").val()) {
        $.post("/usercenter/console/charge_mock", {
            charge_value: $("#charge_num").val()
        }, null, "script");
    }
}