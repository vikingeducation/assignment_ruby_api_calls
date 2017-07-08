require_relative 'weather_forecast'
w = WeatherForecast.new

puts "Today's high:"
w.hi_temps
puts "Today's low:"
w.lo_temps

s = '{"city":{"id":0,"name":"Washington","coord":{"lon":-76.9901,"lat":38.9024},"country":"US","population":0},"cod":"200","message":10.2783552,"cnt":7,"list":[{"dt":1499533200,"temp":{"day":303.82,"min":295.71,"max":304.04,"night":295.71,"eve":301.25,"morn":300.08},"pressure":1016.82,"humidity":67,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":3.81,"deg":276,"clouds":36,"rain":0.3},{"dt":1499619600,"temp":{"day":300.82,"min":292.57,"max":301.71,"night":292.57,"eve":299.49,"morn":295.01},"pressure":1024.85,"humidity":58,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"01d"}],"speed":1.67,"deg":298,"clouds":0},{"dt":1499706000,"temp":{"day":303.86,"min":296.43,"max":304.31,"night":297.9,"eve":302.6,"morn":296.43},"pressure":1022.55,"humidity":52,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"02d"}],"speed":3.31,"deg":217,"clouds":8},{"dt":1499792400,"temp":{"day":304.87,"min":296.71,"max":304.87,"night":296.71,"eve":300.66,"morn":297.35},"pressure":1018.96,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":2.38,"deg":225,"clouds":17,"rain":3.67},{"dt":1499878800,"temp":{"day":302.85,"min":296.11,"max":302.85,"night":296.11,"eve":297.54,"morn":297.6},"pressure":1017.29,"humidity":0,"weather":[{"id":502,"main":"Rain","description":"heavy intensity rain","icon":"10d"}],"speed":3.31,"deg":168,"clouds":92,"rain":43.2},{"dt":1499965200,"temp":{"day":298.11,"min":295.21,"max":298.11,"night":295.21,"eve":297.24,"morn":296.42},"pressure":1017.53,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":5.66,"deg":53,"clouds":38,"rain":7.63},{"dt":1500051600,"temp":{"day":299.25,"min":294.97,"max":299.25,"night":294.97,"eve":298.52,"morn":295.36},"pressure":1017.44,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":3.3,"deg":30,"clouds":40,"rain":7.23}]}'

my_hash = JSON.parse(s)
daily_forecasts = my_hash["list"]

def print_temps(hash)
  hash.each do |day|
    str_date = day["dt"].to_s
    date = Date.strptime(str_date,'%s')
    puts date.strftime('%a %b %d %Y')
  end
end

#print_day(daily_forecasts)
print_temps(daily_forecasts)
