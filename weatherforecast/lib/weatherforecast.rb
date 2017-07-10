# require "weatherforecast/version"
# houses API KEY
require_relative 'weatherforecast/api'

require 'httparty'
require 'typhoeus'
require 'json'
require 'pry-byebug'

class WeatherForecast

  include HTTParty

  BASE_URI = "http://api.openweathermap.org/"

  def initialize( location = 5666639, num_days = 5, units = "imperial", lat = 46.87, lon = -113.99, api_key = API_KEY )
    @location = location
    @num_days = num_days
    @units_of_measure = units
    @lat = lat
    @lon = lon
    @date = Time.now.strftime("%Y-%m")
    @api_key = api_key
  end


  def hi_temps
    response = send_request( "data/2.5/forecast", { "id" => @location,"units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    hi_temp = response_body["list"][0]["main"]["temp_max"]
    puts "High Temperature Forecast:"
    puts "Today: #{hi_temp}"
    if @num_days > 1
      response_body["list"].select {|hash| hash["dt_txt"].include?("18:00:00")}.take(@num_days).each do |hash|
          date = hash["dt_txt"].split(" ")[0].split("-")
          puts "#{date[1]}/#{date[2]}/#{date[0]}: #{hash["main"]["temp_max"]}"
      end
    end
  end


  def lo_temps
    response = send_request( "data/2.5/forecast", { "id" => @location, "units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    lo_temp = response_body["list"][0]["main"]["temp_min"]
    puts "Low Temperature Forecast:"
    puts "Today: #{lo_temp}"
    if @num_days > 1
      response_body["list"].select {|hash| hash["dt_txt"].include?("18:00:00")}.take(@num_days).each do |hash|
          date = hash["dt_txt"].split(" ")[0].split("-")
          puts "#{date[1]}/#{date[2]}/#{date[0]}: #{hash["main"]["temp_min"]}"
      end
    end
  end


  def today
    response = send_request("data/2.5/forecast", { "id" => @location, "units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    puts "Today's Forecast:"
    print_weather(response_body, 0)
  end


  def tomorrow
    response = send_request( "data/2.5/forecast", { "id" => @location, "units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    puts "Tomorrow's Forecast:"
    print_weather(response_body, 1)
  end


  def uv_index
    response = send_request("uvi/forecast", {"lat" => @lat, "lon" =>  @lon, "cnt" => @num_days})
    response_body = JSON.parse(response.body)
    puts "UV Index Forecast:"
    response_body.each do |hash|
      date = hash["date_iso"].split("T")[0].split("-")
      puts "#{date[1]}/#{date[2]}/#{date[0]}: #{hash["value"]}"
    end
  end


  def pressure
    response = send_request( "data/2.5/forecast", { "id" => @location, "units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    puts "Pressure:"
    puts "Today: #{response_body["list"][0]["main"]["pressure"]}"
    if @num_days > 1
      if @num_days > 1
        response_body["list"].select {|hash| hash["dt_txt"].include?("18:00:00")}.take(@num_days).each do |hash|
            date = hash["dt_txt"].split(" ")[0].split("-")
            puts "#{date[1]}/#{date[2]}/#{date[0]}: #{hash["main"]["pressure"]}"
        end
      end
    end
  end


  def humidity
    response = send_request( "data/2.5/forecast", { "id" => @location, "units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    puts "Humidity:"
    puts "Today: #{response_body["list"][0]["main"]["humidity"]}"
    if @num_days > 1
      response_body["list"].select {|hash| hash["dt_txt"].include?("18:00:00")}.take(@num_days).each do |hash|
          date = hash["dt_txt"].split(" ")[0].split("-")
          puts "#{date[1]}/#{date[2]}/#{date[0]}: #{hash["main"]["humidity"]}"
      end
    end
  end


  def feels_like
    response = send_request( "data/2.5/forecast", { "id" => @location, "units" => @units_of_measure.to_s } )
    response_body = JSON.parse(response.body)
    puts "Today:"
    puts "  Looks Like: #{response_body["list"][0]["weather"][0]["description"]}"
    puts "  Wind Speed: #{response_body["list"][0]["wind"]["speed"]}"
    puts "  Rain: #{response_body["list"][0]["rain"]}" unless response_body["list"][0]["rain"].nil?
    if @num_days > 1
      response_body["list"].select {|hash| hash["dt_txt"].include?("18:00:00")}.take(@num_days).each do |hash|
          date = hash["dt_txt"].split(" ")[0].split("-")
          puts "#{date[1]}/#{date[2]}/#{date[0]}:"
          puts "  Looks Like: #{hash["weather"][0]["description"]}"
          puts "  Wind Speed: #{hash["wind"]["speed"]}"
          puts "  Rain: #{hash["rain"]}" unless hash["rain"].nil?
      end
    end
  end


private


  def send_request(path, options={})
    uri = (BASE_URI + path + "?").to_s
    params = { "appid" => @api_key }
    params.merge!(options) unless options.empty?
    request = Typhoeus::Request.new( uri,
                                     method: :get,
                                     params: params )
    request.run
    request.response
  end


  def print_weather(response_body, i)
    puts "Today's Weather:"
    puts "Current Temp: #{response_body["list"][i]["main"]["temp"]}"
    puts "Hi: #{response_body["list"][i]["main"]["temp_max"]}"
    puts "lo: #{response_body["list"][i]["main"]["temp_min"]}"
  end


end
