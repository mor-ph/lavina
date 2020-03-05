<template>
  <!-- Navbar -->
  <b-container fluid>
    <b-row  >
      <b-navbar toggleable="lg" type="dark" class="fixed-top">
        <b-col sm="5">
          <b-navbar-brand href="#">
            <strong>LetsPlay</strong>
          </b-navbar-brand>
        </b-col>

        <b-col sm="5">
          <b-button-toolbar>
            <b-button-group>
              <router-link to="/">
                <b-button title="Category" class="colorbutton">
                  <b-icon icon="filter" font-scale="2.5" aria-hidden="true"></b-icon>
                </b-button>
              </router-link>

              <router-link to="/createEvent">
                <b-button title="CreatEvent" class="colorbutton">
                  <b-icon icon="plus" font-scale="2.5" aria-hidden="true"></b-icon>
                </b-button>
              </router-link>

              <router-link to="/profile">
                <b-button title="Profil" class="colorbutton">
                  <b-icon icon="person-fill" font-scale="2.5" aria-hidden="true"></b-icon>
                </b-button>
              </router-link>
            </b-button-group>
          </b-button-toolbar>
        </b-col>

        <!-- Right aligned nav items -->

        <b-col sm="2">
          <b-navbar-nav class="ml-auto">
            <b-navbar-nav>
              <div>
                <router-link to="/login">
                  <b-button class="colorbutton"><strong>Login</strong></b-button>
                </router-link>
                <router-link to="/register">
                  <b-button class="colorbutton"><strong>Register</strong></b-button>
                </router-link>
              </div>
            </b-navbar-nav>
          </b-navbar-nav>
        </b-col>
      </b-navbar>
    </b-row>
  </b-container>
</template>

<script>
</script>

<style scoped>

.fixed-top {
  background: #7DA2A9;
}
.colorbutton {
  background: rgb(250, 220, 85);
}
/*.colorbutton{
 background: rgb(33,62,62);
background: linear-gradient(180deg, rgba(33,62,62,1) 0%, rgba(0,215,255,1) 100%);
}*/
</style>
