require 'json'
require 'httparty'
require 'pp'


Day = Struct.new(:date, :hi, :lo, :morn, :eve, :humidity, :windspeed, :rain)


class WeatherForecast

  include HTTParty

  base_uri "http://api.openweathermap.org"
  API_KEY = ENV["OPENWEATHERMAP_API_KEY"]

  def initialize(location = "Boston,US", number_of_days = 7)
    @options = { query: {q: location, mode: "json", units: "imperial", cnt: number_of_days, appid: API_KEY} }
    @days = []
    fetch_data
    parse_response
  end


  def hi_temps
    puts "\nHigh temps:"
    @days.each { |day| puts "\t#{day.date}: #{day.hi}F"}
    return nil
  end


  def lo_temps
    puts "\nLow temps:"
    @days.each { |day| puts "\t#{day.date}: #{day.lo}F"}
    return nil
  end


  def today
    today = @days.first
    puts "\nToday: #{today.date}"
    day_summary(today)
  end


  def tomorrow
    tomorrow = @days[1]
    puts "\nTomorrow: #{tomorrow.date}"
    day_summary(tomorrow)
  end


  def rain
    puts "\nRain forecast:"
    @days.each do |day|
      inches_of_rain = mm_to_inches(day.rain[1])
      puts "  #{day.date}: #{day.rain[0]}, #{inches_of_rain} inches."
    end
    return nil
  end


  def best_sailing_day
    good_days = @days.select do |day|
      day.rain[1] < 1 && day.windspeed >4
    end

    best_day = good_days.sort_by { |day| day.hi }[0]

    if best_day.nil?
      puts "Sorry, no good days for sailing coming up."
    else
      puts "\nBest sailing day is #{best_day.date}."
      day_summary(best_day)
    end

  end


  def least_humid_days
    puts "Upcoming days sorted by lowest humidity:"
    @days.sort_by { |day| day.humidity }.each do |day|
      puts "\t#{day.date}: #{day.humidity}%"
    end
    return nil
  end


  private


  def fetch_data
    @response = self.class.get('/data/2.5/forecast/daily', @options)
  end


  def parse_response
    response_body = JSON.parse(@response.body)
    days = response_body["list"]

    days.each do |day|
      date = Time.at(day["dt"]).to_date
      hi_temp = day["temp"]["max"]
      lo_temp = day["temp"]["min"]
      morn_temp = day["temp"]["morn"]
      eve_temp = day["temp"]["eve"]
      humidity = day["humidity"]
      windspeed = day["speed"]
      rain = [ day["weather"][0]["description"], day["rain"] || 0 ]
      @days << Day.new(date, hi_temp, lo_temp, morn_temp, eve_temp, humidity, windspeed, rain)
    end

  end

  def day_summary(day)
    puts "High temperature: #{day.hi}F"
    puts "Low temperature: #{day.lo}F"
    puts "  Morning commute: #{day.morn}F"
    puts "  Evening commute: #{day.eve}F"
    puts "Rain forecast: #{day.rain[0]}, #{mm_to_inches(day.rain[1])} inches."
    puts "Humidity: #{day.humidity}%"
    puts "Wind speed: #{day.windspeed} MPH"
  end

  def mm_to_inches(mm)
    (mm * 0.0393701).round(2)
  end


end