require 'rubygems'
require 'httparty'
require 'awesome_print'
class Weather
    attr_accessor :place, :response, :days
   include HTTParty
   API_KEY = ENV['OWKEY']
   #base_uri 'api.openweathermap.org/data/2.5/forecast'
   
   def initialize(place = "Tempe", days = 7)
       @place = place.strip
       raise 'days number exceed' if days > 16 || days < 1
       @days = days.to_s
       respond_weather
   end
   
   def respond_weather
       #print "api.openweathermap.org/data/2.5/forecast/daily?q=#{@place},us&cnt=#{@days}&APPID=#{API_KEY}"
       @response = self.class.get("http://api.openweathermap.org/data/2.5/forecast/daily?q=#{@place},us&cnt=#{@days}&APPID=#{API_KEY}")
       #ap @response
   end
   
   def hitemp
       puts "the #{@days} days highest temperature report:"
       0.upto(@days.to_i - 1) do |index|
           print @response["list"][index]["temp"]["max"]
           print "  day" + (index+1).to_s 
           puts "  "
       end
       puts ""
   end
   
   def lowtemp
       puts "the #{@days} days lowest temperature report:"
       0.upto(@days.to_i - 1) do |index|
           print @response["list"][index]["temp"]["min"]
           print "  day" + (index+1).to_s 
           puts "  "
       end
       puts ""
   end
   
   def today
       getday(1)
   end
   
   def tomorrow
       getday(2)
   end
   
   def getday(num)
      ap  @response["list"][num-1]
   end
   
   def peopletalk(day)
      num = day - 1 
      print "what you want to know is "
      print "day #" + "#{day}. "
      puts "the Temperature that day is "
      print "average: "
      puts @response["list"][num-1]["temp"]["day"]
      print "highest: "
      puts @response["list"][num-1]["temp"]["max"]
      print "lowest: "
      puts @response["list"][num-1]["temp"]["min"]
   end
   
    
end

w = Weather.new
w.peopletalk(3)


