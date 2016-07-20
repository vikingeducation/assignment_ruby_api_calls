require 'figaro'
require 'env'
require 'httparty'
require 'weatherforecast'


module WeatherReportProject

  class Main
    def self.run(loc,days=1)
      WeatherReportProject::WeatherForecast.new(loc,days)
    end
  end

end