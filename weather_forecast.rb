
require 'httparty'
require 'figaro'
require 'pp'

WeatherStatus = Struct.new( :time, :hi_temp, :lo_temp, :pressure, :windspeed, :cloud_cover )

class WeatherForecast

  DES_MOINES = 4853828

  def initialize( location=DES_MOINES, num_days=5 )
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
      wind = weather_hash["wind"]["speed"]
      cloud_cover = weather_hash["clouds"]["all"]
      @status_list << WeatherStatus.new(time, hi_temp, lo_temp,
        pressure, wind, cloud_cover )
    end

  end

  def k_to_f(k)
    #T(K) × 9/5 - 459.67
    1.8 * k - 459.67
  end

  def lo_temps
    temps(false)
  end

  def hi_temps
    temps(true)
  end

  def temps(is_max_temp)
    date_temps = {}
    @status_list.each do |status|
      date_str = "#{status.time.month}-#{status.time.day}"
      if is_max_temp
        temp = status.hi_temp
        best_temp = !date_temps[date_str] || temp > date_temps[date_str]
      else
        temp = status.lo_temp
        best_temp = !date_temps[date_str] || temp < date_temps[date_str]
      end
      date_temps[date_str] = temp.round(2) if best_temp
    end
    date_temps
  end

  def today
    daily_status(Time.now)
  end

  def tomorrow
    daily_status(Time.now + 24 * 3600)
  end

  def daily_status(time)
    day_status = WeatherStatus.new
    tomorrow_str = "#{time.month}-#{time.day}"
    @status_list.each do |status|
      status_date_str = "#{status.time.month}-#{status.time.day}"
      if status_date_str == tomorrow_str
        if !day_status.hi_temp || status.hi_temp > day_status.hi_temp
          day_status.hi_temp = status.hi_temp.round(2)
        end
        if !day_status.lo_temp || status.lo_temp < day_status.lo_temp
          day_status.lo_temp = status.lo_temp.round(2)
        end
        day_status.pressure = status.pressure
        day_status.windspeed = status.windspeed
        day_status.cloud_cover = status.cloud_cover
      end
    end
    day_status.time = time
    day_status
  end

end

w = WeatherForecast.new
# puts w.get_api_key
forecast = w.get_forecast
# pp forecast
w.parse_forecast_hash
puts "High Temperatures: "
pp w.hi_temps
puts
puts "Low Temperatures: "
pp w.lo_temps
puts
puts "Today's Forecast: "
pp w.today
puts
puts "Tomorrow's Forcast: "
pp w.tomorrow
puts
