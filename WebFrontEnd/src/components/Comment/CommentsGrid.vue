<template>
  <b-row sm="8" id="commentgrid">
    <app-comment id="commentgrid" :key="comment" v-for="comment in comments" :comment="comment"></app-comment>
  </b-row>
</template>

<script>
import Comment from './Comment'
export default {
  props: ['comments'],
  components: {
    appComment: Comment
  }
}
</script>

<style scoped>
#commentgrid{
  width:100%;
  margin:0;
}
</style>
