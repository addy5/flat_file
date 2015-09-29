var ready = function() {
  console.log('active js');
   $('.notice').delay(500).slideDown('normal', function() {
      $(this).delay(2500).slideUp(500);
   });

   $('.loggedIn').delay(500).slideDown('normal', function() {
      $(this).delay(2500).slideUp(500);
   });

   $('.newUser').delay(500).slideDown('normal', function() {
      $(this).delay(6000).slideUp(500);
   });


// HANDLE POSTER DETAILS HIDE/SHOW
    var posterModule = $('.posterModule');
    var details = $('.details');
    var navBar = $('.navBar');
    var timer;


    posterModule.on('mouseenter', function(){
      var self = $(this);

      if(timer) clearTimeout(timer);
      if (self.children('p').hasClass('active')) return null;
      timer = setTimeout(function(){
        $('.active').removeClass('active').fadeOut('normal');
        self.children('.details').addClass('active').fadeIn('slow');
      },750);

    });

    var scroll_pos = 0;

    $(document).scroll(function() {
        scroll_pos = $(this).scrollTop();
        if(scroll_pos > 80) {
          navBar.css('background-color','rgba(0,0,0,0.5)');
          navBar.children().css('opacity', 0.5);
        } else {
          navBar.css('background-color','rgba(0,0,0,0.8)');
          navBar.children().css('opacity', 1);
        }
    });

    navBar.on('mouseenter',function(){
      if(timer) clearTimeout(timer);
      $('.active').removeClass('active').fadeOut('normal');
      navBar.css('background-color','rgba(0,0,0,0.8)');
      navBar.children().css('opacity', 1);
    });

    navBar.on('mouseleave',function(){
      var scroll_pos = $(document).scrollTop();
      if(scroll_pos > 80){
        navBar.css('background-color','rgba(0,0,0,0.5)');
        navBar.children().css('opacity', 0.5);
      }
    });

    navBar.bind( 'mousewheel DOMMouseScroll', function(e){
      e.preventDefault();
    });

    var addNewPoster = $('.addNewPoster');
    var newPoster = $('.newPoster');

    addNewPoster.on('click', function(){
      $(this).fadeOut(600, function(){
        newPoster.fadeIn(1200);
        var n = $(document).height();
        $('html, body').animate({ scrollTop: n - 790 }, 900);
        if(timer) clearTimeout(timer);
        $('.active').removeClass('active').fadeOut('normal');
      });
    });

};

$(document).on('page:load', ready);
$(document).ready(ready);
