
//paste this code under the head tag or in a separate js file.
	// Wait for window load
	$(window).load(setTimeout(function() {
		// Animate loader off screen
		$(".se-pre-con").fadeOut("slow");;
	},4000));

$('.tabbutton').click(function() {
  $('.tabbutton.active').removeClass('active');
  $(this).addClass('active');
  var tabNumber = $(this).attr('data-value');
  var tabToOpen = ".conteudo[data-value='" + tabNumber + "']"; 
  $(tabToOpen).addClass('teste');
})