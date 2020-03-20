<template>
    <div class="col-sm-6 col-md-4 col-lg-3">

    <b-card
    img-src="https://pm1.narvii.com/5984/b66523e362d75cd7154918e1d5b8779bd10cfeed_00.jpg"
    img-alt="Image"
    img-top
    :title = "event.title"
    :sub-title= "subTitleString"
    tag="article"
    >
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
      subTitleString:
        'Location: ' + this.event.city.name +
        ' Date: ' + new Date(this.event.eventStartDate).toString()
    }
  },
  props: ['event']
}
</script>
