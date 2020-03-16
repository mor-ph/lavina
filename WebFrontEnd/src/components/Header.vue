<template>
  <!-- Navbar -->
  <b-container fluid>
    <b-row>
      <b-navbar toggleable="lg" type="dark" class="fixed-top justify-content-between">
        <b-col style="padding-left:0">
          <router-link to="/">
            <img src="./lavina-logo.png" alt="logo" width="50px" height="50px" style="padding-right:3px">
            <b-navbar-brand id="lavina">LAVINA</b-navbar-brand>
          </router-link>
        </b-col>
        <b-col class="create cr" v-if="$mq === 'tablet' || $mq === 'desktop'">
            <div >
                <b-navbar-nav>
                  <div class="cr">
                    <router-link to="/createEvent" class="aCr">
                      <b-button class="yellowbtn mb-2" size="lg">
                        Create Event
                        <b-icon icon="plus"></b-icon>
                      </b-button>
                    </router-link>
                  </div>
                </b-navbar-nav>
            </div>
        </b-col>
        <b-col class="loginreg" v-if="$mq === 'tablet' || $mq === 'desktop'">
            <div >
                <b-icon v-if="auth" icon="person-fill" ></b-icon>
                <router-link v-if="auth" to="/profile" class="hLink">Profile</router-link>
                <router-link v-if="!auth" to="/login" class="hLink">Login</router-link>
                <span style="color:white"> | </span>
                <router-link v-if="!auth" to="/register"  class="hLink">Register</router-link>
                <b-icon v-if="auth" icon="box-arrow-right" ></b-icon>
                <router-link v-if="auth" @click.native="onLogout" to="/" class="hLink">Log out</router-link>
            </div>
        </b-col>
        <b-navbar-toggle target="nav-collapse" v-if="$mq === 'mobile'"></b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav v-if="$mq === 'mobile'" style="padding-top:3px">
          <b-navbar-nav class="mr-auto dropNav" v-if="$mq === 'mobile'" >
            <b-dropdown-item class="dItem" to="profile" v-if="auth"  variant="light">
              <b-icon icon="person-fill"></b-icon> Profile
            </b-dropdown-item>
            <b-dropdown-item class="text-white" to="home" variant="light">All Events</b-dropdown-item>
            <b-dropdown-item to="CreateEvent"  variant="light">Create Event</b-dropdown-item>
            <div class="dropdown-divider"></div>
            <b-dropdown-item class="dItem" @click="onLogout"  v-if="auth" variant="light">
              <b-icon icon="box-arrow-right"></b-icon> Log out
            </b-dropdown-item>
            <b-dropdown-item class="dItem" to="/login" v-if="!auth" variant="light">Log in</b-dropdown-item>
            <b-dropdown-item class="dItem" to="/register" v-if="!auth" variant="light">Register</b-dropdown-item>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
    </b-row>
  </b-container>
</template>

<script>
// import { showAt, hideAt } from 'vue-breakpoints'
import Vue from 'vue'
import VueMq from 'vue-mq'

Vue.use(VueMq, {
  breakpoints: {
    mobile: 666,
    tablet: 1000,
    desktop: Infinity
  }
})

export default {
  methods: {
    onLogout () {
      this.$store.dispatch('logout')
      console.log('logged out')
    }
  },
  computed: {
    auth () {
      return this.$store.getters.isAuthenticated
    }
  }
  // components: { hideAt, showAt }
}

</script>

<style scoped>
.fixed-top {
  background: #7da2a9;
   }
 .yellowbtn {
  background: white;
  color: rgb(60, 71, 78);
  /* align-self: center; */
  border-color: darkgray;
}
.loginreg{
  text-align: end;
}
 .cr{
  align-self: center;
  display: flex;
  align-items: center;
  justify-content: center;
}
.aCr{
  align-self: center;
}
#nav-collapse{
  text-align: end;
}
.hLink{
  color: white;
  padding: 1%;
}
#lavina{
    font-size: small;
    position: absolute;
    padding-top: 0;
    padding-top: 35px;
}
.dropdown-item:hover{
  color:rgb(60, 71, 78);
}
.b-icon{
  color: ivory;
}
</style>
