class Day

  attr_reader :day, :low_temp, :high_temp

  def initialize(day_json) 
    @day = Time.at( day_json["dt"] ) # conversion from UNIX to date
    @low_temp = day_json["temp"]["min"]
    @high_temp = day_json["temp"]["max"]
  end

end

# Example JSON

# {"dt"=>1479236400,
#   "temp"=>
#    {"day"=>70.23,
#     "min"=>51.94,
#     "max"=>75.61,
#     "night"=>51.94,
#     "eve"=>68.02,
#     "morn"=>61.7},
#   "pressure"=>1013.09,
#   "humidity"=>85,
#   "weather"=>
#    [{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}],
#   "speed"=>3.65,
#   "deg"=>199,
#   "clouds"=>76,
#   "rain"=>0.39}