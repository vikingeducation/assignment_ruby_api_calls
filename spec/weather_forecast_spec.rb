require 'mock5'
require_relative 'mocks/weather_api_mock'
require 'weather_forecast'

RSpec.describe WeatherForecast do
  let(:caster) { WeatherForecast.new }

  around do |example|
    Mock5.with_mounted(WeatherApi, &example)
  end

  describe 'forecast' do
   describe '#today and #tomorrow' do
      it 'gives forecast for the day' do
        expect(caster.today).to eq daily_forecast_json(90, 67, 91, Time.at(1497031200))
      end

      it 'gives forecast for the next day' do
        expect(caster.tomorrow).to eq daily_forecast_json(83, 58, 87, Time.at(1497117600))
      end

      def daily_forecast_json(day, low, high, date)
        {
          date: date,
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

  describe '#lo_temps' do
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

  describe '#city_info' do
    it 'lists the city name' do
      expect(caster.city_info).to include name: 'Denver'
    end

    it 'lists the country' do
      expect(caster.city_info).to include country: 'US'
    end

    it 'lists the city id' do
      expect(caster.city_info).to include id: 5419384
    end
  end
end