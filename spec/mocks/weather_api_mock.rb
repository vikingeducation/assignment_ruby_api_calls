weather_json_response = File.join(File.dirname(__FILE__), '../assets/denver_daily.json')
forecast_json = File.read weather_json_response

WeatherApi = Mock5.mock('http://api.openweathermap.org') do
  get '/data/2.5/forecast/daily' do
    forecast_json
  end
end