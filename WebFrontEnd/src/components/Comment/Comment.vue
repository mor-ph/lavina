<template>
    <div class="col-sm-6 col-md-4 col-lg-3">

    <b-card
    header-text-variant="white"
    header-tag="header"
    header-bg-variant="dark"
    style="max-width: 50rem;"
    :title = "comment.title"
    :header = "user.header"
    :sub-title= "subTitleString"
    tag="article"
    >
    <b-card-text>
      {{ comment.description }}
    </b-card-text>

  </b-card>

    </div>
</template>

<script>
export default {
  data () {
    return {
      subTitleString:
        'Location: ' + this.comment.location +
         ' | Date: ' + this.comment.date
    }
  },
  props: ['comment']
}
</script>
