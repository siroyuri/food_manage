$(function () {
  $('body').on('click', '.js_item_list_btn', function(e) {
    e.preventDefault();
    var listBtn = $(this);
    var informationsForm = listBtn.parents('.informations_form');
    informationsForm.find('#name').val($(listBtn).find('#list_btn_name').text());
    informationsForm.find('#unit').val($(listBtn).find('#list_btn_unit').text());
  });
});