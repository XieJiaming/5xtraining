document.addEventListener('turbolinks:load', () => {
  const body = document.querySelector('body')

  const items = ['index', 'user', 'product']
  items.forEach(item => {
    let contains = document.querySelector(`body,.admins,.${item}`)
    let lis = contains.querySelectorAll('.nav-pills > li')
    lis.forEach( li => {
      let content = li.querySelector('a').textContent

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