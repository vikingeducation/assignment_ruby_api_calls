require 'httparty'
require_relative './weatherforecast'
require_relative './config'

module WeatherReportProject

  class Main
    def self.run(loc,days=1)
      WeatherReportProject::WeatherForecast.new(loc,days)
    end
  end

end