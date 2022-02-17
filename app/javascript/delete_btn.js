$(function () {
  $('body').on('click', '.js_delete_btn', function (e) {
    var id = $(this).attr('id');
    $(`#${id}_wrap`).remove();
  });
});
