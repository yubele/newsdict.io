(function(){
  const timeNotToReload = 60 * 60 * 60 * 1000
  const startMillisecond = window.performance.now()
  window.addEventListener('DOMContentLoaded', function(){
    window.addEventListener('focus', function(){
      if (startMillisecond >= timeNotToReload) {
        window.location.reload()
      }
    });
  })
})()