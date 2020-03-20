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
                  v-model="getUser.username"
                ></b-form-input>
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
                  v-model="getUser.email"
                ></b-form-input>
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
                ></b-form-input>
              <hr>
              </b-form-group>
              </b-col>
          </b-row>
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
               <b-button type="submit" :disabled="$v.$invalid" class="submitBtn">Update</b-button>
            </b-col>
          </b-row>
        </b-form>
        <b-row class="text-center" style="padding-top:30px">
          <b-col sm="10" offset-sm="1">
            <b-button-group style="width:100%">
              <b-button @click="btnClick"
                        :pressed="showMyEvents"
                        :disabled="showMyEvents">Hosted by me</b-button>

              <b-button @click="btnClick"
                        :pressed="!showMyEvents"
                        :disabled="!showMyEvents">Joined by me</b-button>
            </b-button-group>
          </b-col>
        </b-row>
        <b-col sm="10" offset-sm="1" v-if="showMyEvents">
        <app-event-grid v-if="showMyEvents" :events="userEvents.data.createdEvents"></app-event-grid>
        <app-event-grid v-else :events="userEvents.data.joinedEvents"></app-event-grid>
        </b-col>
      </b-container>
    </div>
  </div>
</template>

<script>
import EventsGrid from '../../components/Event/EventsGrid.vue'
import { sameAs } from 'vuelidate/lib/validators'
import { mapGetters } from 'vuex'

export default {
  created () {
    this.$store.dispatch('tryAutoLogin')
    this.$store.dispatch('fetchUserEvents')
  },
  components: {
    appEventGrid: EventsGrid
  },
  data () {
    return {
      newPassword: null,
      confirmNewPassword: null,
      showMyEvents: true
    }
  },
  computed: {
    ...mapGetters([
      'getUser',
      'userEvents'
    ])
  },
  validations: {
    confirmNewPassword: {
      sameAs: sameAs(vm => {
        return vm.newPassword
      })
    }
  },
  methods: {
    onSubmit () {
      const formData = {
        email: this.getUser.email,
        username: this.getUser.username,
        password: this.newPassword
      }
      console.log(formData)
      this.$store.dispatch('updateProfileSettings', formData)
    },
    btnClick () {
      this.showMyEvents = !this.showMyEvents
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
</style>
