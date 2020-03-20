<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <b-form @submit.prevent="onSubmit">
          <b-row class="text-center my-2">
            <b-col md="6" offset-md="3" lg="6" offset-lg="3">
              <h3> Create new event</h3><hr>
            </b-col>
          </b-row>

        <!-- Title -->
        <b-row class="text-end my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row>
              <label for="example-i18n-picker">Title</label>
            <b-col><!--style="padding-left:40px">-->
            <b-form-textarea
              class="text-left"
              id="textarea-no-resize"
              rows="1"
              no-resize
              required
              v-model="title"
            ></b-form-textarea>
            </b-col>
            </b-form-row>
          </b-col>
        </b-row>

        <!-- Category -->
        <b-row class="text-right my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row>
            <!-- <div class="text-left"> -->
              <label for="example-category">Category</label>
            <!-- </div> -->
            <b-col  style="padding-left:6px">
            <b-form-select
              class="text-left"
              id="example-category"
              v-model="category"
              :options= filters.category.slice(1)
              @change= "fetchSubCategories"
              required
            ></b-form-select>
            </b-col>
            </b-form-row>
          </b-col>
        </b-row>

        <!-- Subcategory -->
        <b-row class="text-right my-2" v-if="category !== null">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
              <hr>
            <b-form-row>
              <label for="example-subcategorys">Subcategory</label>
              <b-col>
                <b-form-select id="example-subcategorys"
                v-model="subcategory"
                :options="filters.subcategories"></b-form-select>
                <b-button v-b-modal.modal-prevent-closing class="colorbutton">
                  Create new subcategory</b-button>
              </b-col>
            </b-form-row>
              <hr>
          </b-col>
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
        </b-row>

        <!--  Date & Time picker -->
        <b-row class="text-right my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <!-- <div class="text-left my-2"> -->
              <b-form-row >
              <label for="example-i18n-picker">Date</label>
              <b-col style="padding-left:38px">
                <b-form-datepicker id="datepicker-valid"
                              :state ="valueDate ? true : false"
                               v-model="valueDate" :min="minDate"></b-form-datepicker>
              </b-col>
              </b-form-row>
            <!-- </div> -->
          </b-col>
        </b-row>
        <b-row class="text-left my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row >
              <label for="example-i18n-picker">Time</label>
              <b-col style="padding-left:37px">
               <b-form-timepicker id="timepicker-valid"
                            :state="valueTime ? true : false"
                             v-model="valueTime"></b-form-timepicker>
              </b-col>
            </b-form-row>
          </b-col>
        </b-row>

          <!-- Location -->
          <b-row class="text-left my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row >
                <label for="example-location">City</label>
              <b-col style="padding-left:44px">
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
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row>
              <label for="example-i18n-picker">Address</label>
            <b-col style="padding-left:15px">
              <b-form-textarea
                class=""
                id="textarea-no-resize"
                placeholder="Please enter an address"
                rows="1"
                no-resize
                v-model="address"
              ></b-form-textarea>
            </b-col>
            </b-form-row>
          </b-col>
        </b-row>

        <!--Repeating-->
        <b-row class="text-left my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row >
              <label for="example-i18n-picker">Happening</label>
              <b-col><!-- class="rec float-right">-->
                <b-form-select v-model="recurring" :options="options"></b-form-select>
              </b-col>
            </b-form-row>
          </b-col>
        </b-row>

      <!--People Needed-->
      <b-row class="my-2 text-left">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <b-form-row >
              <label for="example-i18n-picker">People Needed</label>
              <b-col class="rec float-right">
                <b-form-input required v-model="peopleNeeded"  type="number" min="0" title="How many people do you need?" ></b-form-input>
              </b-col>
            </b-form-row>
          </b-col>
      </b-row>

        <!--  Details -->
        <b-row class="text-left my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
            <div class="text-left">
              <label for="example-i18n-picker">Description</label>
            </div>
          </b-col>
        </b-row>
          <b-row class="text-left my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
              <b-form-textarea
                id="textarea-no-resize"
                rows="7"
                no-resize
                v-model="description"
              ></b-form-textarea>
            </b-col>
          </b-row>
          <b-row class="text-left my-2">
          <b-col md="6" offset-md="3" lg="6" offset-lg="3">
              <b-button class="yellowbtn submitBtn" type="submit">Create</b-button>
            </b-col>
          </b-row>
        </b-form>
        <!-- </b-container> -->
      </b-container>
    </div>
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
.colorbutton, .yellowbtn{
  margin-top:5px;
  float: right;
  margin-bottom: 0;
  width: 100%;
}
</style>
