
require 'httparty'
require 'figaro'
require 'pp'

WeatherStatus = Struct.new( :unix_time, :temp_kelvin, :pressure_mmhg )

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

    @forecast_hash = HTTParty.get( @api_call )
  end

  def parse_forecast_hash
    curr_times = []

    @forecast_hash["list"].each do | weather_hash |
      curr_times << Time.at( weather_hash["dt"] ).to_datetime
    end

    pp curr_times

  end

end

w = WeatherForecast.new
# puts w.get_api_key
forecast = w.get_forecast
w.parse_forecast_hash

