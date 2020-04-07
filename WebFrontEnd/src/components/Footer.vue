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
    <b-row id="ftr" class="col-sm-6" style="padding-left:30px; padding-bottom:8px;">
      <a href="https://www.vecteezy.com/free-vector/people-together" class="row flink">
        <b-icon class="icon" icon="images"></b-icon>Event image by Vecteezy</a>
    </b-row>
    <b-row id="ftr" style="flex-flow: row-reverse" class="col-sm-6">
      <p class="copyright">
        &copy; 2020 Copyright:
        <a href="https://lavina.be" style="color:white"><b style="font-size: 1.1rem">lavina.be</b></a>
      </p>
    </b-row>
    </b-row>
  </footer>
</template>
<script>
import { mapGetters } from 'vuex'

// TODO: log out da si vurshi rabotata i kato ne si lognat vmesto nego da ima register!!!!!!!!!!!!!!!!!
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
  padding-right: 50px;
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
  text-align: end;
  color:white;
}
img {
  margin-top: -77px;
  float: right;
}
.fheader{
  color:white;
  text-align-last:center;
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
