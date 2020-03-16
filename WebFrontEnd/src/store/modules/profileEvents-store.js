import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default {
  state: {
    createdEvents: [],
    joinedEvents: []
  },
  mutations: {
    setCreatedEvents (state, events) {
      state.createdEvents = events
    },
    setJoinedEvents (state, events) {
      state.joinedEvents = events
    }
  },
  actions: {
    fetchCreatedEvents ({ commit }, userId) {
      axios.get('', { params: { userId: userId } })
        .then(events => {
          console.log(events)
          commit('setCreatedEvents', events)
        })
        .catch(error => console.log(error))
    },
    fetchJoinedEvents ({ commit }, userId) {
      axios.get('', { params: { userId: userId } })
        .then(events => {
          console.log(events)
          commit('setJoinedEvents', events)
        })
        .catch(error => console.log(error))
    }
  },
  getters: {
    createdEvents: (state) => {
      return state.createdEvents
    },
    joinedEvents: (state) => {
      return state.joinedEvents
    }
  }
}
