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
  position: relative;
  background: rgb(227, 227, 228);
  color:rgb(65, 72, 77);
  padding: auto;
  height: auto;
}
.yellowbtn{
  background: rgb(250, 220, 85);
  padding-left: 3%;
}
label{
  color:rgb(65, 72, 77);
}
.innerDiv{
  padding-bottom:20%;
}
</style>
