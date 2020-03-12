<template>
  <!-- Navbar -->
  <b-container fluid>
    <b-row>
      <b-navbar toggleable="lg" type="dark" class="fixed-top justify-content-between">
        <b-col>
          <router-link to="/">
            <b-navbar-brand>Let's Play</b-navbar-brand>
          </router-link>
        </b-col>
        <hide-at  breakpoint="small">
          <b-col class="create md-4">
            <b-navbar-nav>
              <div class="cr">
                <router-link to="/createEvent">
                  <b-button class="yellowbtn cr mb-2" size="lg"> <!--size="lg"-->
                    Create Event
                    <b-icon icon="plus"></b-icon>
                  </b-button>
                </router-link>
              </div>
            </b-navbar-nav>
          </b-col>
        </hide-at>
        <show-at :breakpoints="{small: 666, medium: 1000, large: 1600}" breakpoint="small">
          <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
        </show-at>
        <hide-at breakpoint="small">
          <b-col class="loginreg">
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
          </b-col>
          <show-at :breakpoints="{small: 666, medium: 1000, large: 1600}" breakpoint="mediumAndAbove">
            <b-collapse id="nav-collapse" is-nav>
              <!-- Right aligned nav items -->
              <b-navbar-nav class="mr-auto">
                <b-nav-item-dropdown right><!-- v-if="auth">-->
                  <!-- Using 'button-content' slot -->
                  <!-- <template v-slot:button-content>
                    <em>
                      <strong>Username</strong>
                    </em>
                  </template> -->
                  <b-dropdown-item to="profile">
                    Profile
                    <b-icon icon="person-fill"></b-icon>
                  </b-dropdown-item>
                  <b-dropdown-item @click="onLogout">
                    Sign Out
                    <b-icon icon="box-arrow-right"></b-icon>
                  </b-dropdown-item>
                </b-nav-item-dropdown>
              </b-navbar-nav>
            </b-collapse>
            </show-at>
        </hide-at>
      </b-navbar>
    </b-row>
  </b-container>
</template>

<script>
import { showAt, hideAt } from 'vue-breakpoints'
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
  },
  components: { hideAt, showAt }
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
}
</style>
