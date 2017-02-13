# open weather map

# ruby API calls

require 'httparty'
require 'json'
require 'pry-byebug'
require 'pp'

class WeatherForecast

  API_KEY = ENV["API_KEY"}
  VALID_FORMATS = [:json]
  VALID_DAYS = [1..16]

  def initialize(city_id = 4347778, days = 5)
    validate_days!(days)
    @days = days
    @location = city_id
  end

  def validate_days!(days)
    unless VALID_DAYS.include?(days)
      raise "Invalid number of days"
    end
  end

  private

  def send_request
    response = HTTParty.get('https://api.openweathermap.org/data/2.5/forecast/daily?id=(city_id)&cnt=(days)&APPID = API_KEY')
    trim_response(response)
  end

  def trim_response(response)
    response_body = JSON.parse(response ...)

    results = response_body["    ?     "][0..-1]
    results.map do |item|
      {
        :list.temp.max     or        :hi_temps => [list.temp.max]

        # where does DAY come from (temps each day)?

        # ditto with ":lo_temps", ":today", ":tomorrow"

        # how is data output?
      }

    end

    # For Part II GitHub API Warmup:

    github.rb

    require ?   # what name?

    # create new GitHub object with optional parameter
    # oauth_token: "THE_TOKEN_YOU_GOT"

  end

end # class WeatherForecast






