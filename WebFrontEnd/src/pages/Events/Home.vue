
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
    @change= "fetchSubCategories(); fetchFilteredEvents();"></b-form-select>
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
    @change= "fetchFilteredEvents"></b-form-select>
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
    @change= "fetchFilteredEvents"></b-form-select>
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
          @input= "fetchFilteredEvents"></b-form-datepicker>
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
import { mapGetters, mapActions } from 'vuex'

export default {
  created () {
    this.tryAutoLogin()
    this.loadInitalState()
  },
  data () {
    const minDate = new Date()
    return {
      types: ['date'],
      valueDate: '',
      minDate: minDate
    }
  },
  components: {
    appEventsGrid: EventsGrid
  },
  computed: {
    ...mapGetters([
      'events',
      'filters',
      'selectedFilters'
    ])
  },
  methods: {
    ...mapActions([
      'tryAutoLogin',
      'loadInitalState',
      'fetchSubcategories',
      'fetchFilteredEvents'
    ]),
    fetchSubCategories () {
      this.selectedFilters.subcategory = null
      this.fetchSubcategories(this.selectedFilters.category)
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
