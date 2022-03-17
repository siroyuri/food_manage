$(document).on('turbolinks:load', function() {
  $(function () {
    $('body').on('click', '.js_delete_btn', function (e) {
      e.preventDefault();
      var id = $(this).attr('id');
      console.log(id);
      $(`#${id}_wrap`).remove();
    });
  });
});

