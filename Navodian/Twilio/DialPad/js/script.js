$(document).ready(function () {
    $('.num').click(function () {
        var num = $(this);
        var text = $.trim(num.find('.txt').clone().children().remove().end().text());
        var telNumber = $('#telNumber');
        $(telNumber).val(telNumber.val() + text);
    });

    var audioUrl = 'http://localhost/DialPad/keypad/dtmf-0.mp3';
    $('.abc').click( () => new Audio(audioUrl).play() );

});