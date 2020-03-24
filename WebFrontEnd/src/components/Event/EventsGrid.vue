<template>
<div>
    <div class="row">
        <app-event id="events" :key="event.id" v-for="event in eventsArr" :event="event"></app-event>
    </div>
    <b-pagination
          v-model="currentPage"
          :total-rows="rows"
          :per-page="perPage"
          aria-controls="events"
          align="center"
        ></b-pagination>
</div>
</template>

<script>
import Event from './Event'
export default {
  data () {
    return {
      currentPage: 1,
      perPage: 12
    }
  },
  props: ['events'],
  components: {
    appEvent: Event
  },
  computed: {
    eventsArr () {
      return this.events.slice(
        (this.currentPage - 1) * this.perPage,
        this.currentPage * this.perPage
      )
    },
    rows () {
      return this.events.length
    }
  }
}
</script>

<style scoped>

</style>
