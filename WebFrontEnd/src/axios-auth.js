import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:8081/auth'
})
instance.defaults.headers.Authorization = localStorage.getItem('token')

export default instance
