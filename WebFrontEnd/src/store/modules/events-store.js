import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default {
  state: {
    events: [],
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
    },
    emptySubcategoriesArray (state) {
      state.filters.subcategories = []
      state.selectedFilters.subcategory = null
    }
  },
  actions: {
    fetchRecentEvents ({ commit }) {
      // fix this query when the endpoint is ready
      axios.get('http://localhost:5103/api/event/getall')
        .then(events => {
          commit('setEvents', events)
        }).catch(err => console.log(err))
    },
    // fix this query when the endpoint is ready
    fetchEvents ({ commit, state }) {
      axios.get('http://localhost:5103/api/event/getall', {
        params: {
          category: state.selectedFilters.category,
          subCategory: state.selectedFilters.subcategory,
          location: state.selectedFilters.location,
          date: state.selectedFilters.date
        }
      }).then(events => {
        console.log(events)
        commit('setEvents', events)
      }).catch(err => console.log(err))
    },

    fetchCategories ({ state }) {
      axios.get('http://localhost:5103/api/category')
        .then(categories => {
          categories.data.map(category => {
            state.filters.category.push(category.name)
          })
        }).catch(err => console.log(err))
    },

    fetchLocations ({ state }) {
      axios.get('http://localhost:5103/api/location')
        .then(locations => {
          locations.data.map(location => {
            state.filters.location.push(location.name)
          })
        }).catch(err => console.log(err))
    },

    fetchFilters ({ dispatch }) {
      const categories = dispatch('fetchCategories')
      const locations = dispatch('fetchLocations')

      return Promise.all([categories, locations])
    },

    fetchSubcategories ({ state, commit }, category) {
      commit('emptySubcategoriesArray')
      axios.get('http://localhost:5103/api/category/getsub/' + category)
        .then(subCategories => {
          console.log(subCategories)
          subCategories.data.map(subcategory => {
            state.filters.subcategories.push(subcategory.name)
          })
        }).catch(err => console.log(err))
    },

    createEvent (formData) {
      console.log(formData)
      axios.post('http://localhost:5103/api/event/create', {
        title: formData.title,
        category: formData.category,
        subcategory: formData.subcategory,
        eventStartDate: formData.eventStartDate,
        city: formData.city,
        address: formData.address,
        recurring: formData.recurring,
        peopleNeeded: formData.peopleNeeded,
        description: formData.description,
        eventStatus: 1
      })
        .then(response => {
          console.log(response)
        }).catch(error => {
          console.log(error)
        })
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
