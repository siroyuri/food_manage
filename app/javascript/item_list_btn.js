$(document).on('turbolinks:load', function() {
  $(function () {
    $('body').on('focus', '#name', function () {
      if ($('.js_item_list_btn_box').length) {
        $('.js_item_list_btn_box').stop().hide();
      }
      var listBtn = $(this).parents('.informations_form_wrap').find('.js_item_list_btn_box');
      listBtn.stop().show();
    });
  
    $('body').on('click', '.js_item_list_btn', function(e) {
      e.preventDefault();
      var listBtn = $(this);
      var informationsForm = listBtn.parents('.informations_form_wrap');

      informationsForm.find('#name').val($(listBtn).find('#list_btn_name').text());
      informationsForm.find('#unit').val($(listBtn).find('#list_btn_unit').text());
    });
  });
});
