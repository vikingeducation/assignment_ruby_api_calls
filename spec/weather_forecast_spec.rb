require 'weather_forecast'

describe WeatherForecast do

  it "is an instance of WeatherForecast" do
    expect(subject).to be_a(WeatherForecast)
  end

  describe "#initialize" do
    it "raises an error when the the argument for days is above 16" do
      expect{WeatherForecast.new("Brisbane", "AU", "17")}.to raise_error
    end

    it "does not raise an error when the argument for days is '16'" do
      expect{WeatherForecast.new("Brisbane", "AU", "16")}.to_not raise_error
    end

    it "raises an error when the the argument for days is less than '1'" do
      expect{WeatherForecast.new("Brisbane", "AU", "0")}.to raise_error
    end

    it "does not raise an error when the argument for days is '1'" do
      expect{WeatherForecast.new("Brisbane", "AU", "1")}.to_not raise_error
    end
  end

end