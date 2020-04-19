<template>
  <div id="register" class="body innerDiv">
    <div style="padding-bottom: 10%">
      <b-container>
        <b-row class="text-center">
          <b-col>
            <h3 class="hhh">Register</h3>
            <br>
            <b-iconstack font-scale="10">
              <b-icon stacked icon="person-fill" font-scale="10"></b-icon>
              <b-icon stacked icon="plus" scale="0.5" shift-v="3.5" shift-h="5"></b-icon>
            </b-iconstack>
          </b-col>
        </b-row>
        <b-form @submit.prevent="onSubmit" style="padding: 2.2%">
          <div>
            <b-row>
              <b-col sm="6" offset-sm="3">
                <b-form-group
                  class="label"
                  id="email-input-group"
                  label="Email address:"
                  label-for="email-input"
                >
                  <b-form-input
                    id="email-input"
                    placeholder="Enter email"
                    required
                    @blur="setEmail"
                  ></b-form-input>
                  <p class="unique" v-if="!$v.email.email">Please provide a valid email.</p>
                  <p class="unique" v-if="!$v.email.unique && !$v.email.$pending">This email is already taken.</p>
                </b-form-group>
              </b-col>
            </b-row>
          </div>
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
                  @blur="setUsername"
                  autocomplete="new-username"
                ></b-form-input>
                <p class="unique" v-if="!$v.username.unique && !$v.username.$pending">This username is already taken.</p>
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
                  autocomplete="new-password"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="confirm-password-input-group"
                label="Confirm Password:"
                label-for="confirm-password-input"
              >
                <b-form-input
                  id="confirm-password-input"
                  type="password"
                  placeholder="Confirm Password"
                  required
                  v-model="confirmPassword"
                  @blur="$v.confirmPassword.$touch()"
                  autocomplete="new-password"
                ></b-form-input>
                  <p class="unique" v-if="!$v.confirmPassword.sameAs && confirmPassword !== ''">Passwords do not match.</p>
              </b-form-group>
              <b-button type="submit" class="submitBtn" :disabled="$v.$invalid && !$v.$pending || $v.$pending">Register</b-button>
              <p id="regLink">Already have an account?
                <router-link style="color:#1a6b7e; font-size:1.1rem" to="/login">Log in.</router-link>
              </p>
            </b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import { email, sameAs } from 'vuelidate/lib/validators'
import { mapActions } from 'vuex'
import { checkEmail, checkUsername } from '../../api/authApi'

export default {
  data () {
    return {
      email: '',
      username: '',
      password: '',
      confirmPassword: '',
      uniqueEmail: null
    }
  },
  validations: {
    email: {
      email,
      async unique (email) {
        if (email === '') return true
        const response = await checkEmail(email)
        return !response.data
      }
    },
    username: {
      async unique (username) {
        if (username === '') return true
        const response = await checkUsername(username)
        return !response.data
      }
    },
    confirmPassword: {
      sameAs: sameAs(vm => {
        return vm.password
      })
    }
  },
  methods: {
    ...mapActions([
      'register'
    ]),
    setUsername: function (event) {
      this.username = event.target.value
    },
    setEmail: function (event) {
      this.email = event.target.value
    },
    onSubmit () {
      const formData = {
        email: this.email,
        username: this.username,
        password: this.password
      }
      this.register(formData)
    }
  }
}
</script>

<style scoped>
#regLink{
  text-align:center;
  margin-top:20px;
}
input{
  font-size: 0.75rem;
}
.hhh {
  color: rgb(65, 72, 77);
}
.label.label {
  color: white;
}
.text-center {
  text-align: center;
}
.unique {
  color: red;
}
</style>
