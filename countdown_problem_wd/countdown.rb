# Ruby version: 2.3

require_relative 'postfix_expression'

module CountdownProblem

  class DfsSolver

    def self.solve(nums, target_num)
      stack = nums.map { |n| PostfixExpression.new([n], []) }
      closest = calc_closest(stack, target_num)

      target_num_in_nums = stack.find {|e| e.result == target_num }
      return target_num_in_nums unless target_num_in_nums.nil?

      until stack.empty? do
        current = stack.pop
        next_expressions = get_next_expressions(current, nums)

        exp_equal_target = next_expressions.find {|exp| exp.result == target_num}
        return exp_equal_target unless exp_equal_target.nil?

        closest = calc_closest(next_expressions + [closest], target_num)
        next_expressions.each {|exp| stack.push(exp) }
      end

      closest
    end

    private

    def self.calc_closest(expressions, target)
      expressions.min{ |n1,n2| (target - n1.result).abs <=> (target - n2.result).abs }
    end

    def self.get_next_expressions(exp, nums)
      result = []
      remaining_nums = nums - exp.nums
      remaining_nums.each do |num|
        new_nums = exp.nums + [num]
        result << PostfixExpression.new(new_nums, exp.operators + ["+"])
        result << PostfixExpression.new(new_nums, exp.operators + ["-"])
        result << PostfixExpression.new(new_nums, exp.operators + ["*"])
        result << PostfixExpression.new(new_nums, exp.operators + ["/"]) unless num == 0
      end
      result
    end

  end

end