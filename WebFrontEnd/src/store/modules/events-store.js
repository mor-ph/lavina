import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default {
  state: {
    events: null,
    filters: {
      category: [],
      subcategories: [],
      location: [],
      date: ''
    },
    selectedFilters: {
      category: null,
      subcategory: null,
      location: null,
      date: null
    }
  },
  mutations: {
    setEvents (state, events) {
      state.events = events
    },
    setSelectedFilters (state, filters) {
      state.selectedFilters = filters
    }
  },
  actions: {
    fetchRecentEvents ({ commit }) {
      // fix this query when the endpoint is ready
      axios.get('5103/api/event/getall')
        .then(events => {
          commit('setEvents', events)
        }).catch(err => console.log(err))
    },
    // fix this query when the endpoint is ready
    fetchEvents ({ commit, state }) {
      axios.get('5103/api/event/getall', {
        params: {
          category: state.selectedFilters.category,
          subCategory: state.selectedFilters.subcategory,
          location: state.selectedFilters.location,
          date: state.selectedFilters.date
        }
      }).then(events => {
        commit('setEvents', events)
      }).catch(err => console.log(err))
    },

    fetchCategories ({ state }) {
      axios.get('5103/api/category')
        .then(categories => {
          categories.map(category => {
            state.filters.category.push(category.name)
          })
        }).catch(err => console.log(err))
    },

    fetchLocations ({ state }) {
      axios.get('5103/api/location')
        .then(locations => {
          locations.map(location => {
            state.filters.location.push(location.name)
          })
        }).catch(err => console.log(err))
    },

    fetchFilters ({ dispatch }) {
      const categories = dispatch('fetchCategories')
      const locations = dispatch('fetchLocations')

      return Promise.all([categories, locations])
    },

    async fetchFilteredEvents ({ commit, dispatch }, filters) {
      if (this.selectedFilters.category !== filters.category) {
        await dispatch('fetchSubcategories', filters.category)
      }
      commit('setSelectedFilters', filters)
      dispatch('fetchEvents')
    },

    fetchSubcategories ({ state }, category) {
      this.filters.subcategory = []
      axios.get('5103/api/category/getsub/' + category)
        .then(category => {
          category.subcategory.map(subcategory => {
            state.filters.subcategories.push(subcategory.name)
          })
        }).catch(err => console.log(err))
    }
  },
  getters: {
    events: (state) => {
      return state.events
    },
    filters: (state) => {
      return state.filters
    },
    selectedFilters: (state) => {
      return state.selectedFilters
    }
  }
}
