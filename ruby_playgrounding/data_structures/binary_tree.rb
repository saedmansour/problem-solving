class BinaryTreeNode
	# id: in case we need a unique identifier
	# data: comparable type for BST, etc.

	attr_accessor :left_child, :right_child, :parent
	attr_accessor :id 
	attr_accessor :data
	attr_accessor :is_left_child


	def initialize(data, left_child, right_child)
		@data, @left_child, @right_child = data, left_child, right_child
	end

	def remove
		# remove node from parent and all its descendents.
		# node.parent ...
	end 
end


class BinaryTree

	attr_reader :root

	def initialize(root_node)
		@root = root_node
	end

	def find_by_id
		#works if id's are supported
	end

	def remove_by_id
	end

	def traverse_preorder
	end

	def traverse_inorder
	end

	def traverse_postorder
	end
end

