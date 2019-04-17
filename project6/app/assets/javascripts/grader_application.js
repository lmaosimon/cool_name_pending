$(document).on('turbolinks:load', function() { 
 
   $('input[type="checkbox"]').change(function() {
      $('.btn.submit').attr('disabled', $('input[type="checkbox"]:checked').length == 0);
   });
     
});

$(document).on("ready page:change", function() {
    $("[data-toggle='tooltip']")
      .tooltip("destroy")
      .tooltip();
  });
