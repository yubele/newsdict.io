function setSwipe(elem) {
    if (!document.querySelector(elem)) {
        return;
    }
    var t = document.querySelector(elem);
    var startX;
    var startY;
    var moveX;
    var moveY;
    var dist = 40;
    var pos = 1;
    t.addEventListener('touchstart', function(e) {
        //e.preventDefault();
        startX = e.touches[0].pageX;
        startY = e.touches[0].pageY;
    });

    t.addEventListener('touchmove', function(e) {
        //e.preventDefault();
        moveX = e.changedTouches[0].pageX;
        moveY = e.changedTouches[0].pageY;
    });

    t.addEventListener('touchend', function(e) {
        var nextElement = document.querySelector('.is-active').nextElementSibling
        var previousElement = document.querySelector('.is-active').previousElementSibling
        if (startX > moveX && startX > moveX + dist && nextElement) {
            document.location = nextElement.querySelector('a').href
        }
        else if (startX < moveX && startX + dist < moveX && previousElement) {
            document.location = previousElement.querySelector('a').href
        }
    });
}
(function() {
     setSwipe('.swipeContainer');
})(window)
