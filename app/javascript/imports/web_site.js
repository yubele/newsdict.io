let focusLock = false
function clearIframeLinks(iframe) {
    // A Tag Links
    const hrefs = iframe.contentWindow.document.getElementsByTagName('a')
    Array.prototype.forEach.call(hrefs, function(href) {
        href.href = "javascript:void(0)"
    })
}
function bindIframeMouseMove(iframe) {
    var linkElement = document.createElement('link')
    linkElement.setAttribute('rel', 'stylesheet')
    linkElement.setAttribute('type', 'text/css')
    linkElement.setAttribute('href', 'data:text/css,' + encodeURIComponent(".web-site-focus {border: 3px solid #f00}"))
    iframe.contentWindow.document.head.appendChild(linkElement)
    iframe.contentWindow.addEventListener('mousemove', function(event) {
        var clRect = iframe.getBoundingClientRect()
        /* global CustomEvent */
        var evt = new CustomEvent('mousemove', { bubbles: true, cancelable: false })
        evt.clientX = event.clientX + clRect.left
        evt.clientY = event.clientY + clRect.top
        
        const element = iframe.contentWindow.document.elementFromPoint(evt.clientX, evt.clientY)
        if (element.getElementsByTagName("a") && focusLock == false) {
            var els = iframe.contentWindow.document.getElementsByClassName('web-site-focus')
            Array.prototype.forEach.call(els, function(el) {
                el.classList.remove('web-site-focus')
            })
            element.classList.add('web-site-focus')
        }
        
        iframe.dispatchEvent(evt)
    })
}
function bindIframeClick(iframe) {
    var linkElement = document.createElement('link')
    linkElement.setAttribute('rel', 'stylesheet')
    linkElement.setAttribute('type', 'text/css')
    linkElement.setAttribute('href', 'data:text/css,' + encodeURIComponent(".web-site-focus {border: 3px solid #f00}"))
    iframe.contentWindow.document.head.appendChild(linkElement)
    iframe.contentWindow.addEventListener('click', function(event) {
        var clRect = iframe.getBoundingClientRect()
        /* global CustomEvent */
        const clickEvent = new CustomEvent('click', { bubbles: true, cancelable: false })
        clickEvent.clientX = event.clientX + clRect.left
        clickEvent.clientY = event.clientY + clRect.top
        
        const clickEventElement = iframe.contentWindow.document.elementFromPoint(clickEvent.clientX, clickEvent.clientY)
        if (clickEventElement.getElementsByTagName("a") && focusLock == false) {
            focusLock = true
            const parser = document.createElement('a')
            parser.href =  iframe.src
            const xpath = getXpath(clickEventElement)
            document.getElementById('sources_web_site_id').value = parser.pathname.split('/')[3]
            document.getElementById('sources_web_site_xpath').value = xpath
        }
        
        iframe.dispatchEvent(clickEvent)
    })
}
function bindIframeReset(iframe) {
    document.getElementById('web-site-reset').addEventListener('click', function(event) {
        focusLock = false
        document.getElementById("sources_web_site_xpath").value = ""
        event.preventDefault();
    })
}
function bindChangeSourceUrl(iframe) {
    document.getElementById('sources_web_site_source_url').addEventListener('focusout', function() {
        iframe.src = '/admin/web_sites/' + document.getElementById('sources_web_site_id').value + '/html/'
    })
}
// refs https://qiita.com/narikei/items/fb62b543ca386fcee211
function getXpath(element) {
  if(element && element.parentNode) {
    var xpath = getXpath(element.parentNode) + '/' + element.tagName;
    var s = [];
    for(var i = 0; i < element.parentNode.childNodes.length; i++) {
      var e = element.parentNode.childNodes[i];
      if(e.tagName == element.tagName) {
        s.push(e)
      }
    }
    if(1 < s.length) {
      for(var i = 0; i < s.length; i++) {
        if(s[i] === element) {
          xpath += '[' + (i+1) + ']';
          break;
        }
      }
    }
    return xpath.toLowerCase();
  } else {
    return '';
  }
}
if (document.getElementById('web-site-iframe')) {
    (function(w){
        bindChangeSourceUrl(document.getElementById('web-site-iframe'))
    })(window)
    document.getElementById('web-site-iframe').onload = function() {
        (function(){
            clearIframeLinks(document.getElementById('web-site-iframe'))
            bindIframeMouseMove(document.getElementById('web-site-iframe'))
            bindIframeClick(document.getElementById('web-site-iframe'))
            bindIframeReset(document.getElementById('web-site-iframe'))
        })(window)
    }
}
