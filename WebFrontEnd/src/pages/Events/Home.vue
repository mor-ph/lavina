
<template>
  <div style="padding: 25%" class="body">
    <b-container fluid>
    <b-row class="text-center my-2">
    <b-col sm="4" offset-sm="4">
    <b-form-select
    v-model="selectedFilters.category"
    :options= filters.category
    @change= "fetchSubCategories"></b-form-select>
    </b-col>
    </b-row>

<b-row class="text-center my-2">
  <b-col sm="4" offset-sm="4">
    <b-form-select
    v-if="selectedFilters.category !== null"
    v-model="selectedFilters.subcategory"
    :options="filters.subcategories"></b-form-select>
  </b-col>
</b-row>

    <b-form-select v-model="selectedFilters.location"
    :options="filters.location"></b-form-select>
    <!-- add datepicker -->
    <app-events-grid v-if="events !== null" :events="events.data"></app-events-grid>
    <p v-else>No events match your search!</p>

    </b-container>
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
  methods: {
    fetchSubCategories () {
      this.$store.dispatch('fetchSubcategories', this.selectedFilters.category)
    }
  }
}
</script>

<style scoped>
</style>
