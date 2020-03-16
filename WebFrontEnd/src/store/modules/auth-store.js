import Vue from 'vue'
import Vuex from 'vuex'
// import axios from 'axios' if we make fetchUser
import axiosAuth from '../../axios-auth'

import router from '../../router'

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
    setLogoutTimer ({ commit }) {
      setTimeout(() => {
        commit('clearAuthData')
      }, 3600 * 1000)
    },
    signup ({ commit, dispatch }, authData) {
      console.log(authData)
      axiosAuth.post('users', {
        email: authData.email,
        username: authData.username,
        password: authData.password,
        crossdomain: true
      })
        .then(res => {
          console.log(res)
          commit('authUser', {
            token: res.data.accessToken,
            userId: res.data.id
          })
          const now = new Date()
          const expirationDate = new Date(now.getTime() + 3600 * 1000)
          localStorage.setItem('token', res.data.accessToken)
          localStorage.setItem('userId', res.data.id)
          localStorage.setItem('expirationDate', expirationDate)
          dispatch('setLogoutTimer')
          router.replace('/')
        })
        .catch(error => console.log(error))
    },

    login ({ commit, dispatch }, authData) {
      console.log(authData)
      axiosAuth.post('login', {
        username: authData.username,
        password: authData.password
      })
        .then(res => {
          const now = new Date()
          const expirationDate = new Date(now.getTime() + 3600 * 1000)
          localStorage.setItem('token', res.data.accessToken)
          localStorage.setItem('userId', res.data.id)
          localStorage.setItem('expirationDate', expirationDate)
          console.log('USERDATA', {
            token: res.data.accessToken,
            id: res.data.id
          })
          commit('authUser', {
            token: res.data.accessToken,
            userId: res.data.id
          })
          commit('storeUser', {
            username: res.data.username,
            email: res.data.email
          })
          dispatch('setLogoutTimer')
          router.replace('/')
        })
        .catch(error => console.log(error))
    },
    tryAutoLogin ({ commit }) {
      const token = localStorage.getItem('token')
      if (!token) {
        return
      }
      const expirationDate = localStorage.getItem('expirationDate')
      const now = new Date()
      if (now >= expirationDate) {
        return
      }
      const userId = localStorage.getItem('userId')
      // dispatch fetchUser by ID
      commit('authUser', {
        token: token,
        userId: userId
      })
    },
    logout ({ commit }) {
      commit('clearAuthData')
      localStorage.removeItem('expirationDate')
      localStorage.removeItem('token')
      localStorage.removeItem('userId')
      router.replace('/')
    },
    updateProfileSettings ({ state }, formData) {
      let password
      if (formData.newPassword === null) {
        password = formData.password
      } else {
        password = formData.newPassword
      }
      axiosAuth.put('users/' + state.userId, {
        username: formData.username,
        email: formData.email,
        password: password
      })
    }
  },
  getters: {
    getUser: (state) => {
      return state.user
    },
    isAuthenticated: (state) => {
      return state.idToken !== null
    }
  }
}
