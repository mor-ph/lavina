<template>
<!-- Navbar -->
   <div class="container">
   <div class="row">
     <b-navbar toggleable="lg" type="dark" variant="primary" class="fixed-top">
       <b-navbar-brand href="#">LetsPlay</b-navbar-brand>

            <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
                <b-collapse id="nav-collapse" is-nav >

           <b-button-toolbar class="ml-auto">
             <b-button-group class="center">

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

                <!-- Right aligned nav items -->

                    <b-navbar-nav class="ml-auto">
                        <b-navbar-nav>
                                <div>
                                   <router-link to="/login">
                                    <b-button size="lg">Login</b-button>
                                    </router-link>
                                    <router-link to="/register">
                                    <b-button size="lg">Register</b-button>
                                    </router-link>
                                 </div>
                      </b-navbar-nav>
                    </b-navbar-nav>
              </b-collapse>
        </b-navbar>
        </div>
   </div>
</template>

<script>

</script>

<style lang="scss">

</style>
