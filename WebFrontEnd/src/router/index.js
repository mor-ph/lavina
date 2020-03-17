import Vue from 'vue'
import VueRouter from 'vue-router'
// import store from '../store'
import Home from '../pages/Events/Home.vue'

const CurrentEvent = resolve => {
  require.ensure(['../pages/Events/CurrentEvent.vue'], () => {
    resolve(require('../pages/Events/CurrentEvent.vue'))
  })
}

const CreateEvent = resolve => {
  require.ensure(['../pages/CreateEvent/CreateEvent.vue'], () => {
    resolve(require('../pages/CreateEvent/CreateEvent.vue'))
  })
}

const Profile = resolve => {
  require.ensure(['../pages/Profile/Profile.vue'], () => {
    resolve(require('../pages/Profile/Profile.vue'))
  })
}
const Login = resolve => {
  require.ensure(['../pages/Auth/Login.vue'], () => {
    resolve(require('../pages/Auth/Login.vue'))
  })
}
const Register = resolve => {
  require.ensure(['../pages/Auth/Register.vue'], () => {
    resolve(require('../pages/Auth/Register.vue'))
  })
}

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/event/:title&:id',
    name: 'CurrentEvent',
    component: CurrentEvent
  },
  {
    path: '/createEvent',
    name: 'CreateEvent',
    component: CreateEvent//,
    // beforeEnter (to, from, next) {
    //   console.log(store.state.auth.idToken)
    //   if (store.state.auth.idToken) {
    //     next()
    //   } else {
    //     next('/login')
    //   }
    // }
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile//,
    // beforeEnter (to, from, next) {
    //   if (store.state.auth.idToken) {
    //     next()
    //   } else {
    //     next('/login')
    //   }
    // }
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
  },
  {
    path: '*',
    redirect: '/'
  }
]

export default new VueRouter({ mode: 'history', routes })
