require 'set'


#----------------------
# Solution
#----------------------

class ArrayQueue
  def initialize
    @store = Array.new
  end
  
  def dequeue
    @store.pop
  end
  
  def enqueue(element)
    @store.unshift(element)
    self
  end

  def <<(element)
    enqueue(element)
  end
  
  def size
    @store.size
  end

  def empty?
  	size == 0
  end
end



class Node
	attr_accessor :successors, :is_visited, :data, :depth

	def initialize(data, depth = 0)
		@data = data
		@successors = nil
		@is_visited = false
		@depth = depth
	end
end


def BFS(root, get_next, visit_node)
	visited 		= Set.new
	to_explore 	= ArrayQueue.new << root

	until to_explore.empty?
		current_node = to_explore.dequeue
		puts current_node.inspect
		result = visit_node.call(current_node, visited)
		return result if !result.nil?
		#to_explore << get_next.call(current_node, visited)
		get_next.call(current_node, visited).each {|next_node| to_explore << next_node}
	end

	nil
end


def transform_word(word_from, word_to, alphabet, dict)
	raise "Words can't be nil." if word_from.nil? || word_to.nil?
	raise "Nil Alphabet not allowed." if alphabet.nil? || alphabet.empty?
	raise "Dictionary can't be nil or empty." if dict.nil? || dict.empty?

	word_from, word_to = word_from.downcase, word_to.downcase
	
	return nil if word_from.length != word_to.length
	return 0 	 if word_from == word_to

	root = Node.new(word_from)
	
	get_next = Proc.new do |node, visited_set|
		next_nodes = []
		current_word_from = node.data
		alphabet.each do |alphabet_letter|
			(0...current_word_from.length).each do |i|
				new_word = current_word_from.dup
				new_word[i] = alphabet_letter
				next if new_word == current_word_from
				next if visited_set.include?(new_word)
				visited_set.add(new_word)
				puts "#{new_word}, #{current_word_from}, #{alphabet_letter}, #{i}" if new_word == "cat" 
				next_nodes <<  Node.new(new_word, node.depth + 1) if dict.include?(new_word)
			end
		end
		next_nodes	
	end
	
	visit_node = Proc.new do |node, visited_set|
		visited_set.add(node.data) if !visited_set.include?(node.data)
		node.is_visited = true;
		node.data == word_to ? node.depth : nil
	end
	
	result = BFS(root, get_next, visit_node)
end




#----------------------
# test
#----------------------

alphabet 	= ('a'..'z').to_a
dict 			= Set.new %w( cat dog hat pat rat sat jat mat fat lat cot dot)

puts transform_word("cat", "dog", alphabet, dict)
