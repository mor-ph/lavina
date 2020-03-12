import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:8081/auth'
})

export default instance
