class Render
  
  def self.display_highs(days)
    puts "Displaying high temperatures."
    days.each do |day|
      puts "#{day.day}: #{day.high_temp}"
    end
  end

  def self.display_lows(days)
    puts "Displaying low temperatures."
    days.each do |day|
      puts "#{day.day}: #{day.low_temp}"
    end
  end

  def self.display_day(day)
    puts "Displaying data for #{day.day}"
    puts "Low temperature is #{day.low_temp}"
    puts "High temperature is #{day.high_temp}"
  end

end