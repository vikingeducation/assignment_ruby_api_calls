# ruby_api_calls
Simple Ruby API Call Assignment

Solution by [Trevor Elwell](http://trevorelwell.me)

#Instructions

Simple, create a new `WeatherForecast` instance doing something like: 

`w = WeatherForecast.new(location, count)`

where `location` is a stringified version of a location (**NOTE:** right now this doesn't work with non-single word locations such as Los Angeles) and `count` is the number of days in the future you'd like to gather data for.

You can then run the following methods:
*`w.hi_temps` to get a printout of the high temps.
*`w.low_temps` to get a printout of the low temps.
*`w.today` to put a synopsis of today's weather.
*`w.tomorrow` to put a synopsis of tomorrow's weather.

That's it for now! Nothing too fancy but I'm just learning how to use HTTParty and API's so this was a pretty good excercise. 