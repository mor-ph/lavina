<template>
  <div id="register">
    <div class="body" style="padding-bottom: 10%">
      <b-container>
        <b-row class="text-center">
          <b-col>
            <h1 class="hhh">Register</h1>
            <br />
            <b-iconstack font-scale="10" variant="white">
              <b-icon stacked icon="person-fill" variant="light" font-scale="10"></b-icon>
              <b-icon
                stacked
                icon="plus"
                scale="0.5"
                shift-v="3.5"
                shift-h="5"
              ></b-icon>

            </b-iconstack>
          </b-col>
        </b-row>
        <b-form @submit.prevent="onSubmit" style="padding: 2.2%">
          <b-row>
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="email-input-group"
                label="Email address:"
                label-for="email-input"
                description="We'll never share your email with anyone else."
              >
                <b-form-input
                  id="email-input"
                  type="email"
                  placeholder="Enter email"
                  required
                  v-model="email"
                  @blur="$v.email.$touch()"
                ></b-form-input>
                <p v-if="!$v.email.email">Please provide a valid email address.</p>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="username-input-group"
                label="Username:"
                label-for="username-input"
              >
                <b-form-input
                  id="username-input"
                  type="text"
                  placeholder="Enter Username"
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
                class="label"
                id="password-input-group"
                label="Password:"
                label-for="password-input"
              >
                <b-form-input
                  id="password-input"
                  type="password"
                  placeholder="Enter Password"
                  required
                  v-model="password"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row >
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="confirm-password-input-group"
                label="Confirm Password:"
                label-for="confirm-password-input"
                :class="{invalid: $v.confirmPassword.$error}"
              >
                <b-form-input
                  id="confirm-password-input"
                  type="password"
                  placeholder="Confirm Password"
                  required
                  v-model="confirmPassword"
                  @blur="$v.confirmPassword.$touch()"
                ></b-form-input>
              </b-form-group>

              <b-button type="submit" variant="primary" :disabled="$v.$invalid">Register</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import { email, sameAs } from 'vuelidate/lib/validators'
// import axios from 'axios'

export default {
  data () {
    return {
      email: '',
      username: '',
      password: '',
      confirmPassword: ''
    }
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
    },
    confirmPassword: {
      sameAs: sameAs(vm => {
        return vm.password
      })
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
      // TODO: Waiting for DB
      this.$store.dispatch('signup', formData)
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
.hhh {
  padding-top: 130px;
  color: white;
}

.label.label {
  color: white;
}

.text-center {
  text-align: center;
}
</style>
