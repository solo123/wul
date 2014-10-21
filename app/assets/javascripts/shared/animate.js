/* ======= Animations ======= */
jQuery(document).ready(function($) {

    //Only animate elements when using non-mobile devices
    if (jQuery.browser.mobile === false) {

        /* Animate elements in #Promo */
        $('#fixed .fixed-invest').css('opacity', 0).one('inview', function(isInView) {
            if (isInView) {
                $(this).addClass('animated fadeInLeft delayp2');
            }
        });
    }

});
