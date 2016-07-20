module WeatherReportProject

  class WeatherForecast
    include HTTParty
    attr_reader :api_key, :response
    BASE_URI = "http://api.apixu.com/"
    VERSION = "/v1/forecast.json"


    API_KEY = ENV["APIXU_KEY"]

    def initialize(loc=nil,days=1)
      # @options = { query: {key: "#{API_KEY}", q: "#{loc}"} }
      @response = get_request(loc,days)
    end

    def get_request(loc,days)
      # self.class.get("#{VERSION}", @options)
      self.class.get("#{BASE_URI}#{VERSION}?key=#{API_KEY}&q=#{loc}&days=#{days}")
      # self.class.get('v1/current.json')
    end

    # http://api.apixu.com/v1/forecast.json?key=eea1db34c14b46a1878161731162007&q=Paris

  end

end

w = WeatherReportProject::WeatherForecast.new("Paris", nil)

p w.response