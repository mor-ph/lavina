<template>
  <footer>
    <b-row id="ftr">
      <b-col sm="3" md="2">
        <img src="./lavina-logo_110x110.png" alt="logo" width="110px" height="110px" />
      </b-col>
      <b-col class="infocol" sm="3" md="3">
        <p class="fheader"><b>EVENT LINKS</b></p>
        <hr style="background-color:white; ">
        <router-link to="/" class="flink row">ALL EVENTS</router-link>
        <router-link to="/profile" class="flink row">MY EVENTS</router-link>
        <router-link to="/createEvent" class="flink row">CREATE EVENT</router-link>
      </b-col>
      <b-col class="infocol" sm="3" md="3">
        <p class="fheader"><b>PROFILE LINKS</b></p>
        <hr style="background-color:white; ">
        <router-link to="/profile" class="flink row">MY PROFILE</router-link>
        <router-link to="/profile" class="flink row">EDIT PROFILE</router-link>
      </b-col>
      <b-col class="infocol" sm="3" md="3">
        <p class="fheader"><b>CONTACT US</b></p>
        <hr style="background-color:white; ">
        <p class="flink row">
          <b-icon class="icon" icon="envelope-fill"></b-icon>
          <span>info@lavina.be</span>
        </p>
      </b-col>
    </b-row>
    <b-row>
      <b-col class="btm">
        <a class="row flink" style="width: max-content" href="https://www.vecteezy.com/free-vector/people-together">
          <b-icon class="icon" icon="images"></b-icon>Event image by Vecteezy</a>
      </b-col>
      <b-col class="cent row">
        <div class="copyright row">
          &copy; 2020 Copyright: -
          <a href="https://lavina.be" style="color:white; "> <b> lavina.be</b>-</a>
        </div>
      </b-col>
    </b-row>
  </footer>
</template>
<script>
import { mapGetters } from 'vuex'
import Vue from 'vue'
import VueMq from 'vue-mq'

Vue.use(VueMq, {
  breakpoints: {
    mobile: 666,
    tablet: 1000,
    desktop: Infinity
  }
})

export default {
  computed: {
    ...mapGetters(['isAuthenticated'])
  }
}
</script>

<style scoped>

.text-center {
  padding-top: 0.5%;
}
.icon {
  /* width: 70px; */
  outline-color: white;
  margin:2px;
}
footer {
  position: absolute;
  width: 100%;
  background-color: #7da2a9;
  z-index: 100;
  bottom:0;
}
#ftr {
  margin: 0;
  padding-top: 50px;
}
.flink {
  color: white;
  border-radius: 2px;
  padding: 5px;
  place-content: center;
  margin-left:0px;
  margin-right:0;
}
.flink:hover {
  text-decoration: none;
  color: rgb(56, 54, 54);
  background: rgba(255, 255, 255, 0.774);
}
.copyright {
  color:white;
  width:max-content;
}
img {
  margin-top: -77px;
  float: right;
}
.fheader{
  color:white;
  text-align-last:center;
}
@media(max-width: 422px){
  .cent{
    flex-basis: auto;
  }
  .btm{
    text-align: -webkit-center;
    padding-left:0;
  }
  .copyright {
    margin:auto;
    margin-bottom:10px;
  }
}
@media(min-width: 423px){
  .cent{
    flex-direction: row-reverse;
    margin-right:30px;
  }
  .btm{
    padding-left:30px;
    margin-bottom:7px;
  }
  .copyright {
    padding-top:5px;
  }
}
@media(max-width: 673px){
  #ftr{
  padding-right: 30px;
  }
}
@media(min-width: 674px){
   #ftr{
  padding-right: 50px;
  }
}
@media(max-width: 575px){
  .fheader{
    text-align-last:left;
    padding-top:20px;
    margin-bottom:0;
  }
  hr{
    margin:0;
  }
  #ftr{
    padding-right:15px;
  }
  .flink{
    justify-content: flex-end;
    padding-right:15px;
  }
  .infocol{
    padding-right:0;
  }
}
</style>
