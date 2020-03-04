<template>
<!-- Navbar -->

     <b-navbar toggleable="lg" type="dark" variant="danger">
       <b-navbar-brand href="#">LetsPlay</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

           <b-collapse id="nav-collapse" is-nav >

           <b-button-toolbar class="ml-auto">
             <b-button-group class="ml-auto">

                <router-link to="/">
              <b-button title="Category">
                 <b-icon icon="filter" font-scale="2.5" aria-hidden="true"></b-icon>
              </b-button>
              </router-link>

            <router-link to="/createEvent">
              <b-button title="CreatEvent">
                 <b-icon icon="plus"  font-scale="2.5" aria-hidden="true"></b-icon>
              </b-button>
            </router-link>

               <router-link to="/profile">
              <b-button title="Profile">
                 <b-icon icon="person-fill" font-scale="2.5" aria-hidden="true"></b-icon>
              </b-button>
              </router-link>

             </b-button-group>
           </b-button-toolbar>

                <!-- Right aligned nav items -->
                    <b-navbar-nav class="ml-auto">
                        <b-nav-item-dropdown right>
                         <!-- Using 'button-content' slot -->
                             <template v-slot:button-content>
                               <em>User</em>
                             </template>
                           <b-dropdown-item href="#">Profile</b-dropdown-item>
                           <b-dropdown-item href="#">Sign Out</b-dropdown-item>
                        </b-nav-item-dropdown>
                    </b-navbar-nav>
              </b-collapse>
        </b-navbar>
</template>

<script>
export default {
  name: 'Header'
}
</script>

<style lang="scss">

</style>
