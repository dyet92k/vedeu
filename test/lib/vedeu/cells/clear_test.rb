require 'test_helper'

module Vedeu

  module Cells

    describe Clear do

      let(:described)  { Vedeu::Cells::Clear }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          value: _value,
        }
      }
      let(:_value) { ' ' }

      describe '#value' do
        subject { instance.value }

        it { subject.must_equal(' ') }
      end

    end # Clear

  end # Cells

end # Vedeu
