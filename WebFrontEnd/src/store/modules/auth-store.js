import Vue from 'vue'
import Vuex from 'vuex'
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
      }, 21600 * 1000) // logout 6 hours after logging in
    },
    register ({ dispatch }, authData) {
      axiosAuth.post('users', {
        email: authData.email,
        username: authData.username,
        password: authData.password,
        crossdomain: true
      })
        .then(() => {
          dispatch('login', authData)
        })
        .catch(error => console.log(error))
    },

    login ({ commit, dispatch }, authData) {
      axiosAuth.post('login', {
        username: authData.username,
        password: authData.password
      })
        .then(res => {
          const now = new Date()
          const expirationDate = new Date(now.getTime() + 21600 * 1000) // 6 hours after login
          localStorage.setItem('token', res.data.accessToken)
          localStorage.setItem('userId', res.data.id)
          localStorage.setItem('expirationDate', expirationDate)
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
    updateProfileSettings ({ state, dispatch }, formData) {
      let password
      if (formData.newPassword === null) {
        password = formData.password
      } else {
        password = formData.newPassword
      }
      const headers = {
        headers: {
          Authorization: 'Bearer ' + state.idToken
        }
      }
      axiosAuth.put('users/' + state.userId,
                  {
                    username: formData.username,
                    email: formData.email,
                    password: password
                  },
                   headers)
        .then(() => {
          dispatch('logout')
        })
        .catch(res => console.log(res))
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
