def find_pairs(arr) #[2,4,5,6,8]
  index = 0
  pairs = []

  return false if arr[0] + arr [-1] < 10

  if arr[0] + arr[-1] == 10
    [arr[0], arr[-1]]
  else
    (arr.length - 1).downto(0) do |j|
      (arr.length - 1).downto(j+1) do |i|
        if arr[j] + arr[i] == 10
          pairs << [arr[j], arr[i]]
        elsif arr[j] + arr [i] < 10
          break
        end
      end
    end
end
