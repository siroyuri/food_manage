$(document).on('turbolinks:load', function() {
  $(function () {
    $('body').on('click', '#js_add_informations_form', function (e) {
      e.preventDefault();
      var addBtnParent = $(this).parent();
      var cloneForm = $(`#${addBtnParent.attr('id')}_informations_form`).clone(true);
      var dateNow = jQuery.now();
      var formName = `form_item_collection[informations_attributes][${dateNow}]`
      var removeBtn = `
        <a class="js_delete_btn" id="js_${dateNow}_form" href="#">
          <img class="icon_img" src="http://localhost:3000/delete.png">
        </a>
      `
    
      cloneForm.attr('id', `js_${dateNow}_form_wrap`);
      cloneForm.find('.js_item_list_btn_box').hide();
      cloneForm.find('#category_id').attr('name', `${formName}[category_id]`);
      var checkBox = cloneForm.find('#check_box')
      checkBox.prop('checked', false).attr('name', `${formName}[is_frozen]`);
      checkBox.prev().attr('name', `${formName}[is_frozen]`);
      cloneForm.find('#frozen_img').addClass('grayscale');
      cloneForm.find('#name').val('').attr('name', `${formName}[name]`);
      cloneForm.find('#quantity').val('').attr('name', `${formName}[quantity]`);
      cloneForm.find('#unit').val('').attr('name', `${formName}[unit]`);
      cloneForm.find('#deadline').val('').attr('name', `${formName}[deadline]`);
      cloneForm.find('.form_box_delete').append(removeBtn);
      cloneForm.removeClass('hidden');
  
      $(addBtnParent).before(cloneForm);
    });
  
    $('body').on('input', '#js_input_purchase_date', function () {
      var value = $(this).val();
      $('#js_hidden_purchase_date').val(value);
    });
  
    $('body').on('input', '#quantity', function () {
      var quantity = $(this).val();
      if ( quantity <= 0 ) {
        $(this).val('');
      }
    });
  });
});
