<template>
    <div class="col-sm-6 col-md-4 col-lg-3">

    <b-card
    img-src="https://picsum.photos/600/300/?image=25"
    img-alt="Image"
    img-top
    :title = "event.title"
    :sub-title= "subTitleString"
    tag="article"
    >
    <b-card-text>
      {{ event.description }}
    </b-card-text>

    <b-button href="#" variant="primary">Details</b-button>
  </b-card>

    </div>
</template>

<script>
export default {
  data () {
    return {
      subTitleString:
        'Location: ' + this.event.location +
         ' | Date: ' + this.event.date
    }
  },
  props: ['event']
}
</script>
