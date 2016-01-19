
require 'httparty'
require 'figaro'
require 'pp'

WeatherStatus = Struct.new( :time, :hi_temp, :lo_temp, :pressure, :windspeed, :cloud_cover )

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
    date_temps = {}
    @status_list.each do |status|
      date_str = "#{status.time.month}-#{status.time.day}"
      temp = status.lo_temp
      if !date_temps[date_str] || temp < date_temps[date_str]
        date_temps[date_str] = temp
      end
    end
    date_temps
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
    date_temps
  end

  def today
    today_status = WeatherStatus.new
    time_today = Time.now
    today_str = "#{time_today.month}-#{time_today.day}"
    @status_list.each do |status|
      status_date_str = "#{status.time.month}-#{status.time.day}"
      if status_date_str == today_str 
        if !today_status.hi_temp || status.hi_temp > today_status.hi_temp
          today_status.hi_temp = status.hi_temp
        end
        if !today_status.lo_temp || status.lo_temp < today_status.lo_temp
          today_status.lo_temp = status.lo_temp
        end
        today_status.pressure = status.pressure
        today_status.windspeed = status.windspeed
        today_status.cloud_cover = status.cloud_cover
      end
    end
    today_status.time = time_today
    today_status
  end

  def tomorrow
    tomorrow_status = WeatherStatus.new
    time_tomorrow = Time.now + 24 * 3600
    tomorrow_str = "#{time_tomorrow.month}-#{time_tomorrow.day}"
    @status_list.each do |status|
      status_date_str = "#{status.time.month}-#{status.time.day}"
      if status_date_str == tomorrow_str 
        if !tomorrow_status.hi_temp || status.hi_temp > tomorrow_status.hi_temp
          tomorrow_status.hi_temp = status.hi_temp
        end
        if !tomorrow_status.lo_temp || status.lo_temp < tomorrow_status.lo_temp
          tomorrow_status.lo_temp = status.lo_temp
        end
        tomorrow_status.pressure = status.pressure
        tomorrow_status.windspeed = status.windspeed
        tomorrow_status.cloud_cover = status.cloud_cover
      end
    end
    tomorrow_status.time = time_tomorrow
    tomorrow_status
  end

end

w = WeatherForecast.new
# puts w.get_api_key
forecast = w.get_forecast
# pp forecast
w.parse_forecast_hash
pp w.hi_temps
pp w.today
pp w.tomorrow
