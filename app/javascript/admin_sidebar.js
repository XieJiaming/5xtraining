document.addEventListener('turbolinks:load', () => {
  const body = document.querySelector('body')

  const items = ['users', 'products']
  items.forEach(item => {
    const contains = document.querySelector(`body,.${item}, .index`)
    const lis = contains.querySelectorAll('.nav-pills > li')
    lis.forEach( li => {

      if (body.classList.contains(li.querySelector('a').textContent.toLowerCase())) {
        li.classList.add('nav-item')
        li.querySelector('a').classList.add('active')
        li.querySelector('a').classList.remove('text-white')
      }else {
        li.classList.remove('nav-item')
        li.querySelector('a').classList.remove('active')
        li.querySelector('a').classList.add('text-white')
      }
    })
  });
})