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
                  maxlength="50"
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
                  @change= "getSubCategories"
                  required
                ></b-form-select>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
                <label for="example-subcategorys">Subcategory</label>
                <b-form-row>
                  <b-col sm="10" md="9">
                    <b-form-select id="example-subcategorys"
                    v-model="subcategory"
                    :options="filters.subcategories"></b-form-select>
                  </b-col>
                  <b-col sm="2">
                  <b-button v-b-modal.modal-prevent-closing class="colorbutton" title="Create new subcategory" :disabled="category === null">
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
                @ok="handleOk"
              >
                <form ref="form" @submit.stop.prevent="handleOk">
                  <b-form-group
                    :state="nameState"
                    label="Name"
                    label-for="name-input"
                    invalid-feedback="Name must be at least 3 characters!"
                  >
                    <b-form-input id="name-input" pattern=".{3,}" v-model="subCategoryName" required></b-form-input>
                    <small v-if="invalidSubCat !== null" style="color: red">{{ invalidSubCat }}</small>
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
                <b-form-select v-model="recurring" :options="recurringOptions"></b-form-select>
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
             <p class="error" v-if="createEventError !== null">{{ createEventError }}</p>
              <b-button class="yellowbtn submitBtn" type="submit" style="margin-bottom:20px">Create</b-button>
            </b-col>
        </b-form-row>
        </b-form>
      </b-container>
    </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
import router from '../../router'
import { postSubCategory, createEvent } from '../../api/eventApi'

export default {
  created () {
    this.tryAutoLogin()
    this.fetchFilters()
  },
  data () {
    const now = new Date()
    return {
      title: '',
      category: null,
      subcategory: null,
      location: '',
      city: '',
      address: '',
      recurring: null,
      peopleNeeded: null,
      description: '',

      subCategoryName: '',
      nameState: null,
      invalidSubCat: null,

      types: ['date', 'time'],
      valueDate: '',
      minDate: now,
      valueTime: '',

      recurringOptions: [
        { value: null, text: 'Once' },
        { value: '1', text: 'Everyday' },
        { value: '2', text: 'Every week' },
        { value: '3', text: 'Every month' }
      ],

      createEventError: null
    }
  },
  methods: {
    ...mapMutations([
      'changeRefreshed'
    ]),
    ...mapActions([
      'tryAutoLogin',
      'fetchFilters',
      'fetchSubcategories'
    ]),
    dateDisabled (ymd, date) {
      if (date.getDate() > Date()) {
        return true
      }
    },
    async onSubmit () {
      if (this.valueDate === '' || this.valueTime === '') return
      const formData = {
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
      }
      try {
        await createEvent(formData, this.token)
        this.changeRefreshed()
        alert('Your event was created successfully!')
        router.replace('/')
      } catch (error) {
        this.createEventError = error.response.data
      }
    },
    getSubCategories () {
      this.subcategory = null
      this.fetchSubcategories(this.category)
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
    async handleAddSubSubmit () {
      if (!this.checkFormValidity()) {
        return
      }
      try {
        await postSubCategory(this.category, this.subCategoryName, this.token)
        this.fetchSubcategories(this.category)
        this.subcategory = this.subCategoryName
        this.$nextTick(() => {
          this.$bvModal.hide('modal-prevent-closing')
        })
      } catch (error) {
        this.invalidSubCat = error.response.data
      }
    }
  },
  computed: {
    ...mapGetters(['filters', 'token'])
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
.error {
  color: red;
}
</style>
