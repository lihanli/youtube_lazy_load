PROJECT_NAME = 'youtube_lazy_load'
SCRIPT_FILE = "lib/#{PROJECT_NAME}.js"
CSS_FILE = "lib/#{PROJECT_NAME}.css"

task :build do
  #`cat src/js/*.js | uglifyjs > #{SCRIPT_FILE}`
  `coffee -p -c src | uglifyjs > #{SCRIPT_FILE}`
  `stylus -c < src/css/#{PROJECT_NAME}.styl > #{CSS_FILE}`
end