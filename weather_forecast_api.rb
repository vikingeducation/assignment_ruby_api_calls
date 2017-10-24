require 'dotenv/load'

require 'httparty'
require 'pp'
require 'awesome_print'
require 'json'
require 'date'

require 'pry'

class WeatherForecast

  def initialize(zip: 70115, days: 1)
    @zip = zip
    @days = days
    @raw_response = set_raw_response
  end

  API_KEY = ENV['API_KEY']
  BASE_URI = "http://api.openweathermap.org"

  def send_request
    # return unless @raw_response.empty?
    # url = "#{BASE_URI}/data/2.5/forecast?zip=#{@zip}&cnt=#{@days}&APPID=#{API_KEY}"
    # url = "#{BASE_URI}/data/2.5/forecast/daily?zip=#{@zip}&cnt=#{@days}&APPID=#{API_KEY}"
    url = "#{BASE_URI}/data/2.5/forecast?zip=#{@zip}&APPID=#{API_KEY}"

    response = HTTParty.get(url)
    save_response(response)
  end

  def high_temps
    render_temps_data(type: 'High', key: 'temp_max')
  end

  def low_temps
    render_temps_data(type: 'Low', key: 'temp_min')
  end

  def today
    today = Date.today.strftime('%m-%d-%Y')
    render_day_data(today)
  end

  def tomorrow
    tomorrow = Date.today + 1
    tomorrow = tomorrow.strftime('%m-%d-%Y')
    render_day_data(tomorrow)
  end

  private

  def save_response(response)
    File.open("data/temp.json","w") do |f|
      f.write(response)
    end
    @raw_response = set_raw_response
  end

  def set_raw_response
    if File.zero?("data/temp.json")
      puts "Whoops! Run 'forecast.send_request' once before running this method."
      exit
    else
      JSON.parse(File.read("data/temp.json"))
    end
  end

  def parse_date(date)
    Date.parse(date).strftime('%m-%d-%Y')
  end

  def convert_to_fahrenheit(k)
    f = (1.8 * (k - 273)) + 32
    f.round(1)
  end

  def render_day_data(day)
    temps = get_temps_from_response(day)

    puts "Weather for #{@raw_response['city']['name']} #{day}:"
    puts "High: #{high_temp(temps)}F"
    puts "Low: #{low_temp(temps)}F"
    puts "Average Humidity: #{avg_humidity(temps)}%"
    puts "Description: #{description(temps)}"
  end

  def get_temps_from_response(day)
    @raw_response['list'].select do |date|
      parse_date(date['dt_txt']) == day
    end
  end

  def high_temp(temps)
    max_temp = temps.map {|temp| temp['main']['temp_max'] }.max
    convert_to_fahrenheit(max_temp)
  end

  def low_temp(temps)
    min_temp = temps.map {|temp| temp['main']['temp_min'] }.min
    convert_to_fahrenheit(min_temp)
  end

  def avg_humidity(temps)
    temps.map {|temp| temp['main']['humidity'] }.reduce(&:+)/temps.length
  end

  def description(temps)
    temps.map {|temp| temp['weather'][0]['description'] }.uniq.join(', ')
  end

  def render_temps_data(type:, key:)
    puts "#{type} Temperatures in #{@raw_response['city']['name']}"
    dates = {}
    @raw_response['list'].each do |date|
      dates[parse_date(date['dt_txt'])] ||= []
      temp = date['main'][key]
      dates[parse_date(date['dt_txt'])] << convert_to_fahrenheit(temp)
    end

    dates.each do |date, temps|
      puts "","#{type}s for #{date}"
      temps.each do |temp|
        puts "#{temp}F"
      end
    end
  end
end


