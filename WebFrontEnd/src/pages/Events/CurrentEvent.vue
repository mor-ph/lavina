<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <!-- Title -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center  my-2">
              <label for="example-i18n-picker">
                <strong>Title:</strong>
              </label>
              <p><b>{{ currentEvent.data.title }}</b></p>
            </div>
          </b-col>
        </b-row>

        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-i18n-picker">
                <strong>Date & Time:</strong>
              </label><br>
              <p><b>{{ new Date(currentEvent.data.eventStartDate).toUTCString() }}</b></p><br>
            </div>
          </b-col>
        </b-row>

        <!-- Location -->
        <b-row class="text-center my-2">

          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-location">
                <strong>Location:</strong>
              </label> <br>
            </div>
           <p><b>{{ currentEvent.data.city.name }}</b></p>
          </b-col>
        </b-row>

        <!-- Address -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center  my-2">
              <label for="example-i18n-picker">
                <strong>Address:</strong>
              </label> <br>
            </div>
           <p><b>{{ currentEvent.data.address }}</b></p>
          </b-col>
        </b-row>

        <!--Hosted by-->
         <b-row class="my-2 text-center">
          <b-col sm="2" offset-sm="5">
            <div class="text-center">
              <label for="example-i18n-picker">
                <strong>Hosted by:</strong>
              </label><br>
             <p><b>{{ currentEvent.data.user.username }}</b></p>
            </div>
          </b-col>
        </b-row>

        <!--  Details -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
              <label for="example-i18n-picker">
                <strong>Description:</strong>
              </label><br>
             <p><b>{{ currentEvent.data.description }}</b></p>
            </b-col>
          </b-row>
           <!--People Needed-->
        <b-row class="my-2 text-center">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker">
                <strong>People Needed:</strong>
              </label><br>
             <p><b>{{ currentEvent.data.peopleNeeded }}</b></p>
            </div>
          </b-col>
        </b-row>
          <b-row class="text-center my-2">
            <b-col sm="4" offset-sm="4">
              <b-button @click="onSubmit" v-if="!joined" variant="primary" size="lg">Join</b-button>
              <b-button v-else disabled variant="primary" size="lg">Joined!</b-button>
            </b-col>
          </b-row>

         <h1>Comments:</h1>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <app-comments-grid :comments="currentEvent.data.comments"></app-comments-grid>
        </b-col>
      </b-row>
      <b-form @submit.prevent="addComment">
      <b-row class="text-center my-2">
        <b-col sm="4" offset-sm="4">
              <b-form-textarea
                id="textarea-no-resize"
                placeholder="Fixed height textarea"
                rows="7"
                no-resize
                required
                v-model="newComment"
              ></b-form-textarea>
            </b-col>
        <b-col sm="4" offset-sm="4">
          <b-button type="submit" variant="primary" size="lg">Comment</b-button>
          </b-col>
      </b-row>
      </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import CommentsGrid from '../../components/Comment/CommentsGrid'
import { mapGetters } from 'vuex'
import router from '../../router'
export default {
  created () {
    this.$store.dispatch('fetchEventById', this.$route.params.id)
    console.log(this.currentEvent.data)
  },
  data () {
    return {
      joined: false,
      newComment: null
    }
  },
  components: {
    appCommentsGrid: CommentsGrid
  },
  computed: {
    ...mapGetters(['currentEvent'])
  },
  methods: {
    onSubmit () {
      if (this.$store.state.auth.idToken) {
        // dispatch join event
        this.joined = true
      } else {
        router.replace('/login')
      }
    },
    addComment () {
      if (this.$store.state.auth.idToken) {
        const data = {
          eventId: this.currentEvent.data.id,
          message: this.newComment
        }
        console.log(data)
        this.$store.dispatch('addComment', data)
      } else {
        router.replace('/login')
      }
    },
    fetchSubCategories () {
      this.$store.dispatch('fetchSubcategories', this.category)
    }
  }
}
</script>

<style scoped>
.body {
  padding-top: 120px;
  padding-bottom: 150px;
   /* background: #f7f7f7;
  background: rgb(63, 94, 251);
  background: radial-gradient(
    circle,
    rgba(63, 94, 251, 1) 0%,
    rgba(0, 0, 0, 1) 100%
  ); */
}
</style>
