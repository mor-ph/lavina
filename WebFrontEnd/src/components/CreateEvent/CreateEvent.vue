<template>
  <div>

    <!-- Color fon -->
    <div class="body">
    <div class="p-3 bg-dark" style="min-height: 170px;" >

          <!-- Title -->
           <div>
             <b-col sm="5">
               <label for="example-i18n-picker" class="text-white">   Title:</label>
                 <b-form-textarea
                     id="textarea-no-resize"
                     placeholder="Fixed height textarea"
                     rows="1"
                     no-resize
                 ></b-form-textarea>
               </b-col>
           </div>

        <!-- Category -->
          <b-col sm="5">
             <label for="example-category" class="text-white">   Category:</label>
              <b-form-select id="example-category" v-model="category" :options="categorys" class="sm-2"></b-form-select>
          </b-col>

        <!-- Subcategory -->
          <b-col sm="3">
             <label for="example-subcategorys" class="text-white">   Subcategories:</label>
              <b-form-select id="example-subcategorys" v-model="subcategory" :options="subcategorys" class="sm-2"> </b-form-select>
          </b-col>

            <!-- Add subcategory -->
                 <div>
    <b-button v-b-modal.modal-prevent-closing>Add Subcategories</b-button>

    <b-modal
      id="modal-prevent-closing"
      ref="modal"
      title="Submit Your Name"
      @show="resetModal"
      @hidden="resetModal"
      @ok="handleOk"
    >
      <form ref="form" @submit.stop.prevent="handleSubmit">
        <b-form-group
          :state="nameState"
          label="Name"
          label-for="name-input"
          invalid-feedback="Name is required"
        >
          <b-form-input
            id="name-input"
            v-model="name"
            :state="nameState"
            required
          ></b-form-input>
        </b-form-group>
      </form>
    </b-modal>
  </div>

              <!--  Date & Time picker -->
                 <b-col sm="2">
                    <label for="example-i18n-picker" class="text-white">    Date & Time picker:</label>
                 </b-col>

                   <b-container fluid>
                      <b-row class="my-1" v-for="type in types" :key="type">
                        <b-col sm="3">
                         <b-form-input v-model="valueDate" :id="`type-${type}`" :type="type"></b-form-input>
                        </b-col>
                      </b-row>
                   </b-container>

                  <!--  Details -->
                     <div>
                       <b-col sm="5">
                         <label for="example-i18n-picker" class="text-white">   Details:</label>
                           <b-form-textarea
                              id="textarea-no-resize"
                              placeholder="Fixed height textarea"
                              rows="4"
                              no-resize
                           ></b-form-textarea>
                       </b-col>
                     </div>
      </div>
  </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      name: '',
      nameState: null,

      types: ['date', 'time'],
      valueDate: '',
      valueTame: '',
      text: '',
      category: 'Sport',
      categorys: [
        { value: 'Sport', text: 'Sport' },
        { value: 'KiberSport', text: 'KiberSport' }

      ],
      subcategory: 0,
      subcategorys: [
        { value: 'Sport', text: 'Football' },
        { value: 'Sport', text: 'Voleyball' },
        { value: 'Sport', text: 'Handball' },
        { value: 'Sport', text: 'Tenis' },
        { value: 'Sport', text: 'Swim' },
        { value: 'Sport', text: 'Run' }
      ],
      labels: {
        Two: {}
      }

    }
  },
  methods: {
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
      this.handleSubmit()
    },
    handleSubmit () {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return
      }
      // Push the name to submitted names
      this.subcategorys.push(this.name)
      // Hide the modal manually
      this.$nextTick(() => {
        this.$bvModal.hide('modal-prevent-closing')
      })
    }
  }
}
</script>

<style lang="scss">
</style>
