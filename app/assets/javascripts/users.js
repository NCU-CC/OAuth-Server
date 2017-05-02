$(document).on('turbolinks:load', function() {
  var display = false;
  $('a#show-switch').click(function() {
    $('div.user-switch').css('display', display ? 'none' : 'block');
    $("a#show-switch i.material-icons").text(display ? 'laptop_mac' : 'done');
    display = !display;
  });
  $('input.user-check-box').change(function(event) {
    if (confirm('Are you sure?'))
      $(this.form).children('input[type=submit]').click();
    else
      $(this).prop('checked', !$(this).prop('checked'))
  });
  $('form.edit_user').on('ajax:success', function(event, data, status, xhr) {
    Materialize.toast('User updated.', 2000);
    $('div#user_' + data.portal_id + ' i#owner-icon').css('display', data.authorization_server_owner ? 'inline-block' : 'none');
    $('div#user_' + data.portal_id + ' i#disabled-icon').css('display', data.disabled ? 'inline-block' : 'none');
  });
});
