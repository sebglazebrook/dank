require 'spec_helper'

describe Evaluators::ExpressionEvaluator do

  describe '#evaluate' do

    subject { Evaluators::ExpressionEvaluator.new(expression).evaluate }

    context 'when given an expression' do

      let(:expression) { 'any_lowercase_letters' }

      it 'checks the lookup for a matching expression' do
        expect(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('any_lowercase_letters').and_return 'regex string'
        subject
      end

      context 'when no matching expression can be found' do

        before do
          allow(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('any_lowercase_letters').and_return nil
          allow(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('any').and_return 'regex string'
        end

        it 'checks the expression minus the first word against the lookup' do
          expect(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('lowercase_letters').and_return 'regex string'
          subject
        end

        context 'when a match is found' do

          let(:first_regex) { '[a-z]' }
          let(:first_dank_expression) { Dank::Models::Expression.new(regex: first_regex, expression: 'lowercase_letters') }

          before do
            allow(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('lowercase_letters').and_return first_regex
          end

          it 'checks the first word against the lookup' do
            expect(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('any').and_return 'regex string'
            subject
          end

          context 'when a match is found' do

            let(:regex_builder) { instance_double('Builders::RegexBuilder') }
            let(:second_regex) { '*' }
            let(:second_dank_expression) { Dank::Models::Expression.new(regex: second_regex, expression: 'any') }
            let(:builder_response) { double('builder response') }

            before do
              allow(Dank::Lookups::ExpressionRegexLookup).to receive(:lookup).with('any').and_return second_regex
              allow(Dank::Builders::RegexBuilder).to receive(:new).and_return regex_builder
              allow(regex_builder).to receive(:add).with(first_dank_expression)
              allow(regex_builder).to receive(:add).with(second_dank_expression)
              allow(regex_builder).to receive(:build).and_return builder_response
            end

            it 'puts the regexs together' do
              expect(regex_builder).to receive(:add).with(first_dank_expression)
              expect(regex_builder).to receive(:add).with(second_dank_expression)
              expect(regex_builder).to receive(:build)
              subject
            end

            it 'returns the builders response' do
              expect(subject).to eq builder_response
            end
          end
        end
      end
    end

    context 'when given an evaluable expression' do

      let(:expression) { 'any_lowercase_letters' }
      let(:dank_expression) { Dank::Models::Expression.new(regex: /[a-z]*/, expression: 'any_lowercase_letters') }

      it 'returns a Dank::Expression' do
        expect(subject).to eq dank_expression
      end
    end

    context 'when given a non-evaluable expression' do

      let(:expression) { '' }

      it 'raises an error' do
        expect{subject}.to raise_error Dank::Exceptions::UnknownExpression
      end
    end
  end
end