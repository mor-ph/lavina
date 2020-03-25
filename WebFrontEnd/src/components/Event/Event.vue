<template>
    <div class="col-sm-12 col-md-6 col-lg-4">

    <b-card
    b-card-img-lazy
    style="max-width: 100%; max-height: 100%"
    img-src="https://imgix.bustle.com/uploads/image/2019/12/12/ed336be3-2ce1-4f50-9f73-967b0c9bd6d7-gettyimages-1129878609.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    img-alt="Image"
    img-top
    :title ="event.title"
    :sub-title="subTitle"
    tag="article"
    >
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
  data () {
    return {
      subTitle: `Status: ${this.event.eventStatus}`
    }
  },
  props: ['event']
}
</script>
<style scoped>
img{
  padding:20px;
  padding-bottom: 0;
}
.card-title {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-bottom: 3px;
}
article{
  margin:5px;
  margin-bottom:20px;
  text-align:center;
}
div.card-body{
padding-bottom: 10px;
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
</style>
