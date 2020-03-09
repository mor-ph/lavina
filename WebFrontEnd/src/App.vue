<template>
  <div id="app">
    <app-header></app-header>
    <app-footer></app-footer>
    <router-view></router-view>
  </div>
</template>

<script>
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
export default {
  name: 'app',
  components: {
    'app-header': Header,
    'app-footer': Footer
  }
}
</script>

<style>

</style>
