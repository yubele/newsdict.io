scroll()
function scroll(){
  if (window.scrollY > window.outerHeight) {
    console.log(window.outerHeight + " " + window.scrollY)
  }
  setTimeout(function() {
    scroll()
  }, 100)
}