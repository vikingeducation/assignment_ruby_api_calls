require 'rspec'
require 'weather_forecast'
require 'sample_response'

describe WeatherForecast do
  w = WeatherForecast.new

  describe '#initialize' do
    it 'creates a forecast' do
      expect(w).to be_a(Board)
    end

    it 'sets a default as france and 5 days if nothing specified' do
      expect(w.location).to equal("france")
      expect(w.num_days).to equal(5)
    end

    it 'allows passing a values upon initialization ' do
      w_germany_3 = WeatherForecast.new("germany", 3)
      expect(w_germany_3.location).to equal("germany")
      expect(w_germany_3.num_days).to equal(3)
    end
  end
end
