module WeatherReportProject
  require 'pry'

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
    
    def get_hi_temps
      hi_temp_arr = {}
      @response["forecast"]["forecastday"].each do |hash|
        hi_temp_arr[hash["date"]]= hash["day"]["maxtemp_f"]
      end
      hi_temp_arr
    end

    def get_lo_temps
      lo_temp_arr = {}
      @response["forecast"]["forecastday"].each do |hash|
        lo_temp_arr[hash["date"]] = hash["day"]["mintemp_f"]   
      end
      lo_temp_arr
    end

    def today
      hourly_temp = {}
      @response["forecast"]["forecastday"][0]["hour"].each do |hash|
        hourly_temp[hash["time"]] = hash["temp_f"]
      end
      hourly_temp
    end

    def tomorrow
      hourly_temp = {}
      @response["forecast"]["forecastday"][1]["hour"].each do |hash|
        hourly_temp[hash["time"]] = hash["temp_f"]
      end
      hourly_temp
    end
  end
end