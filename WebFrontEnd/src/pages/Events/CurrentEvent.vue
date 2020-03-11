<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <b-form @submit.prevent="onSubmit">
        <!-- Title -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center  my-2">
              <label for="example-i18n-picker" class="text-white">
                <strong>Title:</strong>
              </label>
            </div>
            <b-form-textarea
              class="text-center"
              id="textarea-no-resize"
              placeholder="Fixed height textarea"
              rows="1"
              no-resize
              required
              v-model="title"
            ></b-form-textarea>
          </b-col>
        </b-row>

        <!-- Category -->
        <b-row class="text-center my-2">

          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-category" class="text-white">
                <strong>Category:</strong>
              </label>
            </div>
            <b-form-select
              class="text-center"
              id="example-category"
              v-model="category"
              :options= filters.category
              @change= "fetchSubCategories"
              required
            ></b-form-select>
          </b-col>
        </b-row>

        <!-- Subcategory -->
        <b-row class="text-center my-2"
         v-if="category !== ''">
          <b-col sm="2" offset-sm="5">
            <div class="text-center">
              <label for="example-subcategorys" class="text-white">
                <strong>Subcategories:</strong>
              </label>
            </div>
          </b-col>
        </b-row>

        <b-row class="text-center my-2">
          <b-col sm="3" offset-sm="4">
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
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-i18n-picker" class="text-white">
                <strong>Date & Time:</strong>
              </label>
            </div>
          </b-col>
        </b-row>

        <b-row class=" text-center my-2">
          <b-col sm="4" offset-sm="4">
            <b-form-datepicker id="datepicker-valid"
                               v-model="valueDate"></b-form-datepicker>
          </b-col>
        </b-row>
        <b-row class=" text-center my-2">
          <b-col sm="4" offset-sm="4">
          <b-form-timepicker id="timepicker-valid"
                             v-model="valueTime"></b-form-timepicker>
         </b-col>
        </b-row>
        <!-- Location -->
        <b-row class="text-center my-2">

          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-location" class="text-white">
                <strong>Location:</strong>
              </label>
            </div>
            <b-form-select
              class="text-center "
              id="example-location"
              required
              v-model="location"
              :options="filters.location"
            ></b-form-select>
          </b-col>
        </b-row>

        <!-- Address -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center  my-2">
              <label for="example-i18n-picker" class="text-white">
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
         <b-row class="my-2 text-center">
          <b-col sm="2" offset-sm="5">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>Your event will occur?</strong>
              </label><br>
             <b-form-select v-model="selected" :options="options" class="mb-3">
    </b-form-select>
            </div>
          </b-col>
        </b-row>

      <!--People Needed-->
        <b-row class="my-2 text-center">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>People Needed:</strong>
              </label><br>
              <b-form-spinbutton id="sb-vertical" v-model="value" vertical></b-form-spinbutton>
            </div>
          </b-col>
        </b-row>

        <!--  Details -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>Details:</strong>
              </label>
            </div>
          </b-col>
        </b-row>
          <b-row class="text-center my-2">
            <b-col sm="4" offset-sm="4">
              <b-form-textarea
                id="textarea-no-resize"
                placeholder="Fixed height textarea"
                rows="7"
                no-resize
                required
                v-model="description"
              ></b-form-textarea>
            </b-col>
          </b-row>
          <b-row class="text-center my-2">
            <b-col sm="4" offset-sm="4">
              <b-button type="submit" variant="primary" size="lg">Create</b-button>
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
    this.$store.dispatch('fetchFilters')
  },
  data () {
    return {
      // Form data
      title: '',
      category: '',
      subcategory: '',
      location: '',
      description: '',

      // Template data
      subCategoryName: '',
      nameState: null,

      types: ['date', 'time'],
      valueDate: '',
      valueTime: '',

      selected: 'Once',
      options: [
        { value: 'Once', text: 'Once' },
        { value: 'Everyday', text: 'Everyday' },
        { value: 'Every week', text: 'Every week' },
        { value: 'Every month', text: 'Every month' }
      ]

    }
  },
  methods: {
    onSubmit () {
      // Add token etc.
      const formData = {
        title: this.title,
        category: this.category,
        subcategory: this.subcategory,
        datetime: this.valueDate + ' ' + this.valueTime,
        location: this.location,
        description: this.description
      }
      console.log(formData)
      // this.$store.dispatch('createEvent', formData)
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
   background: #f7f7f7;
  background: rgb(63, 94, 251);
  background: radial-gradient(
    circle,
    rgba(63, 94, 251, 1) 0%,
    rgba(0, 0, 0, 1) 100%
  );
}
/*.colorbutton{
 background: rgb(33,62,62);
background: linear-gradient(180deg, rgba(33,62,62,1) 0%, rgba(0,215,255,1) 100%);
}*/

</style>
