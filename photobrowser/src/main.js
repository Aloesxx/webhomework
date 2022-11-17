import Vue from 'vue'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

// npm install --save axios vue-axios
// 配置axios
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

// npm i element-ui -S
// 配置element
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);

// axios请求
import Api from './utils/index.js';
Vue.prototype.$api = Api;

import EXIF from 'exif-js'
Vue.use(EXIF);

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
