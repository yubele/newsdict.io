(function (w) {
  if (document.querySelector('.is-active')) {
    const activeItem = document.querySelector('.is-active')
    activeItem.scrollIntoView({
      inline: 'center'
    });
  }
})(window)