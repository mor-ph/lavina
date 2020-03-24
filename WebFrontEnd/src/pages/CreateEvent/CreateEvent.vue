<template>
    <!-- Color fon -->
    <div class="body innerDiv">
      <b-container fluid>
        <b-row class="text-center my-2">
            <b-col md="8" offset-md="2" lg="8" offset-lg="2">
              <h4 style="opacity:0.8"> Create new event</h4>
              <hr>
            </b-col>
          </b-row>
        <b-form @submit.prevent="onSubmit">
      <b-form-row id="crform">
        <b-row class="innerRow">
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-i18n-picker">Title</label>
                <b-form-textarea
                  style="height:38px"
                  class="text-left"
                  id="textarea-no-resize"
                  rows="1"
                  no-resize
                  required
                  v-model="title"
                ></b-form-textarea>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-category">Category</label>
                <b-form-select
                  class="text-left"
                  id="example-category"
                  v-model="category"
                  :options= filters.category.slice(1)
                  @change= "fetchSubCategories"
                  required
                ></b-form-select>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol"><!-- v-if="category !== null">-->
                <label for="example-subcategorys">Subcategory</label>
                <b-form-row>
                  <b-col sm="10" md="9">
                    <b-form-select id="example-subcategorys"
                    v-model="subcategory"
                    :options="filters.subcategories"></b-form-select>
                  </b-col>
                  <b-col sm="2" md="2">
                    <b-button v-b-modal.modal-prevent-closing class="colorbutton" title="Create new subcategory">
                    <b-icon id="plusIcon" icon="plus" ></b-icon></b-button>
                  </b-col>
                </b-form-row>
          </b-col>
        </b-row>
            <b-modal
                id="modal-prevent-closing"
                ref="modal"
                title="Subcategory"
                @show="resetModal"
                @hidden="resetModal"
                @ok="handleAddSubSubmit"
              >
                <form ref="form">
                  <b-form-group
                    :state="nameState"
                    label="Name"
                    label-for="name-input"
                    invalid-feedback="Name is required"
                  >
                    <b-form-input id="name-input" v-model="subCategoryName" :state="nameState" required></b-form-input>
                  </b-form-group>
                </form>
              </b-modal>
        <b-row class="innerRow">
          <b-col md="4" lg="4" sm="12"  class="crcol">
              <label for="example-i18n-picker">Date</label>
                  <b-form-datepicker id="datepicker-valid"
                    :state ="valueDate ? true : false"
                    v-model="valueDate" :min="minDate"></b-form-datepicker>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-i18n-picker">Time</label>
                <b-form-timepicker id="timepicker-valid"
                              :state="valueTime ? true : false"
                              v-model="valueTime"></b-form-timepicker>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-i18n-picker">This event will happen</label>
                <b-form-select v-model="recurring" :options="options"></b-form-select>
          </b-col>
        </b-row>
        <b-row class="innerRow">
          <b-col md="4" lg="4" sm="12" class="crcol">
                <label for="example-location">City</label>
                  <b-form-select
                    class="text-left"
                    id="example-location"
                    required
                    v-model="city"
                    :options="filters.location"
                  ></b-form-select>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-i18n-picker">Exact address</label>
                <b-form-textarea
                  style="height:38px"
                  class=""
                  id="textarea-no-resize"
                  rows="1"
                  no-resize
                  v-model="address"
                ></b-form-textarea>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
                <label for="example-i18n-picker">People Needed</label>
                <b-form-input required v-model="peopleNeeded"
                  type="number"
                  min="0"
                  title="How many people do you need to come?"
                ></b-form-input>
          </b-col>
        </b-row>
          <b-col sm="12"  class="crcol">
            <label>Description</label>
            <b-form-textarea
              id="textarea-no-resize"
              rows="7"
              no-resize
              v-model="description"
            ></b-form-textarea>
          </b-col>
           <b-col sm="12"  class="crcol">
              <b-button class="yellowbtn submitBtn" type="submit" style="margin-bottom:20px">Create</b-button>
            </b-col>
        </b-form-row>
        </b-form>
      </b-container>
    </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import router from '../../router'
import axios from 'axios'
export default {
  created () {
    this.$store.dispatch('tryAutoLogin')
    this.$store.dispatch('fetchFilters')
  },
  data () {
    const now = new Date()
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate())
    // 15th two months prior
    const minDate = new Date(today)
    minDate.setDate(minDate.getDate())
    return {
      // Form data
      title: '',
      category: null,
      subcategory: null,
      location: '',
      city: '',
      address: '',
      recurring: null,
      peopleNeeded: null,
      description: '',

      // Template data
      subCategoryName: '',
      nameState: null,

      types: ['date', 'time'],
      valueDate: '',
      minDate: null,

      valueTime: '',

      options: [
        { value: null, text: 'Once' },
        { value: '1', text: 'Everyday' },
        { value: '2', text: 'Every week' },
        { value: '3', text: 'Every month' }
      ]

    }
  },
  methods: {
    ...mapMutations([
      'refreshed'
    ]),
    dateDisabled (ymd, date) {
      if (date.getDate() > Date()) {
        return true
      }
    },
    async onSubmit () {
      if (this.valueDate === '' || this.valueTime === '') return

      await axios.post('http://localhost:5103/api/event', {
        title: this.title,
        category: this.category,
        subcategory: this.subcategory,
        eventStartDate: this.valueDate + 'T' + this.valueTime,
        city: this.city,
        address: this.address,
        recurring: this.recurring,
        peopleNeeded: this.peopleNeeded,
        description: this.description,
        eventStatus: 1
      }, { headers: { Authorization: 'Bearer ' + localStorage.getItem('token') } })
      this.refreshed()
      router.replace('/')
    },
    fetchSubCategories () {
      this.subcategory = null
      this.$store.dispatch('fetchSubcategories', this.category)
    },

    checkFormValidity () {
      const valid = this.$refs.form.checkValidity()
      this.nameState = valid
      return valid
    },
    resetModal () {
      this.name = ''
      this.nameState = null
    },
    handleOk (bvModalEvt) {
      bvModalEvt.preventDefault()
      this.handleAddSubSubmit()
    },
    handleAddSubSubmit () {
      if (!this.checkFormValidity()) {
        return
      }

      this.$store.dispatch('addSubCategory', {
        category: this.category,
        subName: this.subCategoryName
      })
      this.subcategory = this.subCategoryName
      this.$nextTick(() => {
        this.$bvModal.hide('modal-prevent-closing')
      })
    }
  },
  computed: {
    ...mapGetters(['filters'])
  }
}
</script>

<style scoped>
label{
  margin-top: 12px;
  margin-bottom:0;
}
.crcol{
  padding: 15px;
  padding-right:20px;
  /* margin-right:30px; */
  padding-left:20px;
}
#crform{
  background-color:rgba(253, 253, 253, 0.644);
  margin-left: 10%;
  margin-right: 10%;
  border-radius: 8px;
  padding: 30px;
}
.innerRow{
  width: 100%;
  padding-left: 15px;
}
.colorbutton{
  float: end;
  margin-right:0;
}
</style>
