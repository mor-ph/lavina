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
body, .body{
  /* width: 100%; */
  position: relative;
  background: rgb(227, 227, 228);
  color:rgb(65, 72, 77);
}
.yellowbtn{
  background: rgb(250, 220, 85);
  padding-left: 3%;
}
label{
  color:rgb(65, 72, 77);
}
</style>
