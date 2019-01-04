import Vue from "vue";
import VueRouter from "vue-router";

import "axios";
import item from "./item";
import bid from "./bid";

Vue.use(VueRouter);

Vue.component("item", item);
Vue.component("bid", bid);

var router = new VueRouter({
  routes: [
      { path: '/', component: item },
      { path: '/items/:item_id', component: bid, name: "bid" },
      { path: '*', redirect: '/' }
  ]
});

new Vue({router}).$mount("#app");