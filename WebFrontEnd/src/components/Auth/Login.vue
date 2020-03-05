<template>
  <div id="signin">
    <b-form @submit.prevent="onSubmit" style="padding: 20%">
      <b-form-group
        id="username-input-group"
        label="Username:"
        label-for="username-input"
        >
        <b-form-input
          id="username-input"
          type="text"
          required
          placeholder="Enter Username"
          v-model="username"
        ></b-form-input>
      </b-form-group>

      <b-form-group
       id="password-input-group"
       label="Password:"
       label-for="password-input"
       >
        <b-form-input
          id="password-input"
          type="password"
          required
          placeholder="Enter Password"
          v-model="password"
        ></b-form-input>
      </b-form-group>

      <b-button type="submit" variant="primary">Submit</b-button>
      </b-form>
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
      // TODO: Waiting for DB
      //  this.$store.dispatch('login', { username: formData.username, password: formData.password })
    }
  }
}
</script>

<style scoped>

</style>
