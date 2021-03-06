/* ShowOff JS Logic */

var ShowOff = {};

var preso_started = false
var slidenum = 0
var slideTotal = 0
var slides
var currentSlide
var totalslides = 0
var slidesLoaded = false
var incrSteps = 0
var incrElem
var incrCurr = 0
var incrCode = false
var gotoSlidenum = 0
var shiftKeyActive = false


function setupPreso(load_slides, prefix) {
  if (preso_started)
  {
     alert("already started")
     return
  }
  preso_started = true

 
  loadSlides(load_slides, prefix)


  // bind event handlers
  document.onkeydown = keyDown
  document.onkeyup = keyUp
  /* window.onresize  = resized; */
  /* window.onscroll = scrolled; */
  /* window.onunload = unloaded; */

}

var islaide = {
  edit: function(){
    var $form = $("#form-master");
   
    $form.show("slide", {direction: "up"});  
    $form.submit(function(e) {
            e.preventDefault();
            $.ajax({
                type: 'POST',
                url: $form.attr('action'), 
                data: {item: $('#master').attr('value'),
                       page: slidenum },
                success: function(data, textStatus) {
                  if ($('#master').attr('value') != "=="){
                     element = $(data);
                     element.hide();
                     currentSlide.find('.content').append(element);
                     $('#master').val('');
                     element.fadeIn(2000);
                     prettyPrint();

                  }else{

                   $('#slides').append($(data));
                   $('#master').val('#| ');

                   initializePresentation();
                   nextStep();
                  }
                  $('#master').focus();
                }});
            });

    $("input[type='text']:first").focus();

    $('#master').css({ 
        width: "100%",
        fontSize: "150%",
        marginLeft:"0" });

    $('#icon-help').live('click', function() {
       $('#preso').toggle("slow");
       $('#footer').toggle("slow");
       $('#help').toggle("slow");
    });
    $('#icon-edit').live('click', function() {
       $('#form-master').toggle("slow");
       $('#master').focus();
    });

  },
  newPresentation: function(){
    var $form = $("#new-presentation");
    $form.show("slide", {direction: "right"});  
    $("input[type='text']:first").focus();


    $form.css({ 
        width: "50%",
        height: "5%",
        fontSize: "150%",
        marginLeft:"20%" });

  } 
};

function loadSlides(load_slides, prefix) { 
    $("#slides img").batchImageLoad({
        loadingCompleteCallback: initializePresentation(prefix)
    });
}

function initializePresentation(prefix) {
  //center slides offscreen
  centerSlides($('#slides > .slide'))

  //copy into presentation area
//  $("#preso").empty()
  $('#slides .slide').appendTo($("#preso"))

  //populate vars
  slides = $('#preso .slide')
  slideTotal = slides.size()

  //setup manual jquery cycle
  $('#preso').cycle({
    timeout: 0
  })

  if (slidesLoaded) {
    showSlide()
  } else {
    showFirstSlide()
    slidesLoaded = true
  }
  prettyPrint();
}

function centerSlides(slides) {
  slides.each(function(s, slide) {
    centerSlide(slide)
  })
}

function centerSlide(slide) {
  var slide_content = $(slide).children(".content").first()
  var height = slide_content.height()
  var mar_top = (0.5 * parseFloat($(slide).height())) - (0.5 * parseFloat(height))
  if (mar_top < 0) {
    mar_top = 0
  }
  slide_content.css('margin-top', mar_top)
}

function gotoSlide(slideNum) {
  slidenum = parseInt(slideNum)
  if (!isNaN(slidenum)) {
    showSlide()
  }
}

function showFirstSlide() {
  slidenum = 0
  showSlide()
}

function showSlide(back_step) {

  if(slidenum < 0) {
    slidenum = 0
    return
  }

  if(slidenum > (slideTotal - 1)) {
    slidenum = slideTotal - 1
    return
  }

  currentSlide = slides.eq(slidenum)

  var transition = currentSlide.attr('data-transition')
  var fullPage = currentSlide.find(".content").is('.full-page');

  if (fullPage) {
    transition = ''
  } else if (back_step) {
    transition = 'scrollDown'
  }

  $('#preso').cycle(slidenum, transition);
  var cssOptions = {'width' : '100%', 'overflow' : 'visible'};
  
  $('#preso').css(cssOptions);
  currentSlide.css(cssOptions);

  percent = getSlidePercent()
  $("#slideInfo").text((slidenum + 1) + '/' + slideTotal + '  - ' + percent + '%')

  if(back_step) {
    incrCurr = 0
    incrSteps = 0
  }

  $('body').addSwipeEvents().
    bind('swipeleft',  prevStep).
    bind('swiperight', nextStep)

  return getCurrentNotes()
}

function getSlideProgress()
{
  return (slidenum + 1) + '/' + slideTotal
}

function getCurrentNotes() 
{
  return currentSlide.find("p.notes").text()
}

function getSlidePercent()
{
  return Math.ceil(((slidenum + 1) / slideTotal) * 100)
}

function prevStep()
{
  slidenum--
  return showSlide(true) // We show the slide fully loaded
}

function nextStep()
{
  if (incrCurr >= incrSteps) {
    slidenum++
    return showSlide()
  } else {
    elem = incrElem.eq(incrCurr)
    if (incrCode && elem.hasClass('command')) {
      incrElem.eq(incrCurr).show().jTypeWriter({duration:1.0})
    } else {
      incrElem.eq(incrCurr).show()
    }
    incrCurr++
  }
}

function prevStep() {
  slidenum--
  return showSlide(true) // We show the slide fully loaded
}

//  See e.g. http://www.quirksmode.org/js/events/keys.html for keycodes
function keyDown(event)
{
    var key = event.keyCode;

    if (event.ctrlKey || event.altKey || event.metaKey)
       return true;

    if (key == 13 && gotoSlidenum > 0)
    {
      slidenum = gotoSlidenum - 1;
      showSlide(true);
    }
    gotoSlidenum = 0;

    if (key == 16) // shift key
    {
      shiftKeyActive = true;
    } else if (key == 38 || key == 33) // Left arrow or page up
    {
      prevStep()
    }
    else if (key == 40 || key == 34) // Right arrow or page down
    {
      nextStep()
    }
    else if (key == 66 || key == 70) // f for footer (also "b" which is what kensington remote "stop" button sends
    {
      toggleFooter()
    }
	else if (key == 27) // esc
	{
	}
    return true
}

function toggleFooter() 
{
  $('#footer').toggle()
}

function keyUp(event) {
  var key = event.keyCode;
  if (key == 16) // shift key
  {
    shiftKeyActive = false;
  }
}



