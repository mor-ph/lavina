import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:5101'
})

export default {
  postComment: (eventId, comment, token) => {
    const headers = { Authorization: `Bearer ${token}` }
    return instance.post('comments', { eventId: eventId, message: comment }, { headers })
  }
}
