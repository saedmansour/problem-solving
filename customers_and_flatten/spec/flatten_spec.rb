require 'spec_helper'
require 'benchmark'
require 'flatten'
 
describe "flatten array" do

  context "empty arrays" do
  	it "should return empty array" do
    	expect([].flatten).to eql([])
    	expect([[]].flatten).to eql([])
    	expect([[[[]]]].flatten).to eql([])
    	expect([[[[]]], [], [], [], [[]]].flatten).to eql([])
  	end
  end

  context "recursive array" do
  	it "should raise argument error" do
  		arr = []
  		arr << arr
  		expect{arr.flatten}.to raise_error(ArgumentError)
  	end
  end

  context "flat arrays" do
  	it "should return same array" do
  		arr_ex1 = [1, 2, 3, 4, 5, 6, 7]
  		arr_ex2 = [10]

  		expect(arr_ex1.flatten).to eql(arr_ex1)
  		expect(arr_ex2.flatten).to eql(arr_ex2)
  	end
  end

  context "non flat arrays" do
  	it "should flatten them" do
  		arr_ex1 = [1, [[[2]]], [3, [4, [5]]], [6], [7]]
  		expect(arr_ex1.flatten).to eql([1, 2, 3, 4, 5, 6, 7])
  		
  		arr_ex2 = [0, [0], [[0], [[[]]]], [[0], [0]]]
  		expect(arr_ex2.flatten).to eql([0, 0, 0, 0, 0])
  	end
  end

  context "recursive flatten on really deep array" do
    it 'should get stack error' do

    	arr = []
    	1_000_000.times do
    		arr = [arr] 
    	end

      expect{arr.flatten_recursive}.to raise_error(SystemStackError)
    end
  end

  context "DFS implementation on super deep data" do
    it 'should work in O(N) linear performance - this is not a great test though' do

    	arr = []
    	1_000_000.times do
    		arr = [arr] 
    	end

			arr2 = []
    	10_000.times do
    		arr2 = [arr2] 
    	end

    	time_arr1 = Benchmark.realtime{arr.flatten_dfs}
    	time_arr2 = Benchmark.realtime{arr2.flatten_dfs}

    	C = 5
      expect(time_arr1/time_arr2).to be < (1_000_000/10_000) * C
    end
  end

end