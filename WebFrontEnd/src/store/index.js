import Vue from 'vue'
import Vuex from 'vuex'
import auth from './modules/auth-store'
import events from './modules/events-store'
// import profileEvents from './modules/profileEvents-store'

Vue.use(Vuex)
export default new Vuex.Store({
  modules: {
    auth,
    events/*,
    profileEvents */
  }
})
