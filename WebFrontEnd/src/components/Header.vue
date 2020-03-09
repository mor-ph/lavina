<template>
  <!-- Navbar -->
  <b-container fluid>
    <div>
      <b-row>
        <b-navbar toggleable="lg" type="dark" variant="info" class="fixed-top justify-content-between">
          <router-link to="/"><b-navbar-brand>Let's Play</b-navbar-brand></router-link>

          <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

          <b-navbar-nav center class="right">
            <router-link to="/createEvent">
            <b-button class="mb-2" size="lg">
              Create Event
              <b-icon icon="plus"></b-icon>
            </b-button>
            </router-link>
          </b-navbar-nav>

          <div>
            <router-link to="/login">
              <b-button class="colorbutton">
                <strong>Login</strong>
              </b-button>
            </router-link>
            <router-link to="/register">
              <b-button class="colorbutton">
                <strong>Register</strong>
              </b-button>
            </router-link>

            <b-collapse id="nav-collapse" is-nav>
              <!-- Right aligned nav items -->
              <b-navbar-nav class="mr-auto">
                <b-nav-item-dropdown right>
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
      // this.$store.dispatch('logout')
      console.log('logged out')
    }
  }
}
</script>

<style scoped>
.fixed-top{
background: rgb(63,167,167);
background: linear-gradient(180deg, rgba(63,167,167,1) 5%, rgba(194,255,247,1) 100%);
}
.right{
  padding-left:50px;
}
</style>
