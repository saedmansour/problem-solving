require 'set'

class Array

	#
  # Override Ruby's flatten array
  #
	def flatten
		flatten_dfs
	end
  
  def flatten_recursive
  	flattened_array = []
  	visited_arrays 	= [self.object_id]
  	
  	self.each do |element|
  		if element.kind_of?(Array)
  			if visited_arrays.include?(element.object_id)
  				raise_recursive_error
  			end
  			visited_arrays 	<< element
  			flattened_array += element.flatten_recursive
  		else
  			flattened_array << element
  		end
  	end

  	flattened_array
  end

  #
  # "flatten" non recursive implementation. Algorithm: 
  # 	  Reduction: Array is a Tree. Sub-Arrays are Sub-Trees.
  # 		Non array elements are the leaves. Return the leaves pre-order/DFS.
  #
  def flatten_dfs
  	flattened_array = []

  	to_explore = [self]
  	visited 	 = Set.new 

  	until to_explore.empty? do
  		current_node = to_explore.pop
  		visited << current_node.object_id

  		array_successors = []
  		current_node.each do |element|
  			if element.kind_of?(Array)
  				if visited.include?(element.object_id)
  				 	raise_recursive_error
  				end
  				array_successors << element
  			else
  				flattened_array << element
  			end
  		end
  		# so we can pop the first successor first
  		array_successors.reverse_each {|node| to_explore.push(node)}
  	end

  	flattened_array
  end

private 

	def raise_recursive_error
		raise ArgumentError.new("Error: Argument is a recursive array.")
	end

#/Array
end 
