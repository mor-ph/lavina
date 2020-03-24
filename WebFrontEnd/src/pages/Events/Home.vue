
<template>
  <div class="body innerDiv">
    <b-container fluid>

      <!-- Header -->
      <b-row class="text-center my-2">
        <b-col md="6" offset-md="3" lg="6" offset-lg="3">
          <h3 style="opacity:0.8">Search events</h3><hr>
        </b-col>
      </b-row>

      <!-- Category -->
      <b-row class="text-left my-2 slabel">
        <b-col sm="6" offset-sm="3">
            <label for="example-i18n-picker">Category:</label>
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
      <b-row class="text-left my-2">
        <b-col sm="6" offset-sm="3">
            <label for="example-i18n-picker">Subcategory:</label>
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
      <b-row class="text-left my-2">
        <b-col sm="6" offset-sm="3">
            <label for="example-i18n-picker">Location:</label>
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
      <b-row class="text-left my-2">
        <b-col sm="6" offset-sm="3">
            <label for="example-i18n-picker">Date:</label>
        </b-col>
      </b-row>
      <b-row class="text-center my-2">
        <b-col sm="6" offset-sm="3">
          <b-form-datepicker
          id="datepicker-valid"
          v-model="selectedFilters.date"
          :min="minDate"
          @input= "fetchFilteredEvents"></b-form-datepicker><hr>
        </b-col>
      </b-row>
     <!-- No event -->
      <b-row class="text-center my-2">
        <b-col sm="10" offset-sm="1">
          <app-events-grid :events="events" v-if="events.length != 0"></app-events-grid>
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
  /* padding-bottom: 120px; */
  padding-top: 100px;
}
label{
  margin-top:6px;
  margin-bottom:0;
}
.slabel{
  margin: 0;
  padding:0;
}
</style>
