$(document).ready(function () {
    $(".discount_number").TouchSpin({
        min: 0,
        max: 100,
        step: 0.1,
        decimals: 1,
        boostat: 5,
        maxboostedstep: 10,
        postfix: '%'
    });

    $(".discount_number").change(function () {
        origin_value = $(this).parent().parent().prev().html();
        o_value = parseFloat(origin_value);
        d_rate = parseFloat($(this).val());
        $(this).parent().next().val($(this).val());
        discount_value = ((o_value * (100 - d_rate))/100).toFixed(2);
        $(this).parent().parent().next().children(0).html(discount_value);
    })
})