
require 'httparty'
require 'pp'

# WEATHER_KEY=c7d03f3100e9ddf717202ea0da08181f

class WeatherForcast

  include HTTParty

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/city"
# http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}
  API_KEY = ENV["WEATHER_KEY"]

  VALID_DAYS = [1,2,3,4]
  VALID_ID = [7778677]

  def initialize(location_id = 7778677 , num_of_days = 3)
    validate_days_limit!(num_of_days)
    validate_location_id!(location_id)

    @num_of_days = num_of_days
    @location_id = location_id
    @options = {query:{id: @location_id, APPID: API_KEY}}
  end

  def get_raw_response
    HTTParty.get(BASE_URI, @options)
  end

  def hi_temps
    response = get_raw_response["list"]
    response.map do |daytime|
      break if Time.at(daytime["dt"]) == last_day_forcast(@num_of_days)
      [format_date(Time.at(daytime["dt"])), format_temp(daytime["main"]["temp_max"])]
    end
  end

  def lo_temps
    response = get_raw_response["list"]
    response.map do |daytime|
      break if Time.at(daytime["dt"]) == last_day_forcast(@num_of_days)
      [format_date(Time.at(daytime["dt"])), format_temp(daytime["main"]["temp_min"])]
    end
  end

  def today
    response = get_raw_response["list"]
    time_weather_now = Time.at(response[0]["dt"])
    today_forecast = []
    response.each do |daytime|
      break if time_weather_now > deadline_forcast(1)
      if Time.at(daytime["dt"]) == time_weather_now
        time_weather_now += 6*60*60 # added 6 hours
        today_forecast << get_data(daytime)
      else
        next
      end
    end
    today_forecast
  end

  def tomorrow
    response = get_raw_response["list"]
    time_weather_now = deadline_forcast(1) + 9*60*60
    tomorrow_forecast = []
    response.each do |daytime|
      break if time_weather_now >= deadline_forcast(2)
      if Time.at(daytime["dt"]) == time_weather_now
        time_weather_now += 6*60*60 # added 6 hours
        tomorrow_forecast << get_data(daytime)
      else
        next
      end
    end
    tomorrow_forecast
  end

  def wind
    response = get_raw_response["list"]
    response.map do |daytime|
      break if Time.at(daytime["dt"]) == last_day_forcast(@num_of_days)
      [format_date(Time.at(daytime["dt"])), daytime["wind"]["speed"]] #m/s
    end
  end

  def humidity
    response = get_raw_response["list"]
    response.map do |daytime|
      break if Time.at(daytime["dt"]) == last_day_forcast(@num_of_days)
      [format_date(Time.at(daytime["dt"])), daytime["main"]["humidity"]] #m/s
    end
  end

  private

  def format_date(date)
    date.strftime('%H:%M %d %b')
  end

  def format_temp(temp)
    (temp - 273.15).round(1) #C
  end

  def last_day_forcast(num_of_days)
    Time.now + (num_of_days*24*60*60)
  end

  def deadline_forcast(days_added)
    t = Time.now
    Time.new(t.year, t.mon, t.day + days_added, 00, 00, 00)
  end

  def get_data(daytime)
    {
      :date             =>  format_date(Time.at(daytime["dt"])),
      :temp_max         =>  format_temp(daytime["main"]["temp_max"]),
      :temp_min         =>  format_temp(daytime["main"]["temp_min"]),
      :humidity         =>  daytime["main"]["humidity"],
      :wind             =>  daytime["wind"]["speed"],
      :rain             =>  daytime["rain"].values,
      :cloudiness       => daytime["clouds"].values,
      :description      => daytime["weather"][0]["description"],
    }
  end

  def validate_days_limit!(num_of_days)
    unless VALID_DAYS.include?(num_of_days)
      raise "Invalid number of days format"
    end
  end


  def validate_location_id!(location_id)
    unless VALID_ID.include?(location_id)
      raise "Invalid location ID or location not identifiable by us yet:( "
    end
  end

end

new_weather = WeatherForcast.new
# pp new_weather.hi_temps
# pp new_weather.lo_temps

new_weather.hi_temps.each { |temp| puts "highest temp on #{temp[0]} is #{temp[1]} (st C)" }
new_weather.lo_temps.each { |temp| puts "lowest temp on #{temp[0]} is #{temp[1]} (st C)" }
new_weather.wind.each { |wind| puts "wind speed on #{wind[0]}is #{wind[1]} (m/s)" }
new_weather.humidity.each { |hum| puts "#humidity on #{hum[0]} is #{hum[1]}%" }
new_weather.tomorrow.each { |data| puts "the weather on #{data[:date]} - #{data[:description]},  temp max: #{data[:temp_max]}, temp_min: #{data[:temp_min]}, humidity: #{data[:humidity]}, wind speed: #{data[:wind]}, rain: #{data[:rain]} mm over next 3h, cloud cover: #{data[:cloudiness]}"}
new_weather.today.each { |data| puts "the weather on #{data[:date]} - #{data[:description]}, temp max: #{data[:temp_max]}, temp_min: #{data[:temp_min]}, humidity: #{data[:humidity]},  wind speed: #{data[:wind]}, rain: #{data[:rain]} mm over next 3h, cloud cover: #{data[:cloudiness]}" }
