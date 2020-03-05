import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Events/Home.vue'
import CreateEvent from '../components/CreateEvent/CreateEvent.vue'
import Profile from '../components/Profile/Profile.vue'
import Login from '../components/Auth/Login.vue'
import Register from '../components/Auth/Register.vue'

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
    path: '/profile',
    name: 'Profile',
    component: Profile
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  }
]

export default new VueRouter({ mode: 'history', routes })
