
<template>
  <div class="body innerDiv">
    <b-container fluid>

      <!-- Header -->
      <b-row class="text-center">
        <b-col md="6" offset-md="3" lg="6" offset-lg="3">
          <h5 style="opacity:0.8">Filter events by</h5><hr>
        </b-col>
      </b-row>

      <!-- Category -->
      <b-row text-left>
        <b-col md="2" offset-md="2" class="text-left filter">
          <b-row class="slabel">
            <label for="example-i18n-picker">Category:</label>
          </b-row>
        <b-row>
          <b-form-select
            style="font-size:0.85rem"
            v-model="selectedFilters.category"
            :options= filters.category
            @change= "fetchSubCategories(); fetchFilteredEvents();"></b-form-select>
        </b-row>
        </b-col>
        <b-col md="2" class="filter">
          <b-row>
            <label for="example-i18n-picker">Subcategory:</label>
          </b-row>
          <b-row>
            <b-form-select
              style="font-size:0.85rem"
              v-model="selectedFilters.subcategory"
              :options="filters.subcategories"
              @change="fetchFilteredEvents"></b-form-select>
        </b-row>
        </b-col>
        <b-col md="2" class="filter">
          <b-row>
            <label for="example-i18n-picker">Location:</label>
          </b-row>
          <b-row>
            <b-form-select
            v-model="selectedFilters.location"
            style="font-size:0.85rem"
            :options="filters.location"
            @change="fetchFilteredEvents"></b-form-select>
        </b-row>
        </b-col>
        <b-col md="2" class="filter">
          <b-row>
            <label for="example-i18n-picker" >Date:</label>
          </b-row>
          <b-row>
          <b-form-datepicker
          placeholder="Any date"
          id="datepicker-valid"
          v-model="selectedFilters.date"
          :min="minDate"
          @input="fetchFilteredEvents"></b-form-datepicker>
        </b-row>
        </b-col>
      </b-row>
      <label for="sortBy" id="sort">Sort by </label>
      <b-form-select id="sortsel" v-model="selectedFilters.orderBy" :options="filters.orderBy" @change="fetchFilteredEvents"></b-form-select>
      <hr style="margin:0; margin-top:-10px; padding-bottom:8px;">
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
select{
  font-size:0.85rem;
}
label{
  margin-top:6px;
  margin-bottom:0;
}
.filter{
  height:inherit;
  margin-right:15px;
  float:center;
}
#sort{
  color:rgb(100, 117, 148);
  width:fit-content;
  margin-left:10px;
  font-size:1rem;
}
#sortsel{
  color: #647594;
  background-color: inherit;
  width:fit-content;
  margin-bottom:4px;
  border:none;
  font-weight: bold;
}
#datepicker-valid__value_{
  padding-top:7px;
  padding-bottom:7px;
}
</style>
