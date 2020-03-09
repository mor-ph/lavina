<template>
    <div class="row">
        <app-event :key="event.id" v-for="event in events" :event="event"></app-event>
    </div>
</template>

<script>
import Event from './Event'
export default {
  props: ['events'],
  components: {
    appEvent: Event
  }
}
</script>

<style scoped>

</style>
