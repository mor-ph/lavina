<template>
  <div>
    <div class="body innerDiv"><!-- style="padding-bottom:60%">-->
      <b-container>
        <b-row class="text-center">
            <b-col>
        <h1 class="hhh">Profile</h1>
        <br> <b-icon icon="person-fill" font-scale="10"></b-icon>
        </b-col>
         </b-row>
         <b-form @submit.prevent="onSubmit">
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="username-input-group"
                label="Username:"
                label-for="username-input"
              >
                <b-form-input class="text-left"
                  id="username-input"
                  type="text"
                  required
                  :value="user.username"
                  @blur="setUsername"
                  autocomplete="new-username"
                ></b-form-input>
                <p class="unique" v-if="!$v.username.unique && !$v.username.$pending">This Username is already registered.</p>
              </b-form-group>
            </b-col>
          </b-row>
           <b-row>
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="text-left"
                id="email-input-group"
                label="Email address:"
                label-for="email-input"
                description="We'll never share your email with anyone else."
              >
                <b-form-input class="text-left"
                  id="email-input"
                  type="email"
                  required
                  :value="user.email"
                  @blur="setEmail"
                ></b-form-input>
                <p class="unique" v-if="!$v.email.email">Please provide a valid Email</p>
                <p class="unique" v-if="!$v.email.unique && !$v.email.$pending">This Email is already registered.</p>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="6" offset-sm="3">
              <hr>

                <!-- label="New password:" -->
              <p class="text-left">Change your password</p>
              <b-form-group
                class="label"
                id="password-input-group"
                label-for="password-input"
              >
                <b-form-input
                  id="password-input"
                  type="password"
                  placeholder="Enter New Password"
                  v-model="newPassword"
                  @change="newPassword === '' ? dataChanged = false : dataChanged = true"
                  autocomplete="new-password"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row >

            <!-- label="Confirm New Password:" -->
            <b-col sm="6" offset-sm="3">
              <b-form-group
                class="label"
                id="confirm-password-input-group"
                label-for="confirm-password-input"
                :class="{invalid: $v.confirmNewPassword.$error}"
              >
                <b-form-input
                  id="confirm-password-input"
                  type="password"
                  placeholder="Confirm New Password"
                  v-model="confirmNewPassword"
                  @blur="$v.confirmNewPassword.$touch()"
                  autocomplete="new-password"
                ></b-form-input>
              <hr>
              </b-form-group>
              </b-col>
          </b-row>
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
               <b-button type="submit" class="submitBtn" :disabled="$v.$invalid && !$v.$pending ||
                                                         $v.$pending ||
                                                         !dataChanged">Update</b-button>
            </b-col>
          </b-row>
        </b-form>
        <b-row class="text-center" style="padding-top:30px">
          <b-col sm="10" offset-sm="1">
            <b-button-group style="width:100%">
              <b-button @click="btnClick"
                        :pressed="showMyEvents"
                        :disabled="showMyEvents">Events I host</b-button>

      <b-button @click="btnClick"
                :pressed="!showMyEvents"
                :disabled="!showMyEvents">Events I joined</b-button>
    </b-button-group>
     </b-col>
          </b-row>
          <b-col sm="10" offset-sm="1">
          <app-event-grid v-if="showMyEvents" :events="userEvents.createdEvents"></app-event-grid>
          <app-event-grid v-else :events="userEvents.joinedEvents"></app-event-grid>
          </b-col>
      </b-container>
    </div>
  </div>
</template>

<script>
import EventsGrid from '../../components/Event/EventsGrid.vue'
import { sameAs, email } from 'vuelidate/lib/validators'
import { mapGetters, mapActions } from 'vuex'
import { getUserEvents } from '../../api/eventApi'
import { checkEmail, checkUsername } from '../../api/authApi'

export default {
  created () {
    this.tryAutoLogin()
    this.fetchUserEvents()
  },
  components: {
    appEventGrid: EventsGrid
  },
  data () {
    return {
      username: this.$store.getters.user.username,
      email: this.$store.getters.user.email,
      newPassword: '',
      confirmNewPassword: '',
      showMyEvents: true,
      userEvents: [],
      dataChanged: false
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'token'
    ])
  },
  validations: {
    email: {
      email,
      async unique (email) {
        if (email === '' || email === this.user.email) return true
        const response = await checkEmail(email)
        return !response.data
      }
    },
    username: {
      async unique (username) {
        if (username === '' || username === this.user.username) return true
        const response = await checkUsername(username)
        return !response.data
      }
    },
    confirmNewPassword: {
      sameAs: sameAs(vm => {
        return vm.newPassword
      })
    }
  },
  methods: {
    ...mapActions([
      'tryAutoLogin',
      'updateProfile'
    ]),
    async fetchUserEvents () {
      const events = await getUserEvents(this.token)
      this.userEvents = events.data
    },
    onSubmit () {
      const formData = {
        email: this.email,
        username: this.username,
        password: this.newPassword
      }
      this.updateProfile(formData)
    },
    btnClick () {
      this.showMyEvents = !this.showMyEvents
    },
    setUsername: function (event) {
      this.username = event.target.value
      if (this.username === this.user.username) {
        this.dataChanged = false
      } else this.dataChanged = true
    },
    setEmail: function (event) {
      this.email = event.target.value
      if (this.email === this.user.email) {
        this.dataChanged = false
      } else this.dataChanged = true
    }
  }
}
</script>

<style scoped>
hr{
  border-top: 2px solid white;
}
.hhh{
  color:rgb(65, 72, 77);
}
.unique {
  color: red;
}
</style>
