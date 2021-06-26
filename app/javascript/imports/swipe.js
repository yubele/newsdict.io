function setSwipe(elem) {
    if (!document.querySelector(elem)) {
        return;
    }
    var t = document.querySelector(elem);
    var startX;
    var startY;
    var moveX;
    var moveY;
    var dist = 80;
    var pos = 1;
    t.addEventListener('touchstart', function(e) {
        startX = e.touches[0].pageX;
        startY = e.touches[0].pageY;
    });

    t.addEventListener('touchmove', function(e) {
        moveX = e.changedTouches[0].pageX;
        moveY = e.changedTouches[0].pageY;
    });

    t.addEventListener('touchend', function(e) {
        var nextElement = document.querySelector('.swipe-active').nextElementSibling
        var previousElement = document.querySelector('.swipe-active').previousElementSibling
        if (startX > moveX && startX > moveX + dist && nextElement) {
            document.location = nextElement.querySelector('a').href
        }
        else if (startX < moveX && startX + dist < moveX && previousElement) {
            document.location = previousElement.querySelector('a').href
        }
    });
}
function inElement(element, className) {
    if(element && element.classList && element.classList.contains(className)) {
        return true
    } else if (element.classList) {
        return inElement(element.parentNode, className)
    } else {
        return false
    }
}
(function() {
  setSwipe('.swipeContainer')
  // Move to the top of the swipe bar.
  if (document.querySelector('.swipeContainer')) {
    const activeItem = document.querySelector('.is-active')
    activeItem.scrollIntoView({
      inline: 'center'
    });
  }
})(window)
