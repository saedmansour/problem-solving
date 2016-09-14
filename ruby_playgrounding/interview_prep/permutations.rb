# Problem: ruby string permutations

"Brute Force" solution
def get_permutations(str)
  str_array = str.split('')
  permutations = []
  get_permutations_h(str_array, permutations)
end

def get_permutations_h(arr, permutations)
  raise "nil" if arr.nil?
  return [arr] if arr.length <= 1

  result = []

  arr.each_with_index do |char, index|
    sub_problem = arr[0...index] + arr[index+1...arr.length]
    sub_results = get_permutations_h(sub_problem, permutations)
    sub_results = sub_results.map {|carr| carr.unshift(char)}
    result << sub_results.flatten
  end
  
  result 
end

puts get_permutations("helloworld")
