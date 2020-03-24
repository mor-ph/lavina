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
              <p><b>{{ event.title }}</b></p>
            </div>
          </b-col>
        </b-row>

        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-i18n-picker">
                <strong>Date & Time:</strong>
              </label><br>
              <p><b>{{ new Date(event.eventStartDate).toUTCString() }}</b></p><br>
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
           <p><b>{{ event.city.name }}</b></p>
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
           <p><b>{{ event.address }}</b></p>
          </b-col>
        </b-row>

        <!--Hosted by-->
         <b-row class="my-2 text-center">
          <b-col sm="2" offset-sm="5">
            <div class="text-center">
              <label for="example-i18n-picker">
                <strong>Hosted by:</strong>
              </label><br>
             <p><b>{{ event.user.username }}</b></p>
            </div>
          </b-col>
        </b-row>
        <!--  Details -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
              <label for="example-i18n-picker">
                <strong>Description:</strong>
              </label><br>
             <p><b>{{ event.description }}</b></p>
            </b-col>
          </b-row>
           <!--People Needed-->
        <b-row class="my-2 text-center">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker">
                <strong>People Needed:</strong>
              </label><br>
             <p><b>{{ event.peopleNeeded }}</b></p>
            </div>
          </b-col>
        </b-row>
        <b-row class="my-2 text-center">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker">
                <strong>Recurring:</strong>
              </label><br>
             <p><b>{{ event.recurring }}</b></p>
            </div>
          </b-col>
        </b-row>
        <b-row class="my-2 text-center">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker">
                <strong>Status:</strong>
              </label><br>
             <p><b>{{ event.eventStatus }}</b></p>
            </div>
          </b-col>
        </b-row>
          <b-row class="text-center my-2">
            <b-col sm="4" offset-sm="4">
              <b-button @click="closeEvent" v-if="this.role === 'host'" variant="primary" size="lg">Close Event!</b-button>
              <b-button @click="join" v-if="event.peopleNeeded > 0 &&
                                            !joined &&
                                            this.role === 'user'"
                                            variant="primary" size="lg">Join!</b-button>
              <b-button v-if="joined && this.role === 'user'" disabled variant="primary" size="lg">Joined!</b-button>
            </b-col>
          </b-row>
         <h1>Comments:</h1>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <app-comments-grid :comments="event.comments" :key="event.comments.length"></app-comments-grid>
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
                v-model="newComment"
              ></b-form-textarea>
            </b-col>
        <b-col sm="4" offset-sm="4">
          <b-button @click="addComment" variant="primary" size="lg">Comment</b-button>
          </b-col>
      </b-row>
      </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import CommentsGrid from '../../components/Comment/CommentsGrid'
import { mapGetters, mapActions } from 'vuex'
import router from '../../router'
import commentsApi from '../../api/commentsApi'
import { getEventById, joinToEvent } from '../../api/eventApi'

export default {
  created () {
    this.tryAutoLogin()
    this.fetchEventById(this.$route.params.id)
  },
  components: {
    appCommentsGrid: CommentsGrid
  },
  data () {
    return {
      event: [],
      joined: false,
      newComment: null,
      role: null
    }
  },
  computed: {
    ...mapGetters([
      'token',
      'userId'
    ])
  },
  methods: {
    ...mapActions([
      'tryAutoLogin'
    ]),
    async fetchEventById (eventId) {
      const response = await getEventById(eventId)
      this.event = response.data
      if (this.event.userCreatedById.toString() === this.userId) {
        this.role = 'host'
      } else this.role = 'user'
      // eslint-disable-next-line eqeqeq
      if (this.event.userevent.find(object => object.userId == this.userId) !== null) {
        this.joined = true
      }
    },
    async join () {
      if (this.token) {
        await joinToEvent(this.event.id, this.userId, this.token)
        this.joined = true
        this.event.peopleNeeded--
      } else {
        router.replace('/login')
      }
    },
    async addComment () {
      if (this.newComment.length === 0) return

      if (this.token) {
        const response = await commentsApi.postComment(this.event.id, this.newComment, this.token)
        this.event.comments = response.data.filter(comment => comment.eventId === this.event.id)
        this.newComment = null
      } else {
        router.replace('/login')
      }
    },
    closeEvent () {
      // Add axios.put change eventStatus to 3
    }
  }
}
</script>

<style scoped>
.body {
  padding-top: 120px;
  padding-bottom: 150px;
}
</style>
