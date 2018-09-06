$(document).on('ajax:success', '#shareImage', (event, data) => {
  $('#flash_message').html(data.flash);
  $('.modal-backdrop').remove();
  $('#shareImage').modal('hide');
});

$('#shareImage').on('show.bs.modal', (event) =>  {
  console.log('test1');
  const button = $(event.relatedTarget); // Button that triggered the modal
  const recipient = button.data('link'); // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  $('#image_email_image_link').val(recipient);
});

$(document).on('ajax:error','#shareImage', (event, xhr, status, error) => {
  if (error == 'Unprocessable Entity') {
    $('.modal-backdrop').remove();
    $('#shareImage').replaceWith(xhr.responseJSON.error_modal);
    $('#shareImage').modal('show');

  }
});
