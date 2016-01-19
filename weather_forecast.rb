
require 'httparty'
require 'figaro'
require 'pp'

WeatherStatus = Struct.new( :time, :hi_temp, :lo_temp, :pressure )

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
    @status_list = []

    @forecast_hash["list"].each do | weather_hash |
      time = Time.at( weather_hash["dt"] ).to_datetime
      hi_temp = k_to_f(weather_hash["main"]["temp_max"])
      lo_temp = k_to_f(weather_hash["main"]["temp_min"])
      pressure = weather_hash["main"]["pressure"]
      @status_list << WeatherStatus.new(time, hi_temp, lo_temp, pressure)
    end

  end

  def k_to_f(k)
    #T(K) × 9/5 - 459.67
    1.8 * k - 459.67
  end

  def lo_temps
    date_temps = {}
    @status_list.each do |status|
      date_str = "#{status.time.month}-#{status.time.day}"
      temp = status.lo_temp
      if !date_temps[date_str] || temp < date_temps[date_str]
        date_temps[date_str] = temp
      end
    end
    pp date_temps
  end

  def hi_temps
    date_temps = {}
    @status_list.each do |status|
      date_str = "#{status.time.month}-#{status.time.day}"
      temp = status.hi_temp
      if !date_temps[date_str] || temp > date_temps[date_str]
        date_temps[date_str] = temp
      end
    end
    pp date_temps
  end

  def today

  end

  def tomorrow

  end

end

w = WeatherForecast.new
# puts w.get_api_key
forecast = w.get_forecast
w.parse_forecast_hash
pp w.hi_temps
