<template>
  <div id="register">
    <b-form @submit.prevent="onSubmit" style="padding: 20%">
      <b-form-group
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
          @blur="$v.email.$touch()">
          </b-form-input>
          <p v-if="!$v.email.email">Please provide a valid email address.</p>
      </b-form-group>

      <b-form-group
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
          @blur="$v.username.$touch()">
          </b-form-input>
      </b-form-group>

      <b-form-group
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

      <b-form-group
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

      <b-button
        type="submit"
        variant="primary"
        :disabled="$v.$invalid">Submit</b-button>
  </b-form>
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
        password: this.password,
        confirmPassword: this.confirmPassword
      }
      console.log(formData)
      // TODO: Waiting for DB
      // this.$store.dispatch('signup', formData)
    }
  }
}
</script>

<style scoped>

</style>
