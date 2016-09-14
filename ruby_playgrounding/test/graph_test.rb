require 					'minitest/autorun'
require_relative 	'../data_structures/graph.rb'


class TestLinkedList < Minitest::Test
  
  def setup
    @list = LinkedList.new
  end



  def test_linked_list

  	#---------
  	# Test when empty
  	#---------

    assert_equal true, @list.is_empty?

    assert_raises do @list.get_first; end
    assert_raises do @list.get_last; end
    assert_raises do @list.remove_first; end
    assert_raises do @list.remove_last; end


    #---------
  	# Test when one element
  	#---------

    random_nodes = generate_nodes()
    @list.add_at_start(random_nodes[0])

    assert_equal random_nodes[0].data, @list.get_first.data
    assert_equal @list.get_first, @list.get_last
    assert random_nodes[2].data != @list.get_first.data

  end




private

	def generate_nodes
		random_strings = (0..100).map { |i| (0...8).map { (65 + rand(26)).chr }.join }
		random_nodes = random_strings.map {|string| ListNode.new(string)}
		return random_nodes
	end

end