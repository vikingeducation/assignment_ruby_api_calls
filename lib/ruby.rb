array = [2,4,5,6,8]



def numbers(arr)
  pairs = {}
  arr.map.with_index do |item, i|
    a = (i+1)*-1
    [item, arr[a]].sort if item + arr[a] == 10
  end.uniq
end

p numbers([2,4,5,6,8])