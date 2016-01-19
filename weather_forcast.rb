
require 'httparty'
require 'figaro'

class WeatherForecast


  def initialize( location=4853828, num_days=5 )
    @location = location
    @num_days = num_days
    Figaro.application = Figaro::Application.new({environment: "development", path:"./config/application.yml"} )
    Figaro.load
  end

  def get_api_key
    Figaro.env.api_key
  end

  def get_forecast
    @api_call = "http://api.openweathermap.org/data/2.5/forecast?id=#{@location}"
    @api_call << "&APPID=#{get_api_key}"
    HTTParty.get( @api_call )
  end

end

w = WeatherForecast.new
# puts w.get_api_key
puts w.get_forecast
