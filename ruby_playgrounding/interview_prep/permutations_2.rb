# Problem: ruby string permutations

# "Brute Force" solution
def get_permutations(str)
  str_array = str.split('')
  get_permutations_h(str_array)
end

def get_permutations_h(arr)
  raise "error" if arr.empty?
  
  return [arr] if arr.length <= 1

  result = []

  sub_problem = arr[1...arr.length]
  sub_results = get_permutations_h(sub_problem)
  
  sub_results.each do |sub_result|
  	(0..sub_result.length).each do |j|
  		result << sub_result.dup.insert(j, arr[0])
  	end
  end
  
  result 
end

results = get_permutations("hello").each do |result|
	puts result.inspect
end

puts results.length
puts (1.."hello".length).inject(:*) || 1
