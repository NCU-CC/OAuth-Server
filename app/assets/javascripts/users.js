$(document).on('turbolinks:load', function() {
  var display = false;
  $('a#show-switch').click(function() {
    $('div.owner-switch').css('display', display ? 'none' : 'block');
    $("a#show-switch i.material-icons").text(display ? 'laptop_mac' : 'done');
    display = !display;
  });
  $('input.owner-check-box').change(function(event) {
    $(this.form).children('input[type=submit]').click();
  });
  $('form.edit_user').on('ajax:success', function(event, data, status, xhr) {
    Materialize.toast('User updated.', 2000);
    $('div#user_' + data.portal_id + ' i.material-icons').css('display', data.authorization_server_owner ? 'inline-block' : 'none');
  });
});
