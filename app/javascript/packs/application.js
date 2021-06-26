/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
const images = require.context('../images/', true)
import Vue from 'vue'
import Axios from 'axios/dist/axios.js'
Axios.interceptors.request.use((config) => {
  if(['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').content;
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});
import '../css/application.scss'
import '../imports/autoload.js'
import '../imports/fontawesome.js'
import '../imports/dropdown.js'
import '../imports/autoscroll.js.erb'
import '../imports/swipe.js'
import '../imports/web_site.js'
import '../imports/navbar-burger.js'
// ref. https://stackoverflow.com/questions/45758837/script5009-urlsearchparams-is-undefined-in-ie-11
(function (w) {
    w.URLSearchParams = w.URLSearchParams || function (searchString) {
        var self = this;
        self.searchString = searchString;
        self.get = function (name) {
            var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(self.searchString);
            if (results == null) {
                return null;
            }
            else {
                return decodeURI(results[1]) || 0;
            }
        };
    }
})(window)