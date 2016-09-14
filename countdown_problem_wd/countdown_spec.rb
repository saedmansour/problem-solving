require 'rspec'
require_relative 'countdown'

describe CountdownProblem::DfsSolver do
	context 'has solution that equals target' do
		let(:numbers) { [2,1,3,4,5,6] }
		let(:target) { 17 }
		let(:result) { CountdownProblem::DfsSolver.solve(numbers,target).result.to_i } 
		
		it { expect(result).to equal(target) }

		context 'has zero in numbers' do
			let(:numbers) { [1,2,3,4,5,0] }

			it 'handles division by zero' do 
				expect{result}.not_to raise_error 
			end
		end

		context 'numbers has target number' do
			let(:numbers) { [3] }
			let(:target) { 3 }

			it { expect(result).to equal(target) }
		end	

		context 'has no equal solution' do
			let(:numbers) { [1,2] }
			let(:target) { 4 }

			it 'returns closest solution' do
				expect(result).to equal(3)
			end
		end	
	end
end
