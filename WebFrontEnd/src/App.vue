<template>
  <div id="app">
    <app-header></app-header>
    <router-view></router-view>
    <app-go-top id="backToTop"></app-go-top>
    <app-footer></app-footer>
  </div>
</template>
<script>
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
import GoTop from '@inotom/vue-go-top'

export default {
  name: 'app',
  components: {
    'app-header': Header,
    'app-footer': Footer,
    'app-go-top': GoTop
  }
}
</script>

<style>
@media(max-width:575px){
  #app{
    padding-bottom: 560px;
  }
}
@media(min-width: 576px){
  #app{
    padding-bottom: 289px;
  }
}
#app{
  min-height: 100vh;
 overflow: hidden;
 display: block;
 position: relative;
}
body, .body{
  background: rgb(227, 227, 228);
  color:rgb(65, 72, 77);
  padding: auto;
}
label{
  color:rgb(65, 72, 77);
}
.innerDiv{
  padding-bottom:20%;
  padding-top: 110px;
}
body, .body, #modal-prevent-closing,  .custom-control-label::before,
.custom-file-label, .custom-select, #datepicker-valid__value_, #timepicker-valid__value_{
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-size: 0.75rem;
}
#header,  footer{
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-size: 0.9rem;
}
.submitBtn{
  width: 100%;
}
</style>
