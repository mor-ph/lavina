<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <!-- Title -->
<!-------------------------------------------------------------------------->
      <b-col md="8" offset-md="2">
        <b-form-row id="crform">
          <b-row style="margin:0px; height:fit-content; padding:0" class="col-md-4">
            <b-col id="imgCol">
              <img alt="event image" src="../../components/ideas.png">
            </b-col>
          </b-row>
          <b-col md="8" style="padding:0;">
              <b-col id="title">
                <b-col style="padding:0">
                  <h4 style="margin-bottom:0">{{ event.title }}<sup>{{this.event.eventStatus}}</sup></h4>
                  <p style="margin-bottom:0">Hosted by <b>{{ event.user.username }}</b></p>
                </b-col>
              </b-col>
              <div id="category">
                  <p class="ctgrTag">{{event.mainCategory.name}}</p>
                  <p class="ctgrTag" v-if="event.subCategory !== null">{{event.subCategory.name}}</p>
              </div>
            <b-row class="info" style="padding-top:0; margin-top:0">
              <b-col class="details" lg="5">
                <b-row style="padding-left:5px" >
                    <b-icon icon="calendar-fill" ></b-icon>
                  <b-col style="padding-left:5px">
                  {{new Date(event.eventStartDate).toDateString()}}
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px" >
                    <b-icon icon="clock-fill" ></b-icon>
                  <b-col style="padding-left:5px">
                  {{new Date(event.eventStartDate).toLocaleTimeString()}}
                  </b-col>
                </b-row>
                 <b-row style="padding-left:5px">
                  <b-icon icon="arrow-clockwise"></b-icon>
                  <b-col style="padding-left:5px">
                Happening <b>{{normalize()}}</b>
                  </b-col>
                </b-row>
              </b-col>
              <b-col class="details" lg="7">
                <b-row style="padding-left:5px">
                    <b-icon icon="cursor-fill" ></b-icon>
                  <b-col style="padding-left:5px">
                    <b> {{event.city.name}}, Bulgaria</b>
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px">
                  <b-icon icon="eye-fill"></b-icon>
                  <b-col style="padding-left:5px">
                  <b>Address: {{event.address}}</b>
                  </b-col>
                </b-row>
                <b-row style="padding-left:5px">
                  <b-icon icon="plus"></b-icon>
                  <b-col style="padding-left:5px">
                Created {{event.addedAgo}}
                  </b-col>
                </b-row>
              </b-col>
            </b-row>
            <b-row id="description">
              <b-col>
                <h7>Description:</h7>
                <p v-if="event.description !== ''" style="padding-left:20px">{{event.description}}</p>
                <p v-else style="padding-left:20px">Sorry, <b>{{event.user.username}}</b> didn't provide any :/</p>
              </b-col>
            </b-row>
          </b-col>
          <b-row class="col-sm-12" id="btnDiv" style="margin:0; padding:0"
              v-if="this.event.eventStatus !== 'Finished'">
            <b-button @click="closeEvent" v-if="this.role === 'host'" id="close">
              <b>{{event.user.username}}</b> still needs {{event.peopleNeeded}}
                people for this event. <b style="font-size:1.2rem">Click here to close it!</b>
            </b-button>
            <b-button @click="join" v-if="event.peopleNeeded > 0 &&
                                    !joined && this.role === 'user'" id="join">
              <b>{{event.user.username}}</b> still needs {{event.peopleNeeded}}
                 people for this event. <b style="font-size:1.2rem">Click here to join it!</b>
            </b-button>
            <b-button v-if="joined && this.role === 'user' && this.userId !== null"
                disabledsize="100%" id="join">
                <b>{{event.user.username}}</b> still needs {{event.peopleNeeded}}
                 people for this event. <b style="font-size:1.2rem">You have already joined it!</b>
            </b-button>
          </b-row>
        </b-form-row>
      </b-col>
