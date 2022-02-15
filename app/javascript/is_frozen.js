$(function () {
  $('body').on('click', '.is_frozen', function() {
    if ($(this).children('#check_box').prop('checked')) {
      $(this).children('img').removeClass('grayscale');
    } else {
      $(this).children('img').addClass('grayscale');
    }
  });
});