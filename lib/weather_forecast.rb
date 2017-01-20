require 'httparty'

class WeatherForecast
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5'

  attr_reader :dates, :hi_temps, :lo_temps, :description, :humidity, :wind, :humdity

  def initialize(location = '5128638', num_days = '3')
    @options = { query: { id: location, cnt: num_days, appid: ENV['OPEN_WEATHER_API_KEY'] } }
    response = get_forecast
    @city = response.parsed_response['city']
    @forecast_data = response.parsed_response['list']
    @dates = get_dates
    @hi_temps = hi_temps
    @lo_temps = lo_temps
    @description = weather_description
    @cloudiness = cloudiness
    @wind = wind_speed_and_direction
    @humidity = humidity
  end

  def display_location
    puts "#{@city['name']}, #{@city['country']} (#{@city['coord']['lat']}, #{@city['coord']['lon']})"
  end

  def display_all
    data = [@dates, @hi_temps, @lo_temps, @description, @cloudiness, @wind, @humidity]
    data.each do |subarray|
      subarray.each { |data_point| print data_point.to_s.ljust(18) }
      puts
    end
  end

  def today
    today = Time.now.strftime("%-m/%d")
    today_index = @dates.find_index(today)
    return "Forecast data not found for #{today}!" if today_index.nil?
    display_weather_data('today', today, today_index)
  end

  def tomorrow
    tmrw = (Time.now + 86400).strftime("%-m/%d")
    tmrw_index = @dates.find_index(tmrw)
    return "Forecast data not found for #{tomorrow}!" if tmrw_index.nil?
    display_weather_data('tomorrow', tmrw, tmrw_index)
  end

  private

  def display_weather_data(date_description, date, index)
    puts "Weather for #{date_description} (#{date}):"
    puts "> hi: #{@hi_temps[index]}K, lo: #{@lo_temps[index]}K"
    puts "> #{@description[index]}, #{@cloudiness[index]}% cloudiness"
    puts "> wind speed of #{@wind[index][0]} meters/sec at #{@wind[index][1]} deg"
    puts "> #{@humidity[index]}% humidity"
  end

  def get_dates
    dates = []
    @forecast_data.each { |d| dates << Time.at(d['dt']).strftime("%-m/%d") }
    dates
  end

    # temps in Kelvin
  def hi_temps
    hi_temps = []
    @forecast_data.each { |d| hi_temps << d['temp']['max'] }
    hi_temps 
  end

  def lo_temps
    lo_temps = []
    @forecast_data.each { |d| lo_temps << d['temp']['min'] }
    lo_temps 
  end

  def weather_description
    weather_description = []
    @forecast_data.each { |d| weather_description << d['weather'][0]['description'] }
    weather_description
  end

  def cloudiness
    cloud = []
    @forecast_data.each { |d| cloud << d['clouds'] }
    cloud 
  end

  # speed in meter/sec, direction in degrees (meterological)
  def wind_speed_and_direction
    wind = []
    @forecast_data.each { |d| wind << [d['speed'], d['deg']] }
    wind
  end

  def humidity
    humidity = []
    @forecast_data.each { |d| humidity << d['humidity'] }
    humidity 
  end

  def get_forecast
    self.class.get("/forecast/daily", @options)
  end
end

weather = WeatherForecast.new
weather.display_location
weather.display_all
weather.today
weather.tomorrow



