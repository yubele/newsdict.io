/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
const images = require.context('../images/', true)
import Vue from 'vue/dist/vue.js'
import Axios from 'axios/dist/axios.js'
import '../imports/fontawesome.js'
import '../imports/dropdown.js'
import '../css/application.scss'
new Vue({
    el: '#mobile-menu',
    data: {
        isOpen: false
    }
})
var app = new Vue({
  el: "#more-contents",
  data: {
    current_page: 1,
    next_page: 2,
    is_scroll: false,
    contents: []
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll);
  },
  methods: {
    handleScroll() {
      // Max height of window
      const windowScrollMaxY = document.documentElement.scrollHeight - document.documentElement.clientHeight;
      if (window.scrollY > windowScrollMaxY - 200) {
        if (this.is_scroll == false) {
          this.is_scroll = true
          Axios.get("/api/v1/contents.json",{
            params: {
              skip: this.current_page * 25,
              limit: 25
          }})
          .then(response => {
            this.contents = this.contents.concat(response.data)
            this.current_page++
            this.next_page++
            this.is_scroll = false
          })
        }
      }
    }
  }
})