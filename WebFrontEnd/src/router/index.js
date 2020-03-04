import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Events/Home.vue'
import CreateEvent from '../components/CreateEvent/CreateEvent.vue'
import Profile from '../components/Profile/Profile.vue'

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
