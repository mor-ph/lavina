import Vue from 'vue'
import Vuex from 'vuex'
import authApi from '../../api/authApi'
import router from '../../router'
import jwtDecode from 'jwt-decode'

Vue.use(Vuex)

export default {
  state: {
    idToken: null,
    userId: null,
    user: {
      username: null,
      email: null
    }
  },
  mutations: {
    authUser (state, userData) {
      state.idToken = userData.token
      state.userId = userData.userId
    },
    storeUser (state, user) {
      state.user = user
    },
    clearAuthData (state) {
      state.idToken = null
      state.userId = null
    }
  },
  actions: {
    async register ({ dispatch }, formData) {
      await authApi.register(formData)
      dispatch('login', formData)
    },

    async login ({ commit, dispatch }, authData) {
      const response = await authApi.login(authData)

      const token = jwtDecode(response.data.accessToken)
      const expirationDate = new Date(token.exp * 1000)

      localStorage.setItem('token', response.data.accessToken)
      localStorage.setItem('userId', token.userId)
      localStorage.setItem('expirationDate', expirationDate)

      commit('authUser', {
        token: response.data.accessToken,
        userId: response.data.id
      })
      dispatch('getUserById')

      const now = new Date()
      dispatch('setLogoutTimer', expirationDate.getTime() - now.getTime())
      router.replace('/')
    },

    setLogoutTimer ({ commit }, milliseconds) {
      setTimeout(() => {
        commit('clearAuthData')
      }, milliseconds)
    },

    logout ({ commit }) {
      commit('clearAuthData')
      localStorage.removeItem('expirationDate')
      localStorage.removeItem('token')
      localStorage.removeItem('userId')
    },

    tryAutoLogin ({ commit, dispatch, state }) {
      const token = localStorage.getItem('token')
      if (!token || state.idToken) {
        return
      }

      const expirationDate = new Date(localStorage.getItem('expirationDate'))
      const now = new Date()
      if (now >= expirationDate) {
        return
      }

      const userId = localStorage.getItem('userId')
      commit('authUser', {
        token: token,
        userId: userId
      })

      dispatch('getUserById')
      dispatch('setLogoutTimer', expirationDate.getTime() - now.getTime())
    },

    async updateProfile ({ state, dispatch }, formData) {
      if (formData.password === null) {
        formData = {
          username: formData.username,
          email: formData.email
        }
      }
      await authApi.updateProfile(state.userId, formData, state.idToken)
      dispatch('logout')
      router.replace('/login')
    },

    async getUserById ({ commit, state }) {
      try {
        const response = await authApi.getUserById(state.userId, state.idToken)
        commit('storeUser', {
          username: response.data.username,
          email: response.data.email
        })
      } catch (error) {
        console.log(error)
      }
    }
  },
  getters: {
    user: (state) => {
      return state.user
    },
    isAuthenticated: (state) => {
      return state.idToken !== null
    },
    token: (state) => {
      return state.idToken
    },
    userId: (state) => {
      return state.userId
    }
  }
}
