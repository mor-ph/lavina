<template>
  <!-- Navbar -->
  <b-container fluid>
    <b-row>
      <b-navbar toggleable="lg" type="dark" class="fixed-top justify-content-between">
        <b-col>
          <router-link to="/">
            <b-navbar-brand>LAVINA</b-navbar-brand>
          </router-link>
        </b-col>
        <b-col class="create cr" v-if="$mq === 'tablet' || $mq === 'desktop'">
            <div ><!-- class="cr">-->
              <!-- <b-col class="create"> -->
                <b-navbar-nav>
                  <div class="cr">
                    <router-link to="/createEvent" class="aCr">
                      <b-button class="yellowbtn mb-2" size="lg"> <!--size="lg"-->
                        Create Event
                        <b-icon icon="plus"></b-icon>
                      </b-button>
                    </router-link>
                  </div>
                </b-navbar-nav>
              <!-- </b-col> -->
            </div>
        </b-col>
        <b-col class="loginreg" v-if="$mq === 'tablet' || $mq === 'desktop'">
            <div >
                <router-link to="/login" v-if="!auth">
                  <b-button class="yellowbtn">
                    <strong>Login</strong>
                  </b-button>
                </router-link>
                <router-link to="/register" v-if="!auth">
                  <b-button class="yellowbtn">
                    <strong>Register</strong>
                  </b-button>
                </router-link>
            </div>
        </b-col>
        <b-navbar-toggle target="nav-collapse" v-if="$mq === 'mobile'"></b-navbar-toggle>
        <!-- <div v-if="$mq === 'mobile'"> --><b-collapse id="nav-collapse" is-nav v-if="$mq === 'mobile'">
                <!-- Right aligned nav items -->
                <b-navbar-nav class="mr-auto dropNav" v-if="$mq === 'mobile'">
                  <!-- <b-nav-item-dropdown target="nav-collapse"  right> -->
                    <b-dropdown-item class="dItem" to="profile"  v-if="auth">Profile
                      <b-icon icon="person-fill"></b-icon>
                    </b-dropdown-item>
                    <b-dropdown-item class="dItem" to="home">All Events</b-dropdown-item>
                    <b-dropdown-item class="dItem" to="CreateEvent">Create Event</b-dropdown-item>
                    <div class="dropdown-divider"></div>
                    <b-dropdown-item class="dItem" @click="onLogout"  v-if="auth">Sign Out
                      <b-icon icon="box-arrow-right"></b-icon>
                    </b-dropdown-item>
                    <b-dropdown-item class="dItem" to="/login" v-if="!auth">Log in</b-dropdown-item>
                    <b-dropdown-item class="dItem" to="/register" v-if="!auth">Register</b-dropdown-item>
                </b-navbar-nav>
              </b-collapse>
            <!-- </div> -->
            <!-- </show-at> -->
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
/*.right {
  padding-left: 50px;
} */
.yellowbtn {
  background: rgb(250, 220, 85);
  /* padding: 3%; */
  color: rgb(60, 71, 78);
  align-self: center;
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
.dropdown-item{
   text-align: end;
  color:ivory;
}
.aCr{
  align-self: center;
}
#nav-collapse{
  text-align: end;
}
.dItem{
  color:ivory;
}
</style>
