#----------------------
# Description
#----------------------

#http://www.careercup.com/page?pid=facebook-interview-questions&job=software-engineer-interview-questions&topic=string-manipulation-interview-questions


#----------------------
# Solution
#----------------------

def is_alphanumeric?(char)
	!!char.match(/^[[:alnum:]]$/)
end


def new_palindrome?(str)
	raise "Nil argument." if str.nil?

	return if str.length < 2
	
	left_index 	= 0
	right_index = str.length - 1

	until (right_index - left_index) <= 0
		if !is_alphanumeric?(str[left_index])
			left_index += 1 
			next
		end

		if !is_alphanumeric?(str[right_index]) 
			right_index -= 1
			next
		end

		if str[left_index].downcase != str[right_index].downcase
			return false
		end

		left_index 	+= 1
		right_index -= 1 
	end

	true
end


#----------------------
# test
#----------------------

#require 'minitest/autorun'

# puts is_alphanumeric?('A')
# puts is_alphanumeric?('1')
# puts is_alphanumeric?(' ')
# puts is_alphanumeric?(',')
# puts is_alphanumeric?('!')

test_case_1 = 'A man, a plan, a canal, Panama!'

puts new_palindrome?(test_case_1)

#test_case_2 = 'سيداتي وسادتي'
#puts test_case_2[0]
#puts test_case_2[test_case_2.length-1]