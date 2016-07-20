module WeatherReportProject

  class WeatherForecast
    include HTTParty
    attr_reader :response
    base_uri "http://api.apixu.com/"
    VERSION = "/v1/forecast.json"

    def initialize
    end

    def get_request(params)
      options = { query: params }
      if params['days'].nil?
        params['days'] = 1
      end
      @response = self.class.get("#{VERSION}", options)
    end

  end

end

