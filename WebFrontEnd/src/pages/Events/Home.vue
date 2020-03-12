
<template>
  <div style="padding: 20%">
    <b-form-select
    v-model="selectedFilters.category"
    :options= filters.category
    @change= "fetchSubCategories(); fetchEvents();"></b-form-select>

    <b-form-select
    v-if="selectedFilters.category !== null"
    v-model="selectedFilters.subcategory"
    :options="filters.subcategories"
    @change= "fetchEvents"></b-form-select>

    <b-form-select v-model="selectedFilters.location"
    :options="filters.location"
    @change= "fetchEvents"></b-form-select>
    <!-- add datepicker -->
    <app-events-grid v-if="eventsFound" :events="events.data"></app-events-grid>
    <p v-else>No events match your search!</p>
  </div>
</template>

<script>
import EventsGrid from '../../components/Event/EventsGrid'
import { mapGetters } from 'vuex'

export default {
  created () {
    this.$store.dispatch('fetchRecentEvents')
    this.$store.dispatch('fetchFilters')
  },
  data () {
    return {
      selectedFilters: this.$store.state.events.selectedFilters
    }
  },
  components: {
    appEventsGrid: EventsGrid
  },
  computed: {
    ...mapGetters([
      'events',
      'filters'
    ]),
    eventsFound () {
      return this.events.data.length > 0
    }
  },
  methods: {
    fetchSubCategories () {
      this.$store.dispatch('fetchSubcategories', this.selectedFilters.category)
    },
    fetchEvents () {
      this.$store.dispatch('fetchEvents')
    }
  }
}
</script>

<style>
</style>
