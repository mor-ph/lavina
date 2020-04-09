<template>
    <div class="body innerDiv">
      <b-container fluid>
        <b-row class="text-center my-2">
            <b-col md="8" offset-md="2" lg="8" offset-lg="2">
              <h5 style="opacity:0.8"> Create new event</h5>
              <hr>
            </b-col>
          </b-row>
    <b-form @submit.prevent="onSubmit">
      <b-form-row id="crform">
          <b-col md="4" lg="4" sm="12"  class="crcol">
              <label for="example-i18n-picker">Title<span red> *</span></label>
                <b-form-textarea
                  maxlength="50"
                  style="height:32px"
                  class="text-left"
                  id="textarea-no-resize"
                  rows="1"
                  no-resize
                  required
                  v-model="title"
                ></b-form-textarea>
          </b-col>
          <b-col d-flex md="4" lg="4" sm="12" class="crcol">
              <label for="example-category">Category<span red> *</span></label>
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
              <b-col sm="9">
                <b-form-select id="example-subcategorys"
                v-model="subcategory"
                :options="filters.subcategories"></b-form-select>
              </b-col>
              <b-col sm="3">
                <b-button class="colorbutton" v-b-modal.modal-prevent-closing title="Create new subcategory" :disabled="category === null">
                  <b-icon id="plusIcon" icon="plus" height="33px" width="auto"></b-icon>
                </b-button>
              </b-col>
            </b-form-row>
          </b-col>
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
                    <b-form-input id="name-input" pattern=".{3,}" v-model="subCategoryName" maxlength="20" required></b-form-input>
                    <small v-if="invalidSubCat !== null" style="color: red">{{ invalidSubCat }}</small>
                  </b-form-group>
                </form>
              </b-modal>
          <b-col md="4" lg="4" sm="12"  class="crcol">
              <label for="example-i18n-picker">Date<span red> *</span></label>
                  <b-form-datepicker id="datepicker-valid"
                    v-model="valueDate" :min="minDate"></b-form-datepicker>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-i18n-picker">Time<span red> *</span></label>
                <b-form-timepicker id="timepicker-valid"
                              v-model="valueTime"></b-form-timepicker>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol" >
              <label for="example-i18n-picker">This event will happen</label>
                <b-form-select v-model="recurring" :options="recurringOptions"></b-form-select>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
                <label for="example-location">City<span> *</span></label>
                  <b-form-select
                    class="text-left"
                    id="example-location"
                    required
                    v-model="city"
                    :options= filters.location.slice(1)
                  ></b-form-select>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
              <label for="example-i18n-picker">Exact address</label>
                <b-form-textarea
                  maxlength="100"
                  style="height:32px"
                  class=""
                  id="textarea-no-resize"
                  rows="1"
                  no-resize
                  v-model="address"
                ></b-form-textarea>
          </b-col>
          <b-col md="4" lg="4" sm="12" class="crcol">
                <label for="example-i18n-picker">People needed<span red> *</span></label>
                <b-form-input required v-model="peopleNeeded"
                  type="number"
                  min="0"
                  title="How many people do you need to come?"
                ></b-form-input>
          </b-col>
          <b-col sm="12"  class="crcol">
            <label>Description</label>
            <b-form-textarea
              maxlength="600"
              id="textarea-no-resize"
              rows="7"
              no-resize
              v-model="description"
              placeholder="Write a short, clear description. You've got 600 characters."
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
        { value: '1', text: 'Every day' },
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
@media (max-width: 367px) {
  .crcol{
    padding-right:0;
    /* margin-left:8px; */
  }
  #crform{
    padding:15px;
    width:100%;
    margin-left: 0;
  }
}
@media (min-width: 767px){
  #crform{
    padding: 30px;
    margin-left: 10%;
    margin-right: 10%;
  }
}
@media (min-width: 367px){
  #crform{
    padding: 24px;
    margin-left: 4%;
    margin-right: 4%;
  }
}
@media (max-width: 575px){
  .colorbutton{
    margin-top:10px;
  }
}
@media(min-width: 576px){
  .colorbutton{
    margin-top: -4px;
  }
}
@media (min-width: 900px){
  .crcol{
    padding:20px;
  }
}
label{
  margin-top: 12px;
  margin-bottom:0;
}
.crcol{
  padding-bottom: 7px;
}
#crform{
  background-color:rgba(253, 253, 253, 0.644);
  border-radius: 8px;
}
.innerRow{
  width: 100%;
}
.colorbutton{
  width:100%;
  float: right;
  padding:0;
}
span{
  color:rgb(209, 53, 53);
}
.error {
  color: red;
}
.custom-select, #textarea-no-resize, #__BVID__259{
  font-size: 0.75rem;
}
</style>
