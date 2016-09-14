require 'rspec'
require_relative 'postfix_expression'

describe CountdownProblem::PostfixExpression do

	let(:numbers) { [1,2,3] }
	let(:operators) { ["+", "-"] }
	let(:result) { CountdownProblem::PostfixExpression.new(numbers, operators).result }
	
	context 'with operators' do
		it 'result equals postfix calculation' do
			expect(result).to eq(0)
		end
	end

	context 'no operators' do
		let(:numbers) { [1] }
		let(:operators) { [] }

		it 'returns the first number' do
			expect(result).to eq(1)
		end
	end

end
