require 'pry'
require 'httparty'
require_relative './config'
require_relative './weatherforecast'


module WeatherReportProject

  class Main
    def self.run
      #Running main creates a new WeatherForecast object.
      WeatherReportProject::WeatherForecast.new
    end
  end

end

w = WeatherReportProject::Main.run

params = {'key' => "#{API_KEY}", 'q' => "Paris", 'days' => '3' }
