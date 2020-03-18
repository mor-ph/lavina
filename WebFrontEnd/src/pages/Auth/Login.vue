<template>
  <div id="signin" class="innerDiv body">
    <div  style="padding-bottom: 6%">
      <b-container>
        <b-row class="text-center">
            <b-col>
        <h1 class="hhh">Login</h1>
        <br> <b-icon icon="person-fill"  font-scale="10"></b-icon>
        </b-col>
         </b-row>

        <b-form @submit.prevent="onSubmit" style="padding: 2.2%">
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
              <b-form-group class="label" id="username-input-group" label="Username:" label-for="username-input" color="white">
                <b-form-input
                  id="username-input"
                  type="text"
                  required
                  v-model="username"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row class="text-left">
            <b-col sm="6" offset-sm="3">
          <b-form-group class="label" id="password-input-group" label="Password:" label-for="password-input" >
            <b-form-input
              id="password-input"
              type="password"
              required
              v-model="password"
            ></b-form-input>
          </b-form-group>

          <b-button type="submit">Login</b-button>
           </b-col>
          </b-row>
        </b-form>
      </b-container>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      password: ''
    }
  },
  methods: {
    onSubmit () {
      const formData = {
        username: this.username,
        password: this.password
      }
      console.log(formData)
      this.$store.dispatch('login', { username: formData.username, password: formData.password })
    }
  }
}
</script>

<style scoped>
.hhh{
  color:rgb(65, 72, 77);
}
.label.label{
  color: white;

}

</style>
