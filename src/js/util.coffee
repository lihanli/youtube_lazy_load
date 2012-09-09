getUrlParams = (parser) ->
  urlParams = {}
  pl = /\+/g # Regex for replacing addition symbol with a space
  search = /([^&=]+)=?([^&]*)/g
  decode = (s) ->
    decodeURIComponent s.replace(pl, " ")

  query = parser.search.substring(1)
  urlParams[decode(match[1])] = decode(match[2]) while match = search.exec(query)
  urlParams

$ ->
  $('a.youtube-lazy-link').each ->
    parser = document.createElement('a')
    parser.href = $(@).attr('href')
    return unless parser.host == 'www.youtube.com' || parser.host == 'youtube.com' || parser.host == 'youtu.be'
    params = getUrlParams(parser)
    if parser.host == 'youtu.be'
      youid = parser.pathname.replace('/','')
    else
      youid = params.v
    embedCode = "#{youid}?autoplay=1"
    embedCode += "#t=#{params.t}" if params.t?

    youtubeTitle = $(@).text()
    $(@).html("<div class=\"youtube-lazy-link-info\">#{youtubeTitle}</div>") unless isBlank(youtubeTitle)
    $(@).prepend "<div class=\"youtube-lazy-link-div\"></div>"
    $(@).css "background", "#000 url(http://i2.ytimg.com/vi/#{youid}/0.jpg) center center no-repeat"

    videoFrame = "<iframe width=\"" + parseInt($(@).css("width")) + "\" height=\"" + parseInt($(@).css("height")) + "\" style=\"vertical-align:top;\" src='http://www.youtube.com/embed/#{attrEscape embedCode}' frameborder=\"0\" allowfullscreen></iframe>"
    $(@).click ->
      $(@).replaceWith videoFrame
      false