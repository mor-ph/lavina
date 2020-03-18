import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default {
  state: {
    initialState: true,
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
    },
    currentEvent: []
  },
  mutations: {
    setEvents (state, events) {
      state.events = events
    },
    setSelectedFilters (state, filters) {
      state.selectedFilters = filters
    },
    emptySubcategoriesArray (state) {
      state.filters.subcategories = [{ value: null, text: 'None' }]
      state.selectedFilters.subcategory = null
    },
    changeInitialState (state) {
      state.initialState = !state.initialState
    },
    emptyCategoryAndLocationArray (state) {
      state.filters.category = [{ value: null, text: 'None' }]
      state.filters.location = [{ value: null, text: 'None' }]
    },
    setCurrentEvent (state, currentEvent) {
      state.currentEvent = []
      state.currentEvent = currentEvent
    }
  },
  actions: {
    loadInitalState ({ dispatch, commit, state }) {
      if (state.initialState) {
        commit('changeInitialState')
        const recentEvents = dispatch('fetchRecentEvents')
        const filters = dispatch('fetchFilters')
        return Promise.all([recentEvents, filters])
      }
    },
    fetchRecentEvents ({ commit }) {
      // fix this query when the endpoint is ready
      axios.get('http://localhost:5103/api/event')
        .then(events => {
          commit('setEvents', events)
        }).catch(err => console.log(err))
    },
    // fix this query when the endpoint is ready
    fetchEvents ({ commit, state }) {
      axios.get('http://localhost:5103/api/event', {
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
      axios.get('http://localhost:5103/api/category/main')
        .then(categories => {
          console.log(categories)
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

    fetchFilters ({ dispatch, commit }) {
      commit('emptyCategoryAndLocationArray')
      const categories = dispatch('fetchCategories')
      const locations = dispatch('fetchLocations')

      return Promise.all([categories, locations])
    },

    fetchSubcategories ({ state, commit }, category) {
      if (category === null) return
      commit('emptySubcategoriesArray')
      axios.get('http://localhost:5103/api/category/getsub/' + category)
        .then(subCategories => {
          console.log(subCategories)
          subCategories.data.map(subcategory => {
            state.filters.subcategories.push(subcategory.name)
          })
        }).catch(err => console.log(err))
    },

    createEvent (payload, eventData) {
      console.log(payload)
      const headers = {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token').toString()
        }
      }
      axios.post('http://localhost:5103/api/event', {
        title: eventData.title,
        category: eventData.category,
        subcategory: eventData.subcategory,
        eventStartDate: eventData.eventStartDate,
        city: eventData.city,
        address: eventData.address,
        recurring: eventData.recurring,
        peopleNeeded: eventData.peopleNeeded,
        description: eventData.description,
        eventStatus: 1
      }, headers)
        .then(response => {
          console.log(eventData)
          console.log(response)
        }).catch(error => {
          console.log(error)
        })
    },

    addSubCategory ({ state }, data) {
      console.log(data)
      const headers = {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token').toString()
        }
      }
      axios.post('http://localhost:5103/api/category/' + data.category, {
        name: data.subName
      }, headers).then(() => {
        state.filters.subCategories.push(data.subName)
      }).catch(error => console.log(error))
    },

    fetchEventById ({ commit }, eventId) {
      axios.get('http://localhost:5103/api/event/' + eventId)
        .then(currentEvent => {
          commit('setCurrentEvent', currentEvent)
        })
        .catch(error => {
          console.log(error)
        })
    },

    joinEvent ({ state }) {
      // TODO: add this event
    },

    addComment (payload, data) {
      const headers = {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token').toString()
        }
      }
      axios.post('http://localhost:5101/comments', {
        eventId: data.eventId,
        message: data.message
      }, headers).then(response => {
        console.log(response)
      }).catch(error => console.log(error))
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
    },
    currentEvent: (state) => {
      return state.currentEvent
    }
  }
}
