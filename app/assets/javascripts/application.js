// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(function () {
    // Sorting and pagination links.
    $(document).on("click", "#available_cards th a, #available_cards .pagination a", function () {
        $.getScript(this.href);
        return false;
    });

    // Search form.
    $('#cards_search input').keyup(function () {
        $.get($('#cards_search').attr('action'), $('#cards_search').serialize(), null, 'script');
        return false;
    });
});
$(function () {
    // Sorting and pagination links.
    $(document).on("click", "#cards th a, #cards .pagination a", function () {
        $.getScript(this.href);
        return false;
    });
});
$(function () {
    $(document).ready(function () {
        $(document).mousemove(function (e) {
            $('#floating_img').offset({
                left: e.pageX,
                top: e.pageY + 20
            });
        });
    });
});

$(function () {
    $('.text_div').hover(function () {
        var $filename = "/images/cards/" + $(this).closest('div.text_div').text().replace(" ","") + ".png";
        $('#floating_img').addClass("img_visible");
        $("#floating_img").removeClass("img_invisible");
        $("#floating_img").attr("src", $filename);
    }, function () {
        $("#floating_img").addClass("img_invisible");
        $("#floating_img").removeClass("img_visible");
    });
});