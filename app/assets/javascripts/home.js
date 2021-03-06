// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).on('turbolinks:load', function() {
  $('body').fadeIn(1000);
  $('#flash-msg').fadeIn(3000);
  $('#flash-msg').fadeOut(8000);
  $('#mag-glass').hover( function(){
    $('.user-search').fadeIn();
    $('#search-field').focus();
    $('#mag-glass').focusout( function() {
      $('#search-field').val('');
      $('.user-search').fadeOut();
    })
  });
  $('#search-field').attr('autocomplete', 'off');
  $('#search-field').on('input', function() {
    if ($('#search-field').val() !== '') {
      Rails.fire(this.form, 'submit');
    } else if ($('#search-field').val() == '') {
      $('.search-results').empty();
      $('.search-results').css('display', 'none');
    }
  });
  $('#friends-btn').click( function() {
    $('.friends-list').fadeIn();
  });
});