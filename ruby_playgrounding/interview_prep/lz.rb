

# algo steps
# Initialize the dictionary to contain all blocks of length one (D={a,b}).
# Search for the longest block W which has appeared in the dictionary.
# Encode W by its index in the dictionary.
# Add W followed by the first symbol of the next block to the dictionary.
# Go to Step 2.




#------------------
#-- Constants
COMPRESSION_LENGTH_MIN = 100
DICT_SIZE = 256


def LZ_decompress(uncompressed)
	if uncompressed.nil?
		puts "Nil not allowed."; return
	end

	if uncompressed.empty?
		puts "There's no to compress."; return
	end

	if uncompressed.length < COMPRESSION_LENGTH_MIN
		puts "Too short, not worthy of compression."
	end

	# algo's "meat"

	dict = Hash.new
	DICT_SIZE.times do |char_index|
		dict[char_index] = char_index.chr
	end 

	
	#current sequence, the lengthiest one we have dict to encode
	current_sequence = ""
	
	#final result [seq_index1, seq_index2, ...]
	result = []
	
	for char in uncompressed.split('')
		new_sequence = current_sequence + char
    if dict.has_key?(new_sequence)
    	#until you get the longest seq that appeared
      current_sequence = new_sequence
    else
    	#now we have a new sequence, we output old sequence index
    	result << dict[current_sequence]
    	#and store new sequence
    	dict[new_sequence] = dict.size
      current_sequence = char 
    end    
	end

	#take care of last sequence
	result << dict[current_sequence] unless current_sequence.empty?
	result
end



#------------------
#-- Simple test

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.saedmansour.com/cv')).text

result = LZ_decompress(doc)

puts result

	
require 'benchmark'

puts Benchmark.measure { LZ_decompress(doc) }

