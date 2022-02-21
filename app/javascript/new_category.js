const buildHtml = (name) => {
  const html = `
    <label>
      <input name="category[category_lists][][category_list_id]" type="checkbox" value="0" checked="checked" id="category_checkbox">
      <input name="category[category_lists][][name]" type="checkbox" class="hidden" value="${name}" checked="checked">
      ${name}
    </label>
    `;
  return html;
}

$(function () {
  $('#js_category_name_submit').on('click', function () {
    var name = $(this).prev()
    if (name.val() != "") {
      $('#js_category_checkbox_field').append(buildHtml(name.val()));
    };
    name.val('');
  });

  $('body').on('click', '#category_checkbox', function () {
    var check = $(this).prop('checked');
    $(this).next().prop('checked', check);
  });
});