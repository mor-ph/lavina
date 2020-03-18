<template>
  <div id="register" class="body innerDiv">
    <div style="padding-bottom: 10%">
      <b-container>
        <b-row class="text-center">
          <b-col>
            <h1 class="hhh">Register</h1>
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
                  description="We'll never share your email with anyone else."
                >
                  <b-form-input
                    :class="{invalid: !$v.email.unique}"
                    id="email-input"
                    type="email"
                    placeholder="Enter email"
                    required
                    @blur="setEmail"
                  ></b-form-input>
                  <p class="unique" v-if="!$v.email.email">Please provide a valid email address.</p>
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
                  :class="{invalid: !$v.username.unique}"
                  id="username-input"
                  type="text"
                  placeholder="Enter Username"
                  required
                  @blur="setUsername"
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
          <b-row>
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

              <b-button type="submit" :disabled="$v.$invalid">Register</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import { email, sameAs } from 'vuelidate/lib/validators'
import axios from 'axios'

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
      email,
      unique: email => {
        if (email === '') return true

        return (axios.get('http://localhost:8081/auth/email/' + email)
        // When server return status 200 that means there is a match so the validation is false,
        // otherwise it returns 500 so it's true
          .then(() => {
            return false
          })
          .catch(() => {
            return true
          })
        )
      }
    },
    username: {
      unique: async username => {
        if (username === '') return true

        return (axios.get('http://localhost:8081/auth/username/' + username)
        // when server return status 200 that means there is a match so the validation is false,
        // otherwise it returns 500 so it's true
          .then(() => {
            return false
          })
          .catch(() => {
            return true
          })
        )
      }
    },
    confirmPassword: {
      sameAs: sameAs(vm => {
        return vm.password
      })
    }
  },
  methods: {
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
      this.$store.dispatch('register', formData)
    }
  }
}
</script>

<style scoped>
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
  transition-delay: 1s;
}

.invalid {
  border: 1px solid red;
}

</style>
