<template>
  <!-- Navbar -->
  <b-container fluid>
    <div>
      <b-row>
        <b-navbar toggleable="lg" type="dark" class="fixed-top justify-content-between">
          <router-link to="/"><b-navbar-brand>Let's Play</b-navbar-brand></router-link>

          <b-navbar-nav center class="right">
            <router-link to="/createEvent">
            <b-button class=" yellowbtn mb-2" size="lg">
              Create Event
              <b-icon icon="plus"></b-icon>
            </b-button>
            </router-link>
          </b-navbar-nav>
<b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
          <div>
            <router-link to="/login"
                         v-if="!auth">
              <b-button class="yellowbtn">
                <strong>Login</strong>
              </b-button>
            </router-link>
            <router-link to="/register"
                         v-if="!auth">
              <b-button class="yellowbtn">
                <strong>Register</strong>
              </b-button>
            </router-link>

            <b-collapse id="nav-collapse" is-nav>
              <!-- Right aligned nav items -->
              <b-navbar-nav class="mr-auto">
                <b-nav-item-dropdown right
                                     v-if="auth">
                  <!-- Using 'button-content' slot -->
                  <template v-slot:button-content>
                    <em>
                      <strong>Username</strong>
                    </em>
                  </template>
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
          </div>
        </b-navbar>
      </b-row>
    </div>
  </b-container>
</template>

<script>
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
}
</script>

<style scoped>
.fixed-top{
background: #7DA2A9;
}
.right{
  padding-left:50px;
}
.yellowbtn{
  background: rgb(250, 220, 85);
  padding-left: 3%;
}
</style>
