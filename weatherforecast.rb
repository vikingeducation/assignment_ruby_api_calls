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
    
    #collection of high temperatures > 80 deg?, organize by date
    def get_hi_temps
      hi_temp_arr = {}
      #array of hashes which represent a single hour of the day (size 24)
      @response["forecast"]["forecastday"][0]["hour"].each do |hash|
        hi_temp_arr[hash["time"]] = hash["temp_f"]
      end
      hi_temp_arr
    end

    #single day, every hour temperature
    def get_hourly_temperature

    end

    def get_lo_temps
    end

    def today
    end

    def tomorrow
    end

  end

end