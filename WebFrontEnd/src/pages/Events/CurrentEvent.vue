<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <!-- Title -->
<!-------------------------------------------------------------------------->
        <b-form-row id="crform">
          <b-col md="4">
            <img src="https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/topic_centers/2019-8/couple-hiking-mountain-climbing-1296x728-header.jpg?w=1155">
          </b-col>
          <b-col md="8">
            <b-row id="info">
              <b-col id="title" sm="12">
                <b-col style="padding-left:0">
                  <h3 style="margin-bottom:0">{{ event.title }} | {{this.event.eventStatus}}
                  <small><span v-if="event.category.parentCategoryId!==null">cat: {{event.category.parentCategoryId}} -></span>
                    subcat:{{event.category.name}}
                  </small></h3>
                </b-col>
                <p style="margin-bottom:0">hosted by <b>{{ event.user.username }}</b></p>
              </b-col>
              <b-col md="5" class="details">
                <b-row style="padding-left:5px">
                  <b-icon icon="arrow-clockwise"></b-icon>
                  <b-col style="padding-left:5px">
                Created {{event.addedAgo}}
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px">
                  <b-icon icon="arrow-clockwise"></b-icon>
                  <b-col style="padding-left:5px">
                Happening {{event.recurring}}, {{recurringOptions.text}}
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px">
                    <b-icon icon="calendar-fill" ></b-icon>
                  <b-col style="padding-left:5px">
                  {{new Date(event.eventStartDate).toDateString()}}
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px">
                    <b-icon icon="clock-fill" ></b-icon>
                  <b-col style="padding-left:5px">
                  {{new Date(event.eventStartDate).toLocaleTimeString()}}
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px">
                    <b-icon icon="cursor-fill" ></b-icon>
                  <b-col style="padding-left:5px">
                    <b> {{event.city.name}}, Bulgaria</b>
                    <p>Address:<b> {{event.address}}</b></p>
                  </b-col>
                </b-row>
              </b-col>
              <div class=" row grid-divider"></div>
              <b-col id="description">
                <h6>Description:</h6>
                <p v-if="event.description!=null || event.description!=''" style="padding-left:20px">{{event.description}}</p>
                <p v-if="event.description==null || event.description==''"
                  style="padding-left:20px">Sorry, <b>{{event.user.username}}</b> didn't provide any :/</p>
              </b-col>
              <b-row style="width:100%">
                <b-col id="needs">
                  <b>{{event.user.username}}</b> still needs {{event.peopleNeeded}} people for this event.
                </b-col>
                <b-button @click="closeEvent" v-if="this.role === 'host'"
                           id="close">Close Event!</b-button>
                <b-button @click="join" v-if="event.peopleNeeded > 0 &&
                                              !joined &&
                                              this.role === 'user'"
                                              size="lg" id="join">Join!</b-button>
                <b-button v-if="joined && this.role === 'user'" disabledsize="lg" id="join">Joined!</b-button>
              </b-row>
            </b-row>
          </b-col>
        </b-form-row>
<!-------------------------------------------------------------------------->
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
    // let recurrence = 'once'
    // switch (this.event.recurring) {
    //   case '1': recurrence = 'every day'; break
    //   case '2': recurrence = 'every week'; break
    //   case '3': recurrence = 'every month'; break
    // }
    return {
      props: ['event'],
      event: [],
      joined: false,
      newComment: null,
      role: null,
      recurringOptions: [
        { value: null, text: 'Once' },
        { value: '1', text: 'Every day' },
        { value: '2', text: 'Every week' },
        { value: '3', text: 'Every month' }
      ]
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
      // let recurrence = 'once'
      const response = await getEventById(eventId)
      this.event = response.data
      if (this.event.userCreatedById.toString() === this.userId) {
        this.role = 'host'
      } else this.role = 'user'
      // eslint-disable-next-line eqeqeq
      if (this.event.userevent.find(object => object.userId == this.userId) !== null) {
        this.joined = true
      }
      if (this.event.address === null || this.event.address === '') {
        this.event.address = 'not specified'
      }
      // switch (event.recurring.toString()) {
      //   case null: event.recurring = 'once'; break
      //   case '1': event.recurring = 'every day'; break
      //   case '2': event.recurring = 'every week'; break
      //   case '3': event.recurring = 'every month'; break
      // }
      if (event.recurring == null) {

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
@media(max-width: 575px){
  #title{
    margin-left:20px;
  }
}
@media (max-width: 367px) {
  #crform{
    padding:15px;
    width:100%;
    margin-left: 1%;
  }
}
@media (min-width: 367px){
  /* #crform{
    padding: 24px;
  } */
}
.body {
  padding-top: 120px;
  padding-bottom: 150px;
}
#crform{
  background-color:rgba(253, 253, 253, 0.644);
  border-radius: 3px;
}
img{
width:inherit;
height: auto;
border-radius: 3px;
}
#title{
  height: fit-content;
  width:inherit
}
#info{
  padding:15px;
}
small{
  float:right;
  color:white;
  padding:4px;
  background-color: rgba(80, 69, 97, 0.712);
  border-radius: 3px;
}
.b-icon{
  margin-top:3px;
}
.details{
  padding-top:10px;
}
#description{
  background-color: rgba(255, 255, 255, 0.562);
  margin: 20px;
  /* margin-bottom:0; */
  margin-right:12px;
  padding:10px;
  border-radius: 3px;
}
button{
  float:end;
}
#close{
  background-color: rgb(107, 32, 32);
}
#join{
  background-color: rgb(85, 155, 82);
}
#needs{
  font-size: 1.3rem;
  padding-top:5px;
  margin-left:10px;
}
</style>
