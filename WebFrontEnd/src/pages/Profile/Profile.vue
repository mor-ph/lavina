<template>
    <div>
<div class="body" style="padding-bottom:60%">
      <b-container>
        <b-row class="text-center">
            <b-col>
        <h1 class="hhh">Profile</h1>
        <br> <b-icon icon="person-fill" variant="light" font-scale="10"></b-icon>
        </b-col>
         </b-row>
         <b-form @submit.prevent="onSubmit">
          <b-row class="text-center">
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="username-input-group"
                label="Username:"
                label-for="username-input"
              >
                <b-form-input class="text-center"
                  id="username-input"
                  type="text"
                  :placeholder="getUser.username"
                  required
                  v-model="username"
                  @blur="$v.username.$touch()"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
           <b-row>

            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="text-center"
                id="email-input-group"
                label="Email address:"
                label-for="email-input"
                description="We'll never share your email with anyone else."
              >
                <b-form-input class="text-center"
                  id="email-input"
                  type="email"
                  :placeholder="getUser.email"
                  required
                  v-model="email"
                  @blur="$v.email.$touch()"
                ></b-form-input>
                <p v-if="!$v.email.email">Please provide a valid email address.</p>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row class="text-center">
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="text-center"
                id="password-input-group"
                label="Password:"
                label-for="password-input"
              >
                <b-form-input class="text-center"
                  id="password-input"
                  type="password"
                  placeholder="Enter Password"
                  required
                  v-model="password"
                ></b-form-input>
              </b-form-group>
               <b-button type="submit" variant="primary" :disabled="$v.$invalid">Update</b-button>
            </b-col>
          </b-row>
           <b-row class="text-center">
            <b-col sm="6" offset-sm="3">
<b-button-group>
      <b-button>My Events</b-button>
      <b-button>Join Events</b-button>
    </b-button-group>
     </b-col>
          </b-row>
        </b-form>
      </b-container>
         </div>
    </div>
</template>

<script>

import { email } from 'vuelidate/lib/validators'
// import axios from 'axios'
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      email: '',
      username: '',
      password: ''
    }
  },
  computed: {
    ...mapGetters([
      'getUser'
    ])
  },
  validations: {
    email: {
      email
      /*
      unique: email => {
        if (email === '') return true

        TODO: Wait for DB
        return axios.get('/users.json?orderBy="email"&equalTo="' + email + '"')
          .then(res => {
            return Object.keys(res.data).length === 0
          })

      } */
    },
    username: {
      /*
      unique: username => {
        if (username === '') return true

        TODO: Wait for DB
        return axios.get('/users.json?orderBy="username"&equalTo="' + username + '"')
          .then(res => {
            return Object.keys(res.data).length === 0
          })

      } */
    }
  },
  methods: {
    onSubmit () {
      const formData = {
        email: this.email,
        username: this.username,
        password: this.password
      }
      console.log(formData)
      // this.$store.dispatch('updateProfileSettings', formData)
    }
  }
}
</script>

<style scoped>
.body {
  background: #f7f7f7;
  background: rgb(63, 94, 251);
  background: radial-gradient(
    circle,
    rgba(63, 94, 251, 1) 0%,
    rgba(0, 0, 0, 1) 100%
  );
}
.hhh{
  padding-top: 110px;
  text-align: center;
  color: white;
}
.text-center {
  text-align: center;
}
</style>
