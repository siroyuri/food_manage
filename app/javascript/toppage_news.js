$(document).on('turbolinks:load', function() {
  $(function () {
    console.log('お知らせ');
    $('.normal_news').delay(3000).queue(function () {
      $('.normal_news').css('display', 'none');
    });
  });
});