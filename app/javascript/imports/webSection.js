import Axios from 'axios/dist/axios.js'
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
    linkElement.setAttribute('href', 'data:text/css,' + encodeURIComponent(".web-section-focus {border: 3px solid #f00}"))
    iframe.contentWindow.document.head.appendChild(linkElement)
    iframe.contentWindow.addEventListener('mousemove', function(event) {
        var clRect = iframe.getBoundingClientRect()
        /* global CustomEvent */
        var evt = new CustomEvent('mousemove', { bubbles: true, cancelable: false })
        evt.clientX = event.clientX + clRect.left
        evt.clientY = event.clientY + clRect.top
        
        const element = iframe.contentWindow.document.elementFromPoint(evt.clientX, evt.clientY)
        if (element && focusLock == false) {
            var els = iframe.contentWindow.document.getElementsByClassName('web-section-focus')
            Array.prototype.forEach.call(els, function(el) {
                el.classList.remove('web-section-focus')
            })
            element.classList.add('web-section-focus')
        }
        
        iframe.dispatchEvent(evt)
    })
}
function bindIframeClick(iframe) {
    var linkElement = document.createElement('link')
    linkElement.setAttribute('rel', 'stylesheet')
    linkElement.setAttribute('type', 'text/css')
    linkElement.setAttribute('href', 'data:text/css,' + encodeURIComponent(".web-section-focus {border: 3px solid #f00}"))
    iframe.contentWindow.document.head.appendChild(linkElement)
    iframe.contentWindow.addEventListener('click', function(event) {
        var clRect = iframe.getBoundingClientRect()
        /* global CustomEvent */
        const clickEvent = new CustomEvent('click', { bubbles: true, cancelable: false })
        clickEvent.clientX = event.clientX + clRect.left
        clickEvent.clientY = event.clientY + clRect.top
        
        const clickEventElement = iframe.contentWindow.document.elementFromPoint(clickEvent.clientX, clickEvent.clientY)
        if (clickEventElement) {
            focusLock = true
            const parser = document.createElement('a')
            parser.href =  iframe.src
            Axios.post("/admin/web_sections/show_links",{
                id: parser.pathname.split('/')[3],
                xpath: getXpath(clickEventElement)
            })
            .then(response => {
                const max_length = 50
                Array.prototype.forEach.call(response.data, function(link) {
                    const node = document.createElement("li")
                    node.appendChild(document.createTextNode(link.length > max_length ? (link).slice(0, max_length)+"…" : link))
                    document.getElementById("show_links").appendChild(node); 
                })
            })
        }
        
        iframe.dispatchEvent(clickEvent)
    })
}
function bindIframeReset(iframe) {
    document.getElementById('web-section-reset').addEventListener('click', function() {
        focusLock = false
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
        s.push(e);
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
if (document.getElementById('web-section-iframe')) {
    document.getElementById('web-section-iframe').onload = function() {
        (function(){
            clearIframeLinks(document.getElementById('web-section-iframe'))
            bindIframeMouseMove(document.getElementById('web-section-iframe'))
            bindIframeClick(document.getElementById('web-section-iframe'))
            bindIframeReset(document.getElementById('web-section-iframe'))
        })(window)
    }
}
