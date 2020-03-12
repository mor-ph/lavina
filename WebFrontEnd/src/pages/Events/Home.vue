
<template>
  <div style="padding: 20%" class="body">
    <b-container fluid>
      <!-- Category -->
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker" class="text-white">
              <strong>Category:</strong>
            </label>
          </div>
        </b-col>
      </b-row>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
         <b-form-select
    v-model="selectedFilters.category"
    :options= filters.category
    @change= "fetchSubCategories(); fetchEvents();"></b-form-select>
        </b-col>
      </b-row>
      <!-- SubCategory -->
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker" class="text-white">
              <strong>Subcategories:</strong>
            </label>
          </div>
        </b-col>
      </b-row>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
           <b-form-select
    v-if="selectedFilters.category !== null"
    v-model="selectedFilters.subcategory"
    :options="filters.subcategories"
    @change= "fetchEvents"></b-form-select>
        </b-col>
      </b-row>
      <!-- Location -->
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker" class="text-white">
              <strong>Location:</strong>
            </label>
          </div>
        </b-col>
      </b-row>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
           <b-form-select v-model="selectedFilters.location"
    :options="filters.location"
    @change= "fetchEvents"></b-form-select>
        </b-col>
      </b-row>
      <!-- Datepicker -->
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker" class="text-white">
              <strong>Date:</strong>
            </label>
          </div>
        </b-col>
      </b-row>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <b-form-datepicker
          id="datepicker-valid"
          v-model="selectedFilters.date"
          :min="minDate"
          @input= "fetchEvents"></b-form-datepicker>
        </b-col>
      </b-row>
     <!-- No event -->
      <b-row class="text-center my-2">
        <b-col>
          <app-events-grid v-if="eventsFound" :events="events.data"></app-events-grid>
          <p v-else>No events match your search!</p>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import EventsGrid from '../../components/Event/EventsGrid'
import { mapGetters } from 'vuex'

export default {
  created () {
    this.$store.dispatch('loadInitalState')
  },
  data () {
    const now = new Date()
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate())
    // 15th two months prior
    const minDate = today
    minDate.setDate(minDate.getDate())
    return {
      types: ['date'],
      valueDate: '',
      minDate: minDate,
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
