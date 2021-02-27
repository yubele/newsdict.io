const element = document.querySelector('.add_bookmark');
if (!(window.sidebar && window.sidebar.addPanel) && !(window.external && 'AddFavorite' in window.external)) {
    element.parentNode.removeChild(element);
}
// refs. https://shanabrian.com/web/javascript/add-favorite.php
element.addEventListener('click', function(){
    const siteTitle  = document.title,currentURL = window.location.href
    
    if (window.sidebar && window.sidebar.addPanel) {
        window.sidebar.addPanel(currentURL, siteTitle)
    } else if (window.external && 'AddFavorite' in window.external) {
        window.external.AddFavorite(currentURL, siteTitle)
    }
    return false
})