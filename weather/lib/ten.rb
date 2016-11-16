a = [2,4,5,6,8]

return_arr = []

a.each do |n|
  if a(n..-1).include?(10-n)
    return_arr << [n, (10-n)]
  end
  return_arr
end


