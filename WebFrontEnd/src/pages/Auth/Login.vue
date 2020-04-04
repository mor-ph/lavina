<template>
  <div id="signin" class="innerDiv body">
    <div style="height:100%"><!-- style="padding-bottom: 6%">-->
      <b-container>
        <b-row class="text-center">
            <b-col>
        <h3 class="hhh">Log in</h3>
        <br> <b-icon icon="person-fill"  font-scale="10"></b-icon>
        </b-col>
         </b-row>

        <b-form @submit.prevent="onSubmit" style="padding: 2.2%">
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
              <b-form-group class="label" id="username-input-group" label="Username:" label-for="username-input" color="white">
                <b-form-input
                  id="username-input"
                  type="text"
                  required
                  placeholder="Enter Username"
                  v-model="username"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
              <b-form-group class="label" id="password-input-group" label="Password:" label-for="password-input" >
                <b-form-input
                  id="password-input"
                  type="password"
                  required
                  placeholder="Enter Password"
                  v-model="password"
                ></b-form-input>
              </b-form-group>
              <p class="invalid" v-if="invalid">Incorrect username or password!</p>

              <b-button type="submit" class="submitBtn">Log in</b-button>
              <p id="regLink">New to Lavina?
                <router-link style="color:#1a6b7e; font-size:1.1rem" to="/register">Create an account.</router-link>
              </p>
           </b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data () {
    return {
      username: '',
      password: '',
      invalid: false
    }
  },
  methods: {
    ...mapActions([
      'login'
    ]),
    async onSubmit () {
      const authData = {
        username: this.username,
        password: this.password
      }
      try {
        await this.login(authData)
      } catch { this.isInvalid() }
    },
    isInvalid () {
      setTimeout(() => {
        this.invalid = true
        this.password = null
      }, 500)
    }
  }
}
</script>

<style scoped>
#regLink{
  text-align:center;
  margin-top:20px;
}
.hhh{
  color:#41484d;
}
.label.label{
  color: white;
}
.invalid {
  color: red;
  font-weight: bolder;
}

</style>
