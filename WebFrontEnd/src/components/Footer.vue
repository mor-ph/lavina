<template>
  <b-container fluid>
    <div>
      <!-- Footer -->
      <footer class="fixed-bottom">
        <div class="footer p-2 d-flex justify-content-between">
            <b-container fluid>
              <span><b-icon class="icon" icon="envelope-fill"></b-icon></span>
              <span>info@codecoda.com</span>
            </b-container>
          <div class="text-center">
            <b-container fluid>
              &copy; 2020 Copyright:
              <span>
                <a href="https://codecoda.com/en" style="color:white">Codecoda.com</a>
              </span>
            </b-container>
          </div>
        </div>
      </footer>
      <!-- Footer -->
    </div>
  </b-container>
</template>
<script>
</script>
<style scoped>
.text-center,
.text-left {
  padding-top: 0.5%;
}
.footer {
  background-color: #7da2a9;
  padding-top: 0.7%;
  padding-left: 0.7%;
  padding-right: 0.7%;
  padding-bottom: 0%;
  width: 100%;
}
.icon {
  margin: 0.3%;
  margin-left: 1.3%;
  outline-style: inset;
  outline-color: rgb(250, 220, 85);
}
.link {
  color: rgb(250, 220, 85);
}
footer {
  position: absolute;
}
</style>
