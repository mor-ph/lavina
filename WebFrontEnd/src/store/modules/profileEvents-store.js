import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default {
  state: {
    userEvents: []
  },
  mutations: {
    setUserEvents (state, events) {
      state.userEvents = events
    }
  },
  actions: {
    fetchUserEvents ({ commit }) {
      const headers = {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      }
      axios.get('http://localhost:5103/api/event/da', headers)
        .then(events => {
          console.log(events.data)
          commit('setUserEvents', events)
          console.log('commited')
        })
        .catch(error => console.log(error))
    }
  },
  getters: {
    userEvents: state => {
      return state.userEvents
    }
  }
}
