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
      @response["forecast"]["forecastday"].each do |hash|
        max_temp = hash["day"]["maxtemp_f"]
        hi_temp_arr[hash["date"]] = max_temp
      end
      hi_temp_arr
    end

    def get_lo_temps
      lo_temp_arr = {}
      #array of hashes which represent a single hour of the day (size 24)
      @response["forecast"]["forecastday"].each do |hash|
        min_temp = hash["day"]["mintemp_f"]
        lo_temp_arr[hash["date"]] = min_temp      
      end
      lo_temp_arr
    end

    def today
      hourly_temp = {}
      #array of hashes which represent a single hour of the day (size 24)
      @response["forecast"]["forecastday"][0]["hour"].each do |hash|
        hourly_temp[hash["time"]] = hash["temp_f"]
      end
      hourly_temp
    end

    def tomorrow
      hourly_temp = {}
      #array of hashes which represent a single hour of the day (size 24)
      @response["forecast"]["forecastday"][1]["hour"].each do |hash|
        hourly_temp[hash["time"]] = hash["temp_f"]
      end
      hourly_temp
    end

  end

end