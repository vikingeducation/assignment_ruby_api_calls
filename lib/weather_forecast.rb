require 'httparty'

class WeatherForecast
  include HTTParty

  base_uri 'http://api.openweathermap.org/data/2.5'
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def initialize(city: 'Denver', day_count: 3)
    @options = { query: { q: city, units: 'imperial', appid: API_KEY } }
    @days = day_count
    @json = forecast
  end

  def city_info
    city_obj = @json['city']

    {
      id: city_obj['id'],
      name: city_obj['name'],
      country: city_obj['country']
    }
  end

  def hi_temps
    map_temps 'max'
  end

  def lo_temps
    map_temps 'min'
  end

  def today
    trim_to_day(1)
  end

  def tomorrow
    trim_to_day(2)
  end

  private

  def forecast
    response = self.class.get('/forecast/daily', @options)
    JSON.parse(response.body)
  end

  def map_temps(attribute)
    @json['list'][0...@days].map do |day|
      day['temp'][attribute].round
    end
  end

  def trim_to_day(day_num)
    day = @json['list'][day_num - 1]
    weather = day['weather'].first

    {
      date: Time.at(day['dt']),
      day: day['temp']['day'].round,
      low: day['temp']['min'].round,
      high: day['temp']['max'].round,
      weather: [
        {
          main: weather['main'],
          description: weather['description']
        }
      ]
    }
  end
end
