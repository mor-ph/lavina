<template>
  <b-container fluid>
    <div>
      <!-- Footer -->
      <footer >
        <div class="footer p-2 d-flex justify-content-between">
            <b-container fluid>
              <span><b-icon class="icon" icon="envelope-fill"></b-icon></span>
              <span> info@codecoda.com</span>
            </b-container>
            <b-container fluid class="text-right">
              &copy; 2020 Copyright:
              <span>
                <a href="https://codecoda.com/en" style="color:white"><span>Codecoda.com</span></a>
              </span>
            </b-container>
        </div>
      </footer>
      <!-- Footer -->
    </div>
  </b-container>
</template>
<script>

</script>

<style scoped>
.text-center {
  padding-top: 0.5%;
}
/* .footer {
  background-color: #7da2a9;
  padding: 0.7%;
  padding-bottom: 0%;
  width: 100%;
} */
.icon {
  margin: 0.3%;
  outline-style: inset;
  outline-color: white;
  padding-right: 0.3%;
}
footer{
  position: fixed;
  left: 0;
  bottom: 0;
  height: 2.5rem;
  width: 100%;
  background-color: #7da2a9;
}
</style>
