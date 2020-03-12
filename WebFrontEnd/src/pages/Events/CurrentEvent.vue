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
              <p><b>'{{ value }}'</b></p>
            </div>
          </b-col>
        </b-row>

        <!--  Date & Time picker -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-i18n-picker" class="text-white">
                <strong>Date & Time:</strong>
              </label><br>
              <p><b>'{{ value }}'</b></p><br>
              <p><b>'{{ value }}'</b></p>
            </div>
          </b-col>
        </b-row>

        <!-- Location -->
        <b-row class="text-center my-2">

          <b-col sm="4" offset-sm="4">
            <div class="text-center my-2">
              <label for="example-location" class="text-white">
                <strong>Location:</strong>
              </label> <br>
            </div>
           <p><b>'{{ value }}'</b></p>
          </b-col>
        </b-row>

        <!-- Address -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center  my-2">
              <label for="example-i18n-picker" class="text-white">
                <strong>Address:</strong>
              </label> <br>
            </div>
           <p><b>'{{ value }}'</b></p>
          </b-col>
        </b-row>

        <!--Hosted by-->
         <b-row class="my-2 text-center">
          <b-col sm="2" offset-sm="5">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>Hosted dy:</strong>
              </label><br>
             <p><b>'{{ value }}'</b></p>
            </div>
          </b-col>
        </b-row>

        <!--  Details -->
        <b-row class="text-center my-2">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>Details:</strong>
              </label><br>
             <p><b>'{{ value }}'</b></p>
            </b-col>
          </b-row>
           <!--People Needed-->
        <b-row class="my-2 text-center">
          <b-col sm="4" offset-sm="4">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>People Needed:</strong>
              </label><br>
             <p><b>'{{ value }}'</b></p>
            </div>
          </b-col>
        </b-row>
          <b-row class="text-center my-2">
            <b-col sm="4" offset-sm="4">
              <b-button type="submit" variant="primary" size="lg">Join</b-button>
            </b-col>
          </b-row>
          <h1>Comments:</h1>
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
