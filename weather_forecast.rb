require 'httparty'
require 'pp'
require 'json'
require 'pry-byebug'

class WeatherForecast

  include HTTParty
  base_uri 'api.openweathermap.org'
  API_KEY = ENV["API_WEATHER_KEY"]

  def initialize(location = 'Glen Cove', days = 5)

    # ensure valid number of days
    raise 'invalid number of days' if days < 1 || days > 16

    # assumes location is in the US
    @options = { :query => {q: location, mode: 'json', units: 'imperial', cnt: days, APPID: API_KEY} }

    # holds daily forecast breakdown for each day
    @daily_forecast = []

    get_forecast
    daily_breakdown

  end

  def get_forecast

    # API call: api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}
    # binding.pry
    @forecast = self.class.get("/data/2.5/forecast/daily", @options)

  end

  def hi_temps

    # displays the high temperatures for each day
    puts "\nDaily High Temperatures:"
    @daily_forecast.each { |day| puts "\t#{day[0]}: #{day[3]}" }

  end

  def low_temps

    # displays the low temperatures for each day
    puts "\nDaily Low Temperatures:"
    @daily_forecast.each { |day| puts "\t#{day[0]}: #{day[2]}" }

  end

  def daily_humidity

    # displays the humidity % for each day
    puts "\nDaily Humidity:"
    @daily_forecast.each { |day| puts "\t#{day[0]}: #{day[8]}%" }

  end

  def temps_sorted

    # displays sorted temperatures
    puts "\nTemperatures of days from lowest to highest:"
    @daily_forecast.sort_by { |day| day[1] }.each do |day|
      puts "\t#{day[0]}: #{day[1]}"
    end

  end

  def humidity_sorted

    # displays sorted daily humidities
    puts "\nDaily humidities from lowest to highest:"
    @daily_forecast.sort_by { |day| day[8] }.each do |day|
      puts "\t#{day[0]}: #{day[8]}%"
    end

  end

  def today

    # displays forecast breakdown of current day
    print_daily_breakdown(@daily_forecast[0])

  end

  def tomorrow

    # displays forecast breakdown of next day
    print_daily_breakdown(@daily_forecast[1])

  end

  def print_daily_breakdown(day)

    # displays forecast breakdown of chosen day
    puts "\nDaily Breakdown for: #{day[0]}"
    puts "\tTemperature: #{day[1]}"
    puts "\tLow Temperature: #{day[2]}"
    puts "\tHigh Temperature: #{day[3]}"
    puts "\tNight Temperature: #{day[4]}"
    puts "\tEvening Temperature: #{day[5]}"
    puts "\tMorning Temperature: #{day[6]}"
    puts "\tPressure: #{day[7]}hPa"
    puts "\tHumidity: #{day[8]}%"
    puts "\tWeather Description: #{day[9].capitalize}"
    puts "\tWind Speeds: #{day[10]}mph"
    puts "\tChance of Clouds: #{day[11]}%"
    puts "\tRain Accumulation: #{day[12]}mm"

  end

  # creates an array containing daily forecast information for number of days
  def daily_breakdown

    response = JSON.parse(@forecast.body)

    # only look at info of 'list' for daily breakdown
    days = response['list']

    days.each do |day|
      date = Time.at(day['dt']).to_date
      current_temp = day['temp']['day']
      min_temp = day['temp']['min']
      max_temp = day['temp']['max']
      night_temp = day['temp']['night']
      eve_temp = day['temp']['eve']
      morn_temp = day['temp']['morn']
      pressure = day['pressure']
      humidity = day['humidity']
      weather = day['weather'][0]['description']
      speed = day['speed']
      clouds = day['clouds']
      rain = day['rain']

      @daily_forecast << [date, current_temp, min_temp, max_temp, night_temp, eve_temp, morn_temp, pressure, humidity, weather, speed, clouds, rain]

    end

  end

end

# test = WeatherForecast.new
# test.hi_temps
# test.low_temps
# test.daily_humidity
# test.today
# test.tomorrow
# test.temps_sorted
# test.humidity_sorted