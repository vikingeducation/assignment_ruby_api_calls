

module WeatherReportProject
  require 'pry'

  class WeatherForecast
    include HTTParty
    attr_reader :loc, :days
    BASE_URI = "http://api.apixu.com"
    VERSION = "/v1/forecast.json"
    API_KEY = "f70afbabf5fa4252a10161345162007"#ENV["APIXU_KEY"]

    def initialize(loc="New York",days=1)
      @loc = loc
      @days = days
      @request = self.get_request
    end

    def get_request(loc = @loc, days = @days)
      self.class.get("#{BASE_URI}#{VERSION}?key=#{API_KEY}&q=#{@loc}&days=#{@days}")
    end

    #collection of high temperatures > 80 deg?, organize by date
    def get_hi_temps
      hi_temp_arr = {}
      #array of hashes which represent a single hour of the day (size 24)
      @request["forecast"]["forecastday"][0]["hour"].each do |hash|
        hi_temp_arr[hash["time"]][-5..-1] = hash["temp_f"]
      end
      hi_temp_arr


      #binding.pry

      

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

    # http://api.apixu.com/v1/forecast.json?key=eea1db34c14b46a1878161731162007&q=Paris

  end

end

w = WeatherReportProject::WeatherForecast.new("New York", 3)

#p day1 = w.response["forecast"]["forecastday"][0] #date"=>"2016-07-20
#p w.get_request["forecast"]["forecastday"].length

p w.get_hi_temps
#p day2["forecast"]["forecastday"][0]["hour"] # date should be 2016-07-21
