$(function () {
  $('body').on('click', '#js_add_informations_form', function (e) {
    e.preventDefault();
    var addBtnParent = $(this).parent();
    var cloneForm = $(`#${addBtnParent.attr('id')}_informations_form`).clone(true);
    var dateNow = jQuery.now();
    var formName = `form_item_collection[informations_attributes][${dateNow}]`
    var removeBtn = `<a class="js_delete_btn" id="js_${dateNow}_form">−フォームを削除</a>`
  
    cloneForm.attr('id', `js_${dateNow}_form_wrap`);
    cloneForm.find('#category_id').attr('name', `${formName}[category_id]`);
    var checkBox = cloneForm.find('#check_box')
    checkBox.prop('checked', false).attr('name', `${formName}[is_frozen]`);
    checkBox.prev().attr('name', `${formName}[is_frozen]`);
    cloneForm.find('#frozen_img').addClass('grayscale');
    cloneForm.find('#name').val('').attr('name', `${formName}[name]`);
    cloneForm.find('#quantity').val('').attr('name', `${formName}[quantity]`);
    cloneForm.find('#unit').val('').attr('name', `${formName}[unit]`);
    cloneForm.find('#deadline').val('').attr('name', `${formName}[deadline]`);
    cloneForm.append(removeBtn);

    $(addBtnParent).before(cloneForm);
  });
});
