<template>
    <div class="col-sm-6 col-md-4 col-lg-3">

    <b-card
    header-text-variant="white"
    header-tag="header"
    header-bg-variant="dark"
    style="max-width: 50rem;"
    tag="article"
    >
    <b-card-text>
      {{ comment.message }}
    </b-card-text>

  </b-card>

    </div>
</template>

<script>
export default {
  props: ['comment']
}
</script>
