require 'weather_forecast_api'

describe WeatherForecast do

  let(:forecast) { WeatherForecast.new(zip: 90210, days: 5) }

  describe '#initialize' do
    it("is a WeatherForecast") { expect(forecast).to be_a(WeatherForecast) }

    f = WeatherForecast.new
    it 'has default values for zip and days count' do
      expect { WeatherForecast.new }.not_to raise_error
    end
  end

  describe '#send_request' do
    xit 'mocks out a call to the API' do
    end
  end

  # describe '#high_temps' do
  # end

  # describe '#low_temps' do
  # end

  # describe '#today' do
  # end

  # describe '#tomorrow' do
  # end

end
