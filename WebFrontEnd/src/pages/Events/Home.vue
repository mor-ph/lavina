
<template>
  <div class="body innerDiv">
    <b-container fluid>
      <!-- Category -->
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker">
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
      <div v-if="selectedFilters.category !== null">
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker">
              <strong>Subcategories:</strong>
            </label>
          </div>
        </b-col>
      </b-row>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
           <b-form-select
    v-model="selectedFilters.subcategory"
    :options="filters.subcategories"
    @change= "fetchEvents"></b-form-select>
        </b-col>
      </b-row>
      </div>
      <!-- Location -->
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <div class="text-center my-2">
            <label for="example-i18n-picker">
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
            <label for="example-i18n-picker">
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
      <b-row class="text-center my-2 ">
        <b-col>
          <app-events-grid :events="events.data" v-if="events.data != 0"></app-events-grid>
          <p v-else>No Events match your search!</p>
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
    ])
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
.innerDiv{
  padding-bottom: 120px;
  padding-top: 150px;
}
</style>
