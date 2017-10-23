require 'dotenv/load'

require 'httparty'
require 'pp'
require 'awesome_print'
require 'json'
require 'date'

require 'pry'

class WeatherForecast
  attr_accessor :raw_response
  def initialize(location: 70115, days: 1)
    @location = location
    @days = days
    @raw_response = {}
  end

  API_KEY = ENV['API_KEY']

  BASE_URI = "http://api.openweathermap.org"

  # url = "api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}"


  def send_request
    url = "#{BASE_URI}/data/2.5/forecast?zip=#{@location}&APPID=#{API_KEY}"
    response = HTTParty.get(url)
    save_response(response)
  end

  def save_response(response)
    File.open("data/temp.json","w") do |f|
      f.write(response)
    end
  end

  def high_temps
    # should be a collection of the high temperatures you get back, organized by date
    retrieve_saved_response

    puts "High Temperatures for #{@raw_response['city']['name']}"
    dates = {}
    @raw_response['list'].each do |date|
      dates[parse_date(date['dt_txt'])] ||= []
      max = date['main']['temp_max']
      dates[parse_date(date['dt_txt'])] << convert_to_fahrenheit(max)
    end
    # render_temps_data(dates)
  end

  def low_temps
    # should be a collection of the low temperatures you get back, organized by date
    retrieve_saved_response
    render_temps_data(type: 'Low', key: 'temp_min')
  end

  def today
    # should be convenient breakdowns of just this single day forecast
    retrieve_saved_response
    today = Date.today.strftime('%m-%d-%Y')
    render_day_data(today)
  end

  def tomorrow
    # should be convenient breakdowns of just this single day forecast
    retrieve_saved_response
    tomorrow = Date.today + 1
    tomorrow = tomorrow.strftime('%m-%d-%Y')
    render_day_data(tomorrow)
  end

  def parse_date(date)
    Date.parse(date).strftime('%m-%d-%Y')
  end

  private

  def retrieve_saved_response
    @raw_response = JSON.parse(File.read("data/temp.json"))
  end

  def convert_to_fahrenheit(k)
    f = (1.8 * (k - 273)) + 32
    f.round(1)
  end

  def render_day_data(day)
    temps = @raw_response['list'].select do |date|
      parse_date(date['dt_txt']) == day
    end

    stats = {
      high_temps: [],
      low_temps: [],
      humidities: [],
      description: []
    }

    temps.each do |temp|
      stats[:high_temps] << temp['main']['temp_max']
      stats[:low_temps] << temp['main']['temp_min']
      stats[:humidities] << temp['main']['humidity']
      stats[:description] << temp['weather'][0]['description']
    end

    high_temp = convert_to_fahrenheit(stats[:high_temps].max)
    low_temp = convert_to_fahrenheit(stats[:low_temps].min)
    avg_humidity = (stats[:humidities].reduce(&:+))/temps.length
    description = stats[:description].uniq.join(', ')

    puts "Weather for #{@raw_response['city']['name']} #{day}:"
    puts "High: #{high_temp}F"
    puts "Low: #{low_temp}F"
    puts "Average Humidity: #{avg_humidity}%"
    puts "Description: #{description}"
  end

  def render_temps_data(type:, key:)
    puts "#{type} Temperatures for #{@raw_response['city']['name']}"
    dates = {}
    @raw_response['list'].each do |date|
      dates[parse_date(date['dt_txt'])] ||= []
      temp = date['main'][key]
      dates[parse_date(date['dt_txt'])] << convert_to_fahrenheit(temp)
    end

    dates.each do |date, temps|
      puts "","#{type} Temperatures for #{date}"
      temps.each do |temp|
        puts "#{temp}F"
      end
    end
  end
end

forecast = WeatherForecast.new(location: 15601, days: 5)
# forecast.retrieve_saved_response
# ap forecast.raw_response
forecast.low_temps
