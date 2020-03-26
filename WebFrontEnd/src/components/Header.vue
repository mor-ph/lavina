<template>
  <!-- Navbar -->
  <b-container fluid id="header">
    <b-row>
      <b-navbar toggleable="lg" type="dark" class="fixed-top justify-content-between">
        <b-col style="padding-left:0">
          <router-link to="/">
            <img src="./lavina-logo_50x50.png" alt="logo" width="50px" height="50px" style="padding-right:3px">
            <b-navbar-brand id="lavina">LAVINA</b-navbar-brand>
          </router-link>
        </b-col>
        <b-col class="create cr" v-if="$mq === 'tablet' || $mq === 'desktop'">
            <div >
                <b-navbar-nav>
                  <div class="cr">
                    <router-link to="/createEvent" class="aCr">
                      <b-button class="yellowbtn mb-1" size="lg">
                        Create Event
                        <b-icon id="plusIcon" icon="plus" ></b-icon>
                      </b-button>
                    </router-link>
                  </div>
                </b-navbar-nav>
            </div>
        </b-col>
        <b-col class="loginreg" v-if="$mq === 'tablet' || $mq === 'desktop'">
            <div >
                <b-icon v-if="isAuthenticated" icon="person-fill" class="hicon"></b-icon>
                <router-link v-if="isAuthenticated" to="/profile" class="hLink">Profile</router-link>
                <router-link v-if="!isAuthenticated" to="/login" class="hLink">Log in</router-link>
                <span style="color:white"> | </span>
                <router-link v-if="!isAuthenticated" to="/register"  class="hLink">Register</router-link>
                <b-icon v-if="isAuthenticated" icon="box-arrow-right" class="hicon"></b-icon>
                <router-link v-if="isAuthenticated" @click.native="logout" to="/" class="hLink">Log out</router-link>
            </div>
        </b-col>
        <b-navbar-toggle target="nav-collapse" v-if="$mq === 'mobile'"></b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav v-if="$mq === 'mobile'" style="padding-top:3px">
          <b-navbar-nav class="mr-auto dropNav" v-if="$mq === 'mobile'" >
            <b-dropdown-item class="dItem" to="profile" v-if="isAuthenticated"  variant="light">
              <b-icon icon="person-fill" class="hicon"></b-icon> Profile
            </b-dropdown-item>
            <b-dropdown-item class="text-white" to="home" variant="light">All Events</b-dropdown-item>
            <b-dropdown-item to="CreateEvent"  variant="light">Create Event</b-dropdown-item>
            <div class="dropdown-divider"></div>
            <b-dropdown-item class="dItem" @click="logout"  v-if="isAuthenticated" variant="light">
              <b-icon icon="box-arrow-right" class="hicon"></b-icon> Log out
            </b-dropdown-item>
            <b-dropdown-item class="dItem" to="/login" v-if="!isAuthenticated" variant="light">Log in</b-dropdown-item>
            <b-dropdown-item class="dItem" to="/register" v-if="!isAuthenticated" variant="light">Register</b-dropdown-item>
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
import { mapActions, mapGetters } from 'vuex'

Vue.use(VueMq, {
  breakpoints: {
    mobile: 666,
    tablet: 1000,
    desktop: Infinity
  }
})

export default {
  methods: {
    ...mapActions(['logout'])
  },
  computed: {
    ...mapGetters(['isAuthenticated'])
  }
}

</script>

<style scoped>
.fixed-top {
  background: rgb(125, 162, 169, 0.88);
   }
 .yellowbtn {
  background: rgb(255, 255, 255,0.95);
  color: rgb(60, 71, 78);
  /* align-self: center; */
  border-color: darkgray;
  /* border-style: hidden; */
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
    padding-top: 45px;
}
.dropdown-item:hover{
  color:rgb(60, 71, 78);
}
.hicon{
  color: ivory;
}
.yellowbtn :hover{
  color: ivory;
}
</style>
