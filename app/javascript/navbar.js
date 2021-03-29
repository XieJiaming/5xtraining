document.addEventListener('turbolinks:load', () => {
  const btn = document.querySelector('.navbar-toggler');
  const navbar = document.querySelector('.navbar-collapse');
  btn.addEventListener('click', () => {
    btn.classList.toggle('collapsed')
    navbar.classList.toggle('show')
  })
})