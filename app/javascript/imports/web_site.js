let focusLock = false
import Axios from 'axios/dist/axios.js'
function clearIframeLinks(iframe) {
    // A Tag Links
    const hrefs = iframe.contentWindow.document.getElementsByTagName('a')
    Array.prototype.forEach.call(hrefs, function(href) {
        href.href = "javascript:void(0)"
    })
}
function bindIframeMouseMove(iframe) {
    iframe.contentWindow.addEventListener('mousemove', function(event) {
        const headerHeight = 130
        const clRect = iframe.getBoundingClientRect()
        /* global CustomEvent */
        let evt = new CustomEvent('mousemove', { bubbles: true, cancelable: false })
        evt.clientX = event.clientX + clRect.left
        evt.clientY = event.clientY + clRect.top - headerHeight

        const element = iframe.contentWindow.document.elementFromPoint(evt.clientX, evt.clientY)
        if (focusLock == false) {
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
    iframe.contentWindow.addEventListener('click', function(event) {
        const headerHeight = 130
        const clRect = iframe.getBoundingClientRect()
        /* global CustomEvent */
        let evt = new CustomEvent('click', { bubbles: true, cancelable: false })
        evt.clientX = event.clientX + clRect.left
        evt.clientY = event.clientY + clRect.top - headerHeight

        const element = iframe.contentWindow.document.elementFromPoint(evt.clientX, evt.clientY)
        if (focusLock == false) {
            focusLock = true
            const parser = document.createElement('a')
            parser.href =  iframe.src
            const xpath = getXpath(element)
            document.getElementById('sources_web_site_id').value = parser.pathname.split('/')[3]
            document.getElementById('sources_web_site_xpath').value = xpath
        }

        iframe.dispatchEvent(evt)
    })
}
function bindIframeReset(iframe) {
    document.getElementById('web-site-reset').addEventListener('click', function(event) {
        focusLock = false
        document.getElementById("sources_web_site_xpath").value = ""
        event.preventDefault()
    })
}
function bindChangeSourceUrl(iframe) {
    document.getElementById('sources_web_site_source_url').addEventListener('focusout', function() {
        document.getElementById('loader-background').style.display = 'block';
        document.getElementById("sources_web_site_xpath").value = ""
        Axios.patch('/admin/sources~web_site/' + document.getElementById('sources_web_site_id').value + '/',{
            '_method': 'put',
            'authenticity_token': document.getElementsByName('authenticity_token')[0].value,
            'sources_web_site': {
                'name': document.getElementById('sources_web_site_name').value,
                'category_id': document.getElementById('sources_web_site_category_id').value,
                'source_url': document.getElementById('sources_web_site_source_url').value,
                'xpath': document.getElementById('sources_web_site_xpath').value
            }
        })
        .then(response => {
            iframe.contentWindow.location.reload()
        })
    })
}
// refs https://qiita.com/narikei/items/fb62b543ca386fcee211
function getXpath(element) {
  if(element && element.parentNode) {
    var xpath = getXpath(element.parentNode) + '/' + element.tagName
    var s = []
    for(var i = 0; i < element.parentNode.childNodes.length; i++) {
      var e = element.parentNode.childNodes[i]
      if(e.tagName == element.tagName) {
        s.push(e)
      }
    }
    if(1 < s.length) {
      for(var i = 0; i < s.length; i++) {
        if(s[i] === element) {
          xpath += '[' + (i+1) + ']'
          break
        }
      }
    }
    return xpath.toLowerCase()
  } else {
    return ''
  }
}
if (document.getElementById('web-site-iframe')) {
    (function(w){
        bindChangeSourceUrl(document.getElementById('web-site-iframe'))
    })(window)
    document.getElementById('web-site-iframe').onload = function() {
        const iframe = document.getElementById('web-site-iframe')
        const linkElement = document.createElement('link')
        linkElement.setAttribute('rel', 'stylesheet')
        linkElement.setAttribute('type', 'text/css')
        linkElement.setAttribute('href', 'data:text/css,' + encodeURIComponent(".web-site-focus {background-color:rgb(255, 0, 0, 0.2);}"))
        iframe.contentWindow.document.head.appendChild(linkElement)
        clearIframeLinks(iframe)
        bindIframeMouseMove(iframe)
        bindIframeClick(iframe)
        bindIframeReset(iframe)
        document.getElementById('loader-background').style.display = 'none';
    }
}
