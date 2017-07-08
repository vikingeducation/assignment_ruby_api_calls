#sample_response
require 'JSON'

response = '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"base":"stations","main":{"temp":289.95,"pressure":1017,"humidity":72,"temp_min":287.15,"temp_max":292.15},"visibility":10000,"wind":{"speed":5.7,"deg":100},"clouds":{"all":0},"dt":1499305800,"sys":{"type":1,"id":5091,"message":0.0049,"country":"GB","sunrise":1499313104,"sunset":1499372306},"id":2643743,"name":"London","cod":200}'


my_hash = JSON.parse(response)

puts my_hash["coord"]