<!-------------------------------------------------------------------------->
      <b-col md="8" offset-md="2">
        <b-form-row id="comments">
          <b-col sm="12">
            <h6>{{this.event.comments.length}} Comments:</h6>
          </b-col>
          <b-col sm="12">
              <app-comments-grid :comments="event.comments" :key="event.comments.length"></app-comments-grid>
          </b-col>
          <b-col sm="12">
            <b-form @submit.prevent="addComment" style="width:100%; margin:0">
              <b-form-textarea
                id="textarea-no-resize"
                placeholder="Write your comment here..."
                rows="5"
                no-resize
                v-model="newComment"
                style="font-size:0.9rem"
              ></b-form-textarea>
              <b-col style="margin-top:10px; padding:0">
                <b-button style="font-size:1rem; width:100%" @click="addComment">Comment</b-button>
              </b-col>
            </b-form>
          </b-col>
        </b-form-row>
      </b-col>
      </b-container>
    </div>
  </div>
</template>

<script>
import CommentsGrid from '../../components/Comment/CommentsGrid'
import { mapGetters, mapActions } from 'vuex'
import router from '../../router'
import commentsApi from '../../api/commentsApi'
import { getEventById, joinToEvent, closeEvent } from '../../api/eventApi'

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
      props: ['event'],
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
    normalize: function String () {
      return this.event.recurring.match(/[A-Z][a-z]+|[0-9]+/g).join(' ').toLowerCase()
    },
    ...mapActions([
      'tryAutoLogin'
    ]),
    async fetchEventById (eventId) {
      const response = await getEventById(eventId)
      this.event = response.data
      // eslint-disable-next-line eqeqeq
      if (this.event.user.id == this.userId) {
        this.role = 'host'
      } else this.role = 'user'
      // eslint-disable-next-line eqeqeq
      if (this.event.userevent.find(event => event.userId == this.userId) !== undefined) {
        this.joined = true
      }
      if (this.event.address === null || this.event.address === '') {
        this.event.address = 'not specified'
      }
      if (this.event.eventStatus === 'HappeningNow') {
        this.event.eventStatus = 'Happening now'
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
        this.event.comments.push(response.data)
        this.newComment = null
      } else {
        router.replace('/login')
      }
    },
    async closeEvent () {
      if (confirm('Are you sure you want to close this event ?\nTo confirm click "OK". To quit click "Cancel"')) {
        await closeEvent(this.event.id, this.token)
        this.event.eventStatus = 'Finished'
      }
    }
  }
}
</script>

<style scoped>
@media(max-width: 450px){
  .container-fluid{
    padding: 0;
  }
}
@media (max-width: 367px) {
  #crform{
    margin-left:0;
  }
  #title{
    padding:5px;
    width:fit-content;
  }
  .info{
    padding-top: 0;
  }
}
.body {
  padding-top: 120px;
  padding-bottom: 150px;
}
#crform{
  background-color:rgba(253, 253, 253, 0.644);
  border-radius: 3px;
  position:relative;
  padding:15px;
  height: fit-content;
}
#comments{
  /* margin:0px; */
  padding:15px;
  margin-top:25px;
  /* margin-left:15px; */
}
img{
width:inherit;
height: auto;
border-radius: 3px;
margin-bottom: 10px;
}
#title{
  height: fit-content;
  padding-top:15px;
  padding-left:15px;
  width:fit-content;
}
.info{
  margin-left:15px;
  position: relative;
}
.b-icon{
  margin-top:3px;
}
.details{
  padding-top:7px;
  margin-top:15px;
}
#description{
  background-color: rgba(255, 255, 255, 0.562);
  margin-top: 20px;
  margin-bottom:12px;
  margin-right:0px;
  margin-left: 15px;;
  padding:10px;
  border-radius: 5px;
}
button{
  float:end;
  bottom:0;
  border-radius: 5px;
}
#close{
  background-color: rgba(49, 49, 49, 0.685);
  border:none;
  width:inherit;
}
#join{
  background-color: rgba(61, 118, 131, 0.87);
  width:inherit;
  border:none;
}
.ctgrTag{
  color:rgb(100, 117, 148);
  padding: 5px;
  padding-right: 28px;
  padding-left: 10px;
  font-size: 0.9rem;
  background: #fcce51;
  background: linear-gradient(79deg, rgba(252,206,81,1) 85%, #eec24b 100%);
  margin-right: -15px;
}
#imgCol{
  padding:0;
  margin:0;
}
#category{
  align-items: right;
  margin-right: -17px;
  float:right;
  width: min-content;
  text-align:left;
  margin-top:-50px;
  padding:0;
}
sup{
  font-size:0.95rem;
  color:rgb(60, 118, 131);
  padding-left:3px;
}
h5{
  color:rgb(92, 91, 91);
}
</style>
