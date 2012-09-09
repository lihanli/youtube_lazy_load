require 'rubygems'

task :build do
  PROJECT_NAME = 'youtube_lazy_load'
  SCRIPT_FILE = "lib/#{PROJECT_NAME}.js"
  CSS_FILE = "lib/#{PROJECT_NAME}.css"

  `coffee -p -c src | uglifyjs > #{SCRIPT_FILE}`
  `stylus -c < src/css/#{PROJECT_NAME}.styl > #{CSS_FILE}`
end

task :test do
  require 'selenium-webdriver'
  require 'minitest/autorun'
  require 'turn'

  class YoutubeLazyLoadTest < MiniTest::Unit::TestCase
    def setup
      @driver = Selenium::WebDriver.for :firefox
      @driver.manage.timeouts.implicit_wait = 0
      @WAIT = Selenium::WebDriver::Wait.new(timeout: 45)
      @driver.get "file://#{Dir.pwd}/test/test.html"
    end

    def wait_for_element(type, name)
      element = -> { fe(type, name) }
      wait_until { element.().displayed? }
      element.()
    end

    def wait_until(&block)
      @WAIT.until &block
    end

    def fe(type, name)
      @driver.find_element type, name
    end

    def verify_youtube(element, code, time = false)
      iframes = -> { @driver.find_elements(:tag_name, 'iframe') }
      old_iframe_count = iframes.().size
      element.click

      wait_until { iframes.().size == old_iframe_count + 1 }

      iframe = iframes.().last

      assert_equal '480', iframe.attribute('width')
      assert_equal '360', iframe.attribute('height')

      if time
        assert_equal "http://www.youtube.com/embed/#{code}?autoplay=1#t=#{time}", iframe.attribute('src')
      else
        assert_equal "http://www.youtube.com/embed/#{code}?autoplay=1", iframe.attribute('src')
      end

      assert_equal '', iframe.attribute('allowfullscreen')
    end

    def test_youtube_lazy_load
      youtube_links = -> { @driver.find_elements(:class, 'youtube-lazy-link') }
      wait_until { youtube_links.().size == 6 }
      youtube_links = youtube_links.()

      (0..2).each do |i|
        verify_youtube youtube_links[i], 'uz_cE80JP88'
      end
      (3..5).each do |i|
        verify_youtube youtube_links[i], 'uz_cE80JP88', '2s'
      end

      @driver.quit
    end
  end
end