require 'rspec'
require 'weather_forecast'

describe WeatherForecast do
  w = WeatherForecast.new
  s = '{"city":{"id":0,"name":"Washington","coord":{"lon":-76.9901,"lat":38.9024},"country":"US","population":0},"cod":"200","message":10.2783552,"cnt":7,"list":[{"dt":1499533200,"temp":{"day":303.82,"min":295.71,"max":304.04,"night":295.71,"eve":301.25,"morn":300.08},"pressure":1016.82,"humidity":67,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":3.81,"deg":276,"clouds":36,"rain":0.3},{"dt":1499619600,"temp":{"day":300.82,"min":292.57,"max":301.71,"night":292.57,"eve":299.49,"morn":295.01},"pressure":1024.85,"humidity":58,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"01d"}],"speed":1.67,"deg":298,"clouds":0},{"dt":1499706000,"temp":{"day":303.86,"min":296.43,"max":304.31,"night":297.9,"eve":302.6,"morn":296.43},"pressure":1022.55,"humidity":52,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"02d"}],"speed":3.31,"deg":217,"clouds":8},{"dt":1499792400,"temp":{"day":304.87,"min":296.71,"max":304.87,"night":296.71,"eve":300.66,"morn":297.35},"pressure":1018.96,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":2.38,"deg":225,"clouds":17,"rain":3.67},{"dt":1499878800,"temp":{"day":302.85,"min":296.11,"max":302.85,"night":296.11,"eve":297.54,"morn":297.6},"pressure":1017.29,"humidity":0,"weather":[{"id":502,"main":"Rain","description":"heavy intensity rain","icon":"10d"}],"speed":3.31,"deg":168,"clouds":92,"rain":43.2},{"dt":1499965200,"temp":{"day":298.11,"min":295.21,"max":298.11,"night":295.21,"eve":297.24,"morn":296.42},"pressure":1017.53,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":5.66,"deg":53,"clouds":38,"rain":7.63},{"dt":1500051600,"temp":{"day":299.25,"min":294.97,"max":299.25,"night":294.97,"eve":298.52,"morn":295.36},"pressure":1017.44,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":3.3,"deg":30,"clouds":40,"rain":7.23}]}'
  describe '#initialize' do
    it 'creates a forecast' do
      expect(w).to be_a(WeatherForecast)
    end

    it 'sets a default as france and 5 days if nothing specified' do
      expect(w.location).to eq("france")
      expect(w.num_days).to eq(5)
    end

    it 'allows passing a values upon initialization ' do
      w_germany_3 = WeatherForecast.new("germany", 3)
      expect(w_germany_3.location).to eq("germany")
      expect(w_germany_3.num_days).to eq(3)
    end
  end

  describe '#send_request' do
    it 'sends a request to the server'
  end

  describe '#parse_response' do
    it 'converts the raw response to a hash' do
      w.parse_response(s)
      expect(w.response_hash).to be_a(Hash)
    end
  end

  describe 'convert_temp' do
    it 'converts a degree value in kelvin to celcius' do
      expect(w.convert_temp(0)).to eq(-273.15)
    end
  end

  describe 'convert_date' do
    it 'converts the date into a string' do

    end
  end

  describe 'hi_temps' do
    it 'accesses the send_request method' do
      allow(w).to receive(:send_request).and_return(s)
      expect(w).to receive(:send_request).and_return(s)
    end
    it 'accesses the convert_temp method' do
      allow(w).to receive(:convert_temp).and_return()
      w.hi_temps
    end
  end

end
