require 'vcr'
require 'weather_forecast'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/"
  config.hook_into :webmock
end


describe WeatherForecast do

  let(:weather) { WeatherForecast.new }

  describe '#hi_temps' do

    it "returns the correct number of items" do
      VCR.use_cassette("forecast") do
        expect(weather.hi_temps.size).to eq(16)
      end
    end

    it "returns a higher temp than the low for one day" do
      VCR.use_cassette("high") do
        high = weather.hi_temps[0].values[0]
        low = weather.low_temps[0].values[0]
        expect(high).to be >= low
      end
    end

  end


  describe '#low_temps' do

    it "returns the correct number of items" do
      VCR.use_cassette("forecast") do
        expect(weather.low_temps.size).to eq(16)
      end
    end

  end


  describe '#rainy_days' do

    it 'tells you when it is raining, duh' do
      VCR.use_cassette("rainy_days") do
        expect(weather.rainy_days.size).to eq(1)
      end
    end

  end

  describe '#windiest_day' do

    it 'returns windiest day' do
      VCR.use_cassette("windy") do
        expect(weather.windiest_day.wind_speed).to be_a Float
      end
    end

  end



end