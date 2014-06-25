require 'spec_helper'

describe Dank::Models::Expression do

  describe '#==' do

    context 'when given a Dank::Expression' do

      let(:dank_expression) {  Dank::Models::Expression.new }

      context 'with a matching regex' do

        before do
          dank_expression.regex = subject.regex
        end

        context 'and a matching expression' do

          before do
            dank_expression.expression = subject.expression
          end

          it 'returns true' do
            expect(subject==dank_expression).to be true
          end
        end
      end
    end
  end
end