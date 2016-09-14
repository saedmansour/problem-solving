# ------------------------
# GraphInterface 
# ------------------------

module GraphInterface

	def add_edge(vertex_a, vertex_b)
		raise NotImplementedError
	end

	def has_edge(vertex_a, vertex_b)
		raise NotImplementedError
	end

	def remove_edge(vertex_a, vertex_b)
	end

	def get_edges
	end

	def get_vertices
	end

	def get_edges_size
	end

	def get_vertices_size
	end

end 

# ------------------------
# GraphAdjacencyList 
# ------------------------

class GraphAdjacencyList
	include GraphInterface

	def initialize 
		@vertices = Hash.new
	end

	def add_edge(vertex_a, vertex_b)
		if @vertices[vertex_a.name].nil?
			@vertices[vertex_a.name] = {vertex_b.name => vertex_b}
		else
			@vertices[vertex_a.name][vertex_b.name] = vertex_b
		end
	end

	def has_edge(vertex_a, vertex_b)
		@vertices[vertex_a.name].includes?(vertex_b.name)
	end
end


# ------------------------
# Node
# ------------------------

class Node

  attr_reader 	:name
  attr_accessor :successors

  def initialize(name)
    @name = name
    @successors = []
    @visited = false
  end

  def add_edge(successor)
    @successors << successor
  end

  def visited?
  	@visited
  end

  def to_s
    "#{@name} -> [#{@successors.map(&:name).join(' ')}]"
  end

end

# ------------------------
# Graph
# ------------------------


class Graph

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.name] = node
  end

  def add_edge(predecessor_name, successor_name)
    @nodes[predecessor_name].add_edge(@nodes[successor_name])
  end

  def [](name)
    @nodes[name]
  end

  # ---------------------------
  # Graph/Algorithms/Traversal
  # ---------------------------

  def BFS!(root, &visit)
  	to_explore = Queue.new(root)

  	until to_explore.empty?
  		current_node = to_explore.dequeue
  		
  		visit.call(current_node)
  		current_node.visited = true
  		
  		to_explore << current_node.successors.select { |successor| !successor.visited? }
  	end
  end


  def DFS!(root, &visit)
  	to_explore = Stack.new(root)

  	until to_explore.empty?
  		current_node = to_explore.pop
  		
  		visit.call(current_node)
  		current_node.visited = true
  		
  		to_explore << current_node.successors.select { |successor| !successor.visited? }
  	end
  end

end


# ------------------------
# ListNode
# ------------------------

class ListNode

	attr_accessor :data, :next_element, :prev_element

	def initialize(data)
		@data, @next_element, @prev_element = data, nil, nil
	end

end

# ------------------------
# LinkedList : double linked list
# ------------------------

class LinkedList

	def initialize
		# dummy: assumption nil data is dummy. nil data isn't allowed otherwise
		# @first_node remains a dummy.
		@first_node = ListNode.new(nil)
		@last_node = @first_node
	end

	def add_at_start(node)
		raise ArgumentError if node.nil?
		
		if is_empty?
			@last_node = node
		else
			@first_node.next_element.prev_element = node
		end

		node.next_element = @first_node.next_element
		node.prev_element = @first_node
		
		
		@first_node.next_element = node

		node
	end

	def add_at_end(node)
		raise NotImplementedError
	end

	def get_first
		raise "ERROR: list is empty." if is_empty?
		@first_node.next_element
	end

	def get_last
		raise "ERROR: list is empty." if is_empty?
		@last_node
	end

	def remove_first
		raise "ERROR: list is empty." if is_empty 

		#change first node
		@first_node.next_element = @first_node.next_element.next_element

		#fix prev_element of new first node
		if !first_node.next_element.nil?
			@first_node.next_element.prev_element = @first_node 
		else
			@last_node = @first_node
		end
	end

	def remove_last
		raise "Error: Empty list." if is_empty?
		
		if get_first == get_last
			remove_first()
		else
			@last_node = @last_node.prev_element
			@last_node.next_element = nil
		end
	end

	def is_empty?
		@first_node.next_element.nil?
	end

private

	def is_size_one?
		@last_node == get_first
	end
end