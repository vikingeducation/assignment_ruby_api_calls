require_relative './config'

module WeatherReportProject

  class WeatherForecast
    attr_reader :api_key

    def initialize(loc,days=1,options={})
      @api_key = ENV["APIXU_KEY"]
    end

  end

end

w = WeatherReportProject::WeatherForecast.new(nil, nil)

p w.api_key