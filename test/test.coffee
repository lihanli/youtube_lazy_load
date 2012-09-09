$ ->
  urls = [
    'http://www.youtube.com/watch?v=uz_cE80JP88&feature=g-vrec'
    'http://youtu.be/uz_cE80JP88'
    'http://youtube.com/watch?v=uz_cE80JP88&feature=g-vrec'
    'http://youtu.be/uz_cE80JP88?t=2s'
    'http://www.youtube.com/watch?v=uz_cE80JP88&t=2s'
    'http://youtube.com/watch?v=uz_cE80JP88&t=2s'
  ]
  for url in urls
    $('.youtubes').append "<div><a class='youtube-lazy-link' href='#{url}'></a></div>"

  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "../lib/youtube_lazy_load.js"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore script, s