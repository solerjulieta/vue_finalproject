import Vue from 'vue'
import App from './App.vue'
import router from './router'
import AnimateCSS from 'animate.css'
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false

new Vue({
  router,
  AnimateCSS,
  vuetify,
  render: h => h(App)
}).$mount('#app')
