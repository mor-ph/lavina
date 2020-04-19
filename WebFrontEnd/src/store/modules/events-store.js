import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import eventApi from '../../api/eventApi'

Vue.use(Vuex)

export default {
  state: {
    refreshed: false,
    events: [],
    filters: {
      category: [],
      subcategories: [],
      location: [],
      orderBy: [
        { value: 'created_date', text: 'Recent' },
        { value: 'start_date', text: 'Date' }]
    },
    selectedFilters: {
      category: null,
      subcategory: null,
      location: null,
      date: null,
      orderBy: 'created_date'
    }
  },
  mutations: {
    setEvents (state, events) {
      state.events = events
    },
    emptySubcategoriesArray (state) {
      state.filters.subcategories = [{ value: null, text: 'All' }]
      state.selectedFilters.subcategory = null
    },
    changeRefreshed (state) {
      state.refreshed = !state.refreshed
    },
    emptyCategoryAndLocationArray (state) {
      state.filters.category = [{ value: null, text: 'All' }]
      state.filters.location = [{ value: null, text: 'All' }]
    },
    setCurrentEvent (state, currentEvent) {
      state.currentEvent = []
      state.currentEvent = currentEvent
    }
  },
  actions: {
    loadInitalState ({ dispatch, commit, state }) {
      if (!state.refreshed) {
        commit('changeRefreshed')
        const recentEvents = dispatch('fetchRecentEvents')
        const filters = dispatch('fetchFilters')
        return Promise.all([recentEvents, filters])
      }
    },

    async fetchRecentEvents ({ commit }) {
      try {
        const events = await eventApi.getRecentEvents()
        commit('setEvents', events.data)
      } catch (error) { console.log(error) }
    },

    fetchFilters ({ dispatch, commit }) {
      commit('emptyCategoryAndLocationArray')
      const categories = dispatch('fetchCategories')
      const locations = dispatch('fetchLocations')

      return Promise.all([categories, locations])
    },

    async fetchCategories ({ state }) {
      try {
        const categories = await eventApi.getCategories()
        categories.data.map(category => {
          state.filters.category.push(category.name)
        })
      } catch (error) { console.log(error) }
    },

    fetchLocations ({ state }) {
      axios.get('http://localhost:5103/api/location')
        .then(locations => {
          locations.data.map(location => {
            state.filters.location.push(location.name)
          })
        }).catch(err => console.log(err))
    },

    async fetchFilteredEvents ({ commit, state }) {
      const filters = {
        category: state.selectedFilters.category,
        subCategory: state.selectedFilters.subcategory,
        location: state.selectedFilters.location,
        date: state.selectedFilters.date,
        sortOrder: state.selectedFilters.orderBy
      }
      try {
        const events = await eventApi.getFilteredEvents(filters)
        commit('setEvents', events.data)
      } catch (error) { console.log(error) }
    },

    async fetchSubcategories ({ state, commit }, category) {
      if (category === null) return
      commit('emptySubcategoriesArray')
      try {
        const subCategories = await eventApi.getSubcategories(category)
        subCategories.data.map(subcategory => {
          state.filters.subcategories.push(subcategory.name)
        })
      } catch (error) { console.log(error) }
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
