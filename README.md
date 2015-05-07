# ruby_api_calls
Simple Ruby API Call Assignment

This is a project by [Nick Schwaderer](https://github.com/schwad);
done in concert with the [Viking Code School](https://www.vikingcodeschool.com).

This application pulls from the power of the OpenWeatherMap API to give the user simple functionality through a few helpful methods.

To get started, open `weatherman.rb` and below the commented out line `#USER INSTRUCTIONS` put together your inputs. There is a commented out example in the code.

Set a new instance of the WeatherForecast class with `my_instance = WeatherForecast.new("mytown,uk,5")`. The first argument you pass into the method determines location, the second is an integer which determines how long into the future you want to forecast.

After that you can apply the following methods to the instance:

`#today` => Gives a brief forecast of today's weather.
`#tomorrow` => Gives a brief forecast of tomorrow's weather.
`#hi_temps` => Lists out the anticipated high temps for the number of days entered.
`#low_temps` => Lists out the anticipated low temps for the number of days entered.