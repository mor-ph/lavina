<template>
  <div>
    <!-- Color fon -->
    <div class="body">
      <b-container fluid>
        <!-- Title -->
        <b-row class="my-3">
          <b-col sm="4"></b-col>

          <b-col sm="4">
            <div class="text-center" style="padding:5%">
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
            ></b-form-textarea>
          </b-col>
        </b-row>

        <!-- Category -->
        <b-row class="my-3">
          <b-col sm="4"></b-col>

          <b-col sm="4">
            <div class="text-center">
              <label for="example-category" class="text-white">
                <strong>Category:</strong>
              </label>
            </div>
            <b-form-select
              class="text-center"
              id="example-category"
              v-model="category"
              :options="categorys"
            ></b-form-select>
          </b-col>
        </b-row>

        <!-- Subcategory -->
        <b-row class="my-3">
          <b-col sm="5"></b-col>

          <b-col sm="2">
            <div class="text-center">
              <label for="example-subcategorys" class="text-white">
                <strong>Subcategories:</strong>
              </label>
            </div>
          </b-col>
        </b-row>

        <b-row class="my-3">
          <b-col sm="4"></b-col>

          <b-col sm="3">
            <b-form-select id="example-subcategorys" v-model="subcategory" :options="subcategorys"></b-form-select>
          </b-col>

          <!-- Add subcategory -->
          <div>
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
              <form ref="form" @submit.stop.prevent="handleSubmit">
                <b-form-group
                  :state="nameState"
                  label="Name"
                  label-for="name-input"
                  invalid-feedback="Name is required"
                >
                  <b-form-input id="name-input" v-model="name" :state="nameState" required></b-form-input>
                </b-form-group>
              </form>
            </b-modal>
          </div>
        </b-row>

        <!--  Date & Time picker -->
        <b-row class="my-3">
          <b-col sm="4"></b-col>

          <b-col sm="4">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>Date & Time picker:</strong>
              </label>
            </div>
          </b-col>
        </b-row>

        <b-row class="my-2" v-for="type in types" :key="type">
          <b-col sm="4"></b-col>
          <b-col sm="4">
            <b-form-input v-model="valueDate" :id="`type-${type}`" :type="type"></b-form-input>
          </b-col>
        </b-row>

        <!-- Location -->
        <b-row class="my-3">
          <b-col sm="4"></b-col>

          <b-col sm="4">
            <div class="text-center">
              <label for="example-location" class="text-white">
                <strong>Location:</strong>
              </label>
            </div>
            <b-form-select
              class="text-center"
              id="example-location"
              v-model="location"
              :options="locations"
            ></b-form-select>
          </b-col>
        </b-row>

        <!--  Details -->
        <b-row class="my-3">
          <b-col sm="4"></b-col>
          <b-col sm="4">
            <div class="text-center">
              <label for="example-i18n-picker" class="text-white">
                <strong>Details:</strong>
              </label>
            </div>
          </b-col>
        </b-row>
      <b-form>
        <b-row class="my-2">
          <b-col sm="4"></b-col>
          <b-col sm="4">
            <b-form-textarea
              class="text-center"
              id="textarea-no-resize"
              placeholder="Fixed height textarea"
              rows="10"
              no-resize
            ></b-form-textarea>
          </b-col>
        </b-row>
        <b-row class="my-2">
          <b-col sm="4"></b-col>
          <b-col sm="4">
          <b-button type="submit" size="lg">Submit</b-button>
          </b-col>
        </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: "",
      nameState: null,

      types: ["date", "time"],
      valueDate: "",
      valueTame: "",
      text: "",
      category: "Sport",
      categorys: [
        { value: "Sport", text: "Sport" },
        { value: "KiberSport", text: "KiberSport" }
      ],
      subcategory: 0,
      subcategorys: [
        { value: "Sport", text: "Football" },
        { value: "Sport", text: "Voleyball" },
        { value: "Sport", text: "Handball" },
        { value: "Sport", text: "Tenis" },
        { value: "Sport", text: "Swim" },
        { value: "Sport", text: "Run" }
      ],
      labels: {
        Two: {}
      },
      location: "Sofia",
      locations: [
        { value: "Sofia", text: "Sofia" },
        { value: "Plovdiv", text: "Plovdiv" }
      ]
    };
  },
  methods: {
    checkFormValidity() {
      const valid = this.$refs.form.checkValidity();
      this.nameState = valid;
      return valid;
    },
    resetModal() {
      this.name = "";
      this.nameState = null;
    },
    handleOk(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault();
      // Trigger submit handler
      this.handleSubmit();
    },
    handleSubmit() {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return;
      }
      // Push the name to submitted names
      this.subcategorys.push(this.name);
      // Hide the modal manually
      this.$nextTick(() => {
        this.$bvModal.hide("modal-prevent-closing");
      });
    }
  }
};
</script>

<style scoped>
.body {
  padding-top: 80px;
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

.text-center {
  padding-top: 4%;
}
</style>
