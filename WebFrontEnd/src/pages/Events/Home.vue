
<template>
  <div style="padding: 20%">
    <b-form-select
    v-model="selectedFilters.category"
    :options="filters.category"></b-form-select>

    <b-form-select
    v-if="selectedFilters.category !== null"
    v-model="filters.subcategory"
    :options="subcategories"></b-form-select>

    <b-form-select v-model="selectedFilters.location"
    :options="filters.location"></b-form-select>
    <!-- add datepicker -->
    <app-events-grid v-if="events !== null" :events="events"></app-events-grid>
    <p v-else>No events match your search!</p>
  </div>
</template>

<script>
import EventsGrid from '../../components/Event/EventsGrid'
import { mapGetters } from 'vuex'

export default {
  created () {
    this.$store.dispatch('fetchEvents')
    this.$store.dispatch('fetchFilters')
  },
  data () {
    return {
      selectedFilters: this.$store.getters.selectedFilters
    }
  },
  components: {
    appEventsGrid: EventsGrid
  },
  computed: {
    ...mapGetters([
      'events',
      'filters'
    ])
  },
  watch: {
    selectedFilters: filters => {
      this.$store.dispach('fetchFilteredEvents', filters)
    }
  }
}
</script>

<style>
</style>
