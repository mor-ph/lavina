<template>
    <div class="row">
        <app-comment :key="comment.id" v-for="comment in comments" :comment="comment"></app-comment>
    </div>
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
</style>
