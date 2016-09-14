module CountdownProblem
  class PostfixExpression
    attr_accessor :nums, :operators, :result

    def initialize(nums, operators)
      @nums, @operators = nums, operators

      @result = nums.first
      num_index = 1
      @operators.each do |op| 
        case op
          when '+'
            @result += nums[num_index]
          when '-'
            @result -= nums[num_index]
          when '*'
            @result *= nums[num_index]
          when '/'
            @result /= nums[num_index].to_f
        end
        num_index += 1
      end
    end
  end
end