<template>
    <div class="col-sm-12 col-md-4 col-lg-3" style="padding:5px">
    <b-card
    b-card-img-lazy
    style="max-width: 100%; max-height: 100%"
    :title ="event.title"
    :sub-title=normalize()
    tag="article"
    :img-src="require('../ideas.png')"
    img-alt="event image"
    img-top
    >
      <b><p class="card-img-overlay text-left" id="category">{{event.category.name}}</p></b>
      <b-card-text class="card-text">
        <p><b-icon icon="cursor-fill" ></b-icon> {{event.city.name}}</p>
        <p><b-icon icon="calendar-fill" ></b-icon> {{new Date(event.eventStartDate).toDateString()}}</p>
        <p><b-icon icon="clock-fill" ></b-icon>{{new Date(event.eventStartDate).toLocaleTimeString()}}</p>
        <small>Created {{event.addedAgo}}</small>
      </b-card-text>
      <router-link tag="button"
                  class="primary"
                  :to="{ name: 'CurrentEvent', params: { title: event.title,
                                                          id: event.id}
                  }">Details</router-link>
    </b-card>
  </div>
</template>

<script>
export default {
  methods: {
    normalize: function String () {
      if (this.subTitle === 'HappeningNow') {
        this.subTitle = 'happening now'
      }
      return this.subTitle.toLowerCase()
    }
  },
  data () {
    return {
      subTitle: `${this.event.eventStatus}`,
      normalStatus: ''
    }
  },
  props: ['event']
}
</script>
<style scoped>
img{
  padding:5px;
  padding-bottom: 0;
}
.card-title {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-bottom: 3px;
  font-size: 1.3rem;
}
article{
  margin:5px;
  margin-bottom:20px;
  text-align:center;
}
div.card-body{
padding-bottom: 10px;
padding-top:0;
}
button{
  background-color: #7da2a9;
  text-align: center;
  width:100%;
  border-style: hidden;
  color: white;
  font-size: large;
}
.card-text {
  text-align: left;
}
.card-text p {
  font-weight: bolder;
  margin: 0;
}
.card-img-overlay{
    width: fit-content;
    height: min-content;
    color:rgb(100, 117, 148);
    padding: 5px;
    padding-left: 28px;
    padding-right: 10px;
    margin: -9px;
    font-size:1rem;
    background: rgb(252,206,81);
    background: linear-gradient(279deg, rgba(252,206,81,1) 85%, #eec24b 100%);
    bottom: inherit;
}
</style>
