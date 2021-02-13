(function(){
  window.addEventListener('DOMContentLoaded', function(){
    window.addEventListener('focus', function(){
      const datetime = new Date()
      window.location.reload()
    });
  })
})()