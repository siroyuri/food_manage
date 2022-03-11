$(document).on('turbolinks:load', function() {
  $(function () {
    $(document).on('mouseenter', '.hover_content', function () {
      var image = $(this).find('.hover_image');
      image.stop().animate({ height: 'hide' }, 200, function () {
        var appeared = $(this).nextAll('.hover_appeared');
        appeared.stop().animate({ height: 'show' }, 200);
      });
    });
    $(document).on('mouseleave', '.hover_content', function () {
      var appeared = $(this).find('.hover_appeared');
      appeared.stop().animate({ height: 'hide' }, 200, function () {
        var image = $(this).prevAll('.hover_image');
        image.stop().animate({ height: 'show' }, 200);
      });
    });

    $(document).on('click', '#js_arrow_img', function () {
      var img = $(this);
      var items_box = $(this).parents('.item_wrap').find('.items_box');

    if (items_box.css('display') == 'none') {
      var src = img.attr('src').replace('off', 'on');
      img.attr('src', src);
      items_box.stop().animate({ height: 'show' }, 'slow');
    } else {
      var src = img.attr('src').replace('on', 'off');
      img.attr('src', src);
      items_box.stop().animate({ height: 'hide' }, 'slow');
    }
  });
});
});
