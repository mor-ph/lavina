import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import CreateEvent from '../views/CreateEvent.vue'
import Profile from '../views/Profile.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/createEvent',
    name: 'CreateEvent',
    component: CreateEvent
  },
  {
    path: '/profle',
    name: 'Profile',
    component: Profile
  }
]

export default new VueRouter({ mode: 'history', routes })
