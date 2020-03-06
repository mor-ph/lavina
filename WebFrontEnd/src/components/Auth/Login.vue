<template>
  <div id="signin">
    <div class="body">
      <b-container>
        <b-row>
            <b-col sm="5"></b-col>
            <b-col sm="2">
        <h1 class="hhh">Login-in</h1>
        <br> <b-icon icon="person-fill" variant="light" font-scale="10"></b-icon>
        </b-col>
         </b-row>
      
        <b-form @submit.prevent="onSubmit" style="padding: 6%">
          <b-row>
            <b-col sm="3"></b-col>
            <b-col sm="6">
              <b-form-group id="username-input-group" label="Username:" label-for="username-input" color="white">
                <b-form-input
                  id="username-input"
                  type="text"
                  required
                  placeholder="Enter Username"
                  v-model="username"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="3"></b-col>
            <b-col sm="6">
          <b-form-group id="password-input-group" label="Password:" label-for="password-input">
            <b-form-input
              id="password-input"
              type="password"
              required
              placeholder="Enter Password"
              v-model="password"
            ></b-form-input>
          </b-form-group>

          <b-button type="submit" variant="primary">Submit</b-button>
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
      username: "",
      password: ""
    };
  },
  methods: {
    onSubmit() {
      const formData = {
        username: this.username,
        password: this.password
      };
      console.log(formData);
      // TODO: Waiting for DB
      //  this.$store.dispatch('login', { username: formData.username, password: formData.password })
    }
  }
};
</script>

<style scoped>
.body {
  background: #f7f7f7;
  background: rgb(63, 94, 251);
  background: radial-gradient(
    circle,
    rgba(63, 94, 251, 1) 0%,
    rgba(0, 0, 0, 1) 100%
  );
}
.hhh{
  padding-top: 130px;
  color: white;
}

</style>
