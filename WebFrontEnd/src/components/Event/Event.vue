<template>
    <div class="col-sm-6 col-md-4 col-lg-4">

    <b-card
    img-src="https://picsum.photos/600/300/?image=25"
    img-alt="Image"
    img-top
    :title = "event.title"
    :sub-title= "subTitleString"
    tag="article"
    >
    <button>
      <router-link tag="button"
                  class="primary"
                  :to="{ name: 'CurrentEvent', params: { title: event.title,
                                                          id: event.id}
                  }">See more..</router-link>
    </button>
  </b-card>

    </div>
</template>

<script>
export default {
  data () {
    return {
      subTitleString:
        'Location: ' + this.event.city.name +
        ' Date: ' + new Date(this.event.eventStartDate).toString()
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
article{
  margin:5px;
  margin-bottom:20px;
  padding-bottom: 8px;
  text-align:center;
}
div.card-body{
padding-bottom: 10px;
}
button{
  background-color: rgba(185, 184, 184, 0.2);
  text-align: center;
  width:100%;
  border-style: hidden;
  color:rgb(87, 87, 87);
}
</style>
