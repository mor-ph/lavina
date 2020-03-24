import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:8081/auth'
})

export function checkEmail (email) {
  return instance.get(`email/${email}`)
}

export function checkUsername (username) {
  return instance.get(`username/${username}`)
}

export default {
  register: formData => instance.post('users', formData),

  login: authData => instance.post('login', authData),

  updateProfile: (userId, formData, token) => {
    const headers = { Authorization: `Bearer ${token}` }
    return instance.put(`users/${userId}`, formData, { headers })
  },

  getUserById: (userId, token) => {
    const headers = { Authorization: `Bearer ${token}` }
    return instance.get(`users/${userId}`, { headers })
  }
}
