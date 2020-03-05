<template>
  <!-- Navbar -->
  <b-container fluid>
    <b-row>
      <b-navbar toggleable="lg" type="dark" variant="success" class="fixed-top">
        <b-col sm="5">
          <b-navbar-brand href="#">
            <strong>LetsPlay</strong>
          </b-navbar-brand>
        </b-col>

        <b-col sm="5">
          <b-button-toolbar>
            <b-button-group>
              <router-link to="/">
                <b-button title="Category">
                  <b-icon icon="filter" font-scale="2.5" aria-hidden="true"></b-icon>
                </b-button>
              </router-link>

              <router-link to="/createEvent">
                <b-button title="CreatEvent">
                  <b-icon icon="plus" font-scale="2.5" aria-hidden="true"></b-icon>
                </b-button>
              </router-link>

              <router-link to="/profile">
                <b-button title="Profil">
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
                  <b-button><strong>Login</strong></b-button>
                </router-link>
                <router-link to="/register">
                  <b-button><strong>Register</strong></b-button>
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

<style lang="scss">
</style>
