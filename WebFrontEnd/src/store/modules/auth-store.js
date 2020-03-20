import Vue from 'vue'
import Vuex from 'vuex'
import axiosAuth from '../../axios-auth'
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
    setLogoutTimer ({ commit }, milliseconds) {
      setTimeout(() => {
        commit('clearAuthData')
      }, milliseconds)
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
          const decoded = jwtDecode(res.data.accessToken)
          console.log(decoded.exp)
          const expirationDate = new Date(decoded.exp * 1000)
          localStorage.setItem('token', res.data.accessToken)
          localStorage.setItem('userId', decoded.userId)
          localStorage.setItem('expirationDate', expirationDate)
          commit('authUser', {
            token: res.data.accessToken,
            userId: res.data.id
          })
          dispatch('fetchUserById')
          const now = new Date()

          dispatch('setLogoutTimer', expirationDate.getTime() - now.getTime())
          router.replace('/')
        })
        .catch(error => {
          console.log(error)
        })
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
      dispatch('fetchUserById')
      dispatch('setLogoutTimer', expirationDate.getTime() - now.getTime())
    },
    logout ({ commit }) {
      commit('clearAuthData')
      localStorage.removeItem('expirationDate')
      localStorage.removeItem('token')
      localStorage.removeItem('userId')
      router.replace('/')
    },
    updateProfileSettings ({ state, dispatch }, formData) {
      const headers = {
        headers: {
          Authorization: 'Bearer ' + state.idToken
        }
      }
      if (formData.password === null) {
        formData = {
          username: formData.username,
          email: formData.email
        }
      }
      axiosAuth.put(
        'users/' + state.userId, formData, headers)
        .then(() => {
          dispatch('logout')
        })
        .catch(res => console.log(res))
    },
    fetchUserById ({ commit, state }) {
      const headers = {
        headers: {
          Authorization: 'Bearer ' + state.idToken
        }
      }
      axiosAuth.get('users/' + state.userId, headers)
        .then((res) => {
          commit('storeUser', {
            username: res.data.username,
            email: res.data.email
          })
        }).catch(error => console.log(error))
    }
  },
  getters: {
    getUser: (state) => {
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
