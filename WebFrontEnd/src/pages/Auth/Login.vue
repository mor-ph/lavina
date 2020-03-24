<template>
  <div id="signin" class="innerDiv body">
    <div style="height:100%"><!-- style="padding-bottom: 6%">-->
      <b-container>
        <b-row class="text-center">
            <b-col>
        <h1 class="hhh">Log in</h1>
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
          <p class="invalid" v-if="invalid">Invalid Username or Password!</p>

          <b-button type="submit" class="submitBtn">Log in</b-button>
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
    onSubmit () {
      const authData = {
        username: this.username,
        password: this.password
      }
      this.login(authData).catch(this.isInvalid())
    },
    isInvalid () {
      setTimeout(() => {
        this.invalid = true
        this.password = null
      }, 200)
    }
  }
}
</script>

<style scoped>
.hhh{
  color:rgb(65, 72, 77);
}
.label.label{
  color: white;
}
.invalid {
  color: red;
  font-weight: bolder;
}

</style>
