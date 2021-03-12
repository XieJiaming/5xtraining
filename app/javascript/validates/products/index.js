document.addEventListener('turbolinks:load', () => {
  const name_input = document.querySelector('.products > .container > form > .input > .field > #product_name')
  const price_input = document.querySelector('.products > .container > form > .input > .field > #product_price')
  const inputs_blank_validate = [name_input, price_input]

  const form = document.querySelector('form')
  console.log(form)
  const submitbtn = document.querySelector('.submit > input')


  // check input form is empty on focusout event
  if (inputs_blank_validate) {
    inputs_blank_validate.forEach(input => {
      if (input) {
        input.addEventListener('focusout', (e) => {
    
          if (input.value.trim() === '') {
            input.classList.add('not_null')
            input.parentElement.nextElementSibling.textContent = '*Can Not Be Empty'
          } else {
            input.classList.remove('not_null')
            input.parentElement.nextElementSibling.textContent = ''
          }
          
        })     
      }
    })
  }
  
  // check input form is empty on submit button is clicked
  if (submitbtn) {
    submitbtn.addEventListener('click', (e) => {
      e.preventDefault()
  
      let contains_empty = false
      if (inputs_blank_validate) {
        inputs_blank_validate.forEach(input => {
          if (input) {
            if (input.value.trim() === '') {
              input.classList.add('not_null')
              input.parentElement.nextElementSibling.textContent = '*Can Not Be Empty'
              contains_empty = contains_empty | true
            } else {
              input.classList.remove('not_null')
              input.parentElement.nextElementSibling.textContent = ''
              contains_empty = contains_empty | false
            }
          }
        })
      }
      console.log(contains_empty)
      if (!contains_empty) {
        form.submit()
      }
    })  
  }
})