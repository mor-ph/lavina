import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:5103/api'
})

export function getUserEvents (token) {
  const headers = { Authorization: `Bearer ${token}` }
  return instance.get('event/da', { headers })
}

export function getEventById (eventId) {
  return instance.get(`event/${eventId}`)
}

export function joinToEvent (eventId, userId, token) {
  const headers = { Authorization: `Bearer ${token}` }
  return instance.post('event/userevents', { eventId: eventId, userId: userId }, { headers })
}

export function postSubCategory (category, subCategoryName, token) {
  const headers = { Authorization: `Bearer ${token}` }
  return instance.post(`category/${category}`, { name: subCategoryName }, { headers })
}

export function createEvent (formData, token) {
  const headers = { Authorization: `Bearer ${token}` }
  return instance.post('event', formData, { headers })
}

export default {
  getRecentEvents: () => instance.get('event'),

  getFilteredEvents: (params) => instance.get('event', { params }),

  getCategories: () => instance.get('category/main'),

  getSubcategories: (category) => instance.get(`category/getsub/${category}`)
}
