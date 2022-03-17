const buildHtml = (name) => {
  const html = `
    <label class="category_list_checkbox  ca_checked_tr">
      <input name="category[category_lists][][category_list_id]" type="checkbox" value="0" checked="checked" class="ipf_checkbox" id="category_checkbox">
      <input name="category[category_lists][][name]" type="checkbox" class="hidden" value="${name}" checked="checked">
      ${name}
    </label>
    `;
  return html;
}

$(document).on('turbolinks:load', function() {
  $(function () {
    $('#js_modal_open').on('click', function () {
      $('.modal_wrap').fadeIn();
    });
  
    $('body').on('click', '#js_category_name_submit', function () {
      var name = $(this).prev()
      if (name.val() != "") {
        $('#js_category_checkbox_field').append(buildHtml(name.val()));
      };
      name.val('');
    });
  
    $('body').on('click', '#category_checkbox', function () {
      var check = $(this).prop('checked');
      $(this).next().prop('checked', check);
  
      if (check) {
        $(this).parent('.category_list_checkbox').removeClass('ca_checked_fa');
        $(this).parent('.category_list_checkbox').addClass('ca_checked_tr');
      } else {
        $(this).parent('.category_list_checkbox').removeClass('ca_checked_tr');
        $(this).parent('.category_list_checkbox').addClass('ca_checked_fa');
      }
    });
  });
});
