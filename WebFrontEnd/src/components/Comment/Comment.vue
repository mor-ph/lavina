<template>
  <div style="margin-bottom:15px; border-radius:30px;">
    <b-row id="header">
      <b-col style="font-size:larger; padding:0; width:fit-content">
        <b-icon icon="person-fill"></b-icon>
        <b> {{comment.user.username}} </b>
      </b-col>
      <b-col style="text-align:right; padding-top:4px;" class="text-muted">
        {{new Date(comment.postedOn).toLocaleTimeString()}}   |
        {{new Date(comment.postedOn).toDateString()}}
      </b-col>
    </b-row>
    <b-row id="comment" style="border-radius:30px; font-size:0.9rem">
       {{ comment.message }}
    </b-row>
  </div>
</template>

<script>
export default {
  props: ['comment']
}
</script>
<style scoped>
  #header{
    color:#7da2a9e0;
    width: auto;
    margin:0px;
  }
  #header, #comment{
    padding: 5px;
  }
  #comment{
    background-color: white;
    padding-left:15px;
    padding-right:15px;
    border-radius:30px;
    font-size:large;
    width: inherit;
    margin-left:0px;
  }
</style>
