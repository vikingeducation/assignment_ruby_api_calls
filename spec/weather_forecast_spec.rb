require 'httparty'
require 'mock5'
require_relative 'mocks/weather_api_mock'

class WeatherForecast
  include HTTParty

  base_uri 'http://api.openweathermap.org/data/2.5'
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def initialize(city: 'Denver', day_count: 3)
    @options = { query: { q: city, units: 'imperial', appid: API_KEY } }
    @days = day_count
    @json = forecast
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

# http://api.openweathermap.org/data/2.5/forecast/daily?zip=80202&units=imperial&appid=ENV['OPEN_WEATHER_API_KEY']
RSpec.describe WeatherForecast do
  let(:caster) { WeatherForecast.new }

  around do |example|
    Mock5.with_mounted(WeatherApi, &example)
  end

  describe 'forecast' do
   describe '#today and #tomorrow' do
      it 'gives forecast for the day' do
        expect(caster.today).to eq daily_forecast_json(90, 67, 91)
      end

      it 'gives forecast for the next day' do
        expect(caster.tomorrow).to eq daily_forecast_json(83, 58, 87)
      end

      def daily_forecast_json(day, low, high)
        {
          day: day,
          low: low,
          high: high,
          weather: [
            {
              main: 'Clear',
              description: 'sky is clear',
            }
          ]
        }
      end
    end
  end

  describe '#hi_temps' do
    context 'default' do
      it 'returns first 3 high temperatures' do
        expect(caster.hi_temps).to match [91, 87, 85]
      end
    end

    context '5-day forecast' do
      it 'returns the first 5 high temps' do
        caster = WeatherForecast.new(day_count: 5)
        expect(caster.hi_temps).to match [91, 87, 85, 84, 83]
      end
    end
  end

  describe '#low_temps' do
    context 'default' do
      it 'returns first 3 low temperatures' do
        expect(caster.lo_temps).to match [67, 58, 58]
      end
    end

    context '5-day forecast' do
      it 'returns the first 5 low temps' do
        caster = WeatherForecast.new(day_count: 5)
        expect(caster.lo_temps).to match [67, 58, 58, 53, 57]
      end
    end
  end
end