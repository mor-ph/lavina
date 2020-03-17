<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <b-form @submit.prevent="onSubmit">
        <!-- Title -->
        <b-row class="text-left my-2">
          <b-col sm="6" offset-sm="3">
            <div class="text-left  my-2">
              <label for="example-i18n-picker">
                <strong>Title:</strong>
              </label>
            </div>
            <b-form-textarea
              class="text-left"
              id="textarea-no-resize"
              rows="1"
              no-resize
              required
              v-model="title"
            ></b-form-textarea>
          </b-col>
        </b-row>

        <!-- Category -->
        <b-row class="text-left my-2">

          <b-col sm="6" offset-sm="3">
            <div class="text-left">
              <label for="example-category">
                <strong>Category:</strong>
              </label>
            </div>
            <b-form-select
              class="text-left"
              id="example-category"
              v-model="category"
              :options= filters.category
              @change= "fetchSubCategories"
              required
            ></b-form-select>
          </b-col>
        </b-row>

        <!-- Subcategory -->
        <b-row class="text-left my-2"
         v-if="category !== ''">
          <b-col sm="6" offset-sm="3">
            <div class="text-left">
              <label for="example-subcategorys">
                <strong>Subcategories:</strong>
              </label>
            </div>
          </b-col>
        </b-row>

        <b-row class="text-left my-2">
          <b-col sm="6" offset-sm="3">
            <b-form-select id="example-subcategorys"
            v-if="category !== ''"
            v-model="subcategory"
            required
            :options="filters.subcategories"></b-form-select>
          </b-col>

          <!-- Add subcategory -->
          <div v-if="category !== ''">
            <b-col>
              <b-button v-b-modal.modal-prevent-closing class="colorbutton">
                <strong>Add Sub.</strong>
              </b-button>
            </b-col>

            <b-modal
              id="modal-prevent-closing"
              ref="modal"
              title="Submit Your Name"
              @show="resetModal"
              @hidden="resetModal"
              @ok="handleOk"
            >
              <form ref="form" @submit.stop.prevent="handleAddSubSubmit">
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
          </div>
        </b-row>

        <!--  Date & Time picker -->
        <b-row class="text-left my-2" style="padding-left:8px">
          <b-col sm="6" offset-sm="3">
            <div class="text-left my-2">
              <b-form-row >
              <label for="example-i18n-picker">
                <strong>Date:</strong>
              </label>
              <b-col style="padding-left:35px">
                <b-form-datepicker id="datepicker-valid"
                              :state ="valueDate ? true : false"
                               v-model="valueDate" :min="minDate"></b-form-datepicker>
              </b-col>
              </b-form-row>
            </div>
          </b-col>
        </b-row>
        <b-row class="text-left my-2" style="padding-left:8px">
          <b-col sm="6" offset-sm="3">
            <b-form-row >
              <label for="example-i18n-picker">
              <strong>Time:</strong></label>
              <b-col style="padding-left:35px">
               <b-form-timepicker id="timepicker-valid"
                            :state="valueTime ? true : false"
                             v-model="valueTime"></b-form-timepicker>
              </b-col>
            </b-form-row>
          </b-col>
        </b-row>

          <!-- Location -->
          <b-row class="text-left my-2" style="padding-left:8px">
            <b-col sm="6" offset-sm="3">
            <b-form-row >
                <label for="example-location">
                  <strong>Location:</strong>
                </label>
              <b-col>
              <b-form-select
                class="text-left"
                id="example-location"
                required
                v-model="city"
                :options="filters.location"
              ></b-form-select>
              </b-col>
            </b-form-row>
            </b-col>
          </b-row>

        <!-- Address -->
        <b-row class="text-left my-2">
          <b-col sm="6" offset-sm="3">
            <div class="text-left  my-2">
              <label for="example-i18n-picker">
                <strong>Address:</strong>
              </label>
            </div>
            <b-form-textarea
              class=""
              id="textarea-no-resize"
              placeholder="Please enter an address"
              rows="1"
              no-resize
              required
              v-model="address"
            ></b-form-textarea>
          </b-col>
        </b-row>

        <!--Repeating-->
        <b-row class="text-left my-2" style="padding-left:8px">
          <b-col sm="6" offset-sm="3">
            <b-form-row >
              <label for="example-i18n-picker">
                <strong>Your event will occur </strong>
              </label>
              <b-col class="rec float-right">
                <b-form-select v-model="recurring" :options="options"></b-form-select>
              </b-col>
            </b-form-row>
          </b-col>
        </b-row>

      <!--People Needed-->
      <b-row class="my-2 text-left" style="padding-left:8px">
          <b-col sm="6" offset-sm="3">
            <b-form-row >
              <label for="example-i18n-picker">
                <strong>People Needed: </strong>
              </label>
              <b-col class="rec float-right">
                <b-form-input  v-model="peopleNeeded"  type="number" min="0" title="How many people do you need?" ></b-form-input>
              </b-col>
            </b-form-row>
          </b-col>
      </b-row>

        <!--  Details -->
        <b-row class="text-left my-2">
          <b-col sm="6" offset-sm="3">
            <div class="text-left">
              <label for="example-i18n-picker">
                <strong>Description:</strong>
              </label>
            </div>
          </b-col>
        </b-row>
          <b-row class="text-left my-2">
            <b-col sm="6" offset-sm="3">
              <b-form-textarea
                id="textarea-no-resize"
                rows="7"
                no-resize
                required
                v-model="description"
              ></b-form-textarea>
            </b-col>
          </b-row>
          <b-row class="text-left my-2">
            <b-col  offset-sm="3">
              <b-button class="yellowbtn" type="submit" size="lg">Create</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
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
      category: '',
      subcategory: '',
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
    dateDisabled (ymd, date) {
      if (date.getDate() > Date()) {
        return true
      }
    },
    onSubmit () {
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
        description: this.description
      }
      console.log(formData)
      this.$store.dispatch('createEvent', formData)
    },
    fetchSubCategories () {
      this.$store.dispatch('fetchSubcategories', this.category)
    },
    // Template Methods
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
      // Prevent modal from closing
      bvModalEvt.preventDefault()
      // Trigger submit handler
      this.handleAddSubSubmit()
    },
    handleAddSubSubmit () {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return
      }

      this.$store.dispatch('addSubCategory', this.category, this.subCategoryName)
      // Push the name to submitted names
      this.$store.state.filters.subcategory
        .push(this.subCategoryName)
      // Hide the modal manually
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
.body {
  padding-top: 120px;
  padding-bottom: 150px;
}
.rec{
  margin-left: 10px;
}
label{
  margin-top: 8px;
}
</style>
