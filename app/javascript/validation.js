$(document).on('turbolinks:load', function() {
  $(function () {
    var addError = function(form) {
      form.removeClass('form_normal');
      form.addClass('form_error');
    };
    var removeError = function(form, er) {
      form.removeClass('form_error');
      form.addClass('form_normal');
      er.text('').removeClass('er');
    };

    $('body').on('input', '#js_valid_check input', function () {
      var informationsForm = $(this).parents('#js_valid_check');
      var errorBox = informationsForm.next('#error_message_box');

      if ( informationsForm.attr('class') == 'top_sub_form' ) {
        // 複数登録フォーム purchase_date エラーチェック

        var PDErrorBox = informationsForm.next('.er_message_box_pd').find('#purchase_date_error_message');
        if ( informationsForm.find('#js_input_purchase_date').val() == '' ) {
          addError(informationsForm.find('#js_input_purchase_date'));
          PDErrorBox.text('※入力必須').addClass('er');
        } else {
          removeError(informationsForm.find('#js_input_purchase_date'), PDErrorBox);
        }

      } else if ( informationsForm.attr('class') == 'purchase_date_top') {
        // 単数登録フォーム purchase_date エラーチェック

        var categoryBox = $(this).parents('.category_box');
        var PDErrorBox = categoryBox.prev('.er_message_box_pd_top').find('#purchase_date_error_message');
        if ( categoryBox.find('#js_input_purchase_date').val() == '' ) {
          addError(categoryBox.find('#js_input_purchase_date'));
          PDErrorBox.text('※入力必須').addClass('er');
        } else {
          removeError(categoryBox.find('#js_input_purchase_date'), PDErrorBox);
        }

      } else {
        // purchase_date以外 エラーチェック

        if ( //１つでも入力があるかどうか
          informationsForm.find('#name').val() || informationsForm.find('#quantity').val() ||
          informationsForm.find('#unit').val() || informationsForm.find('#deadline').val()
        ) { // エラーチェック
          // name 入力必須
          if ( informationsForm.find('#name').val() == '' ) {
            addError(informationsForm.find('#name'));
            errorBox.find('#error_name').text('※入力必須').addClass('er');
          } else if ( informationsForm.find('#name').val().length > 10 )  {
            // 10文字以内
            addError(informationsForm.find('#name'));
            errorBox.find('#error_name').text('※10文字以内').addClass('er');
          } else {
            removeError(informationsForm.find('#name'), errorBox.find('#error_name'));
          }
          // quantity 入力必須
          if ( informationsForm.find('#quantity').val() == '' ) {
            addError(informationsForm.find('#quantity'));
            errorBox.find('#error_quantity').text('※入力必須').addClass('er');
          } else {
            removeError(informationsForm.find('#quantity'), errorBox.find('#error_quantity'));
          }
          // unit 3文字以内
          if ( informationsForm.find('#unit').val().length > 3 ) {
            addError(informationsForm.find('#unit'));
            errorBox.find('#error_unit').text('※3文字以内').addClass('er');
          } else {
            removeError(informationsForm.find('#unit'), errorBox.find('#error_unit'));
          }
        } else { // エラー解除
          removeError(informationsForm.find('#name'), errorBox.find('#error_name'))
          removeError(informationsForm.find('#quantity'), errorBox.find('#error_quantity'));
          removeError(informationsForm.find('#unit'), errorBox.find('#error_unit'));
        }
      }

      if ( $('.er').length ) {
        $('#js_valid_check_submit').prop('disabled', true);
      } else {
        $('#js_valid_check_submit').prop('disabled', false);
      }
    });

    $('body').on('input', '#js_valid_check_edf input', function () { // 編集ページ
      var edf = $(this).parents('#js_valid_check_edf');
      var erBox = edf.next('#error_message_box');

      // category_name 入力必須
      if ( edf.find('#ca_name').val() == '' ) {
        addError(edf.find('#ca_name'));
        erBox.find('#error_ca_name').text('※入力必須').addClass('er');
      } else {
        removeError(edf.find('#ca_name'), erBox.find('#error_ca_name'));
      }
      // name 入力必須
      if ( edf.find('#name').val() == '' ) {
        addError(edf.find('#name'));
        erBox.find('#error_name').text('※入力必須').addClass('er');
      } else if ( edf.find('#name').val().length > 10 )  {
        // 10文字以内
        addError(edf.find('#name'));
        erBox.find('#error_name').text('※10文字以内').addClass('er');
      } else {
        removeError(edf.find('#name'), erBox.find('#error_name'));
      }
      // quantity 入力必須
      if ( edf.find('#quantity').val() == '' ) {
        addError(edf.find('#quantity'));
        erBox.find('#error_quantity').text('※入力必須').addClass('er');
      } else {
        removeError(edf.find('#quantity'), erBox.find('#error_quantity'));
      }
      // unit 入力必須
      if ( edf.find('#unit').val().length > 3 ) {
        addError(edf.find('#unit'));
        erBox.find('#error_unit').text('※3文字以内').addClass('er');
      } else {
        removeError(edf.find('#unit'), erBox.find('#error_unit'));
      }
      // purchase_date 入力必須
      if ( edf.find('#purchase_date').val() == '' ) {
        addError(edf.find('#purchase_date'));
        erBox.find('#error_purchase_date').text('※入力必須').addClass('er');
      } else {
        removeError(edf.find('#purchase_date'), erBox.find('#error_purchase_date'));
      }

      if ( $('.er').length ) {
        $('#js_valid_check_submit').prop('disabled', true);
      } else {
        $('#js_valid_check_submit').prop('disabled', false);
      }
    });

    $('body').on('click', '.js_item_list_btn', function(e) {
      e.preventDefault();
      var informationsForm = $(this).parents('.informations_form_wrap').find('#js_valid_check');
      var errorBox = informationsForm.next('#error_message_box');

      if ( informationsForm.find('#name').hasClass('form_error') ) {
        removeError(informationsForm.find('#name'), errorBox.find('#error_name'));
      }

      // quantity 入力必須
      if ( informationsForm.find('#quantity').val() == '' ) {
        addError(informationsForm.find('#quantity'));
        errorBox.find('#error_quantity').text('※入力必須').addClass('er');
      } else {
        removeError(informationsForm.find('#quantity'), errorBox.find('#error_quantity'));
      }

      if ( $('.er').length > 0 ) {
        $('#js_valid_check_submit').prop('disabled', true);
      } else {
        $('#js_valid_check_submit').prop('disabled', false);
      }
    });
  });
});
