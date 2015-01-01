require 'test_helper'

module Vedeu

  module DSL

    describe Geometry do

      let(:described) { Vedeu::DSL::Geometry.new(model) }
      let(:model)     { Vedeu::Geometry.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Geometry) }
        it { assigns(described, '@model', model) }
      end

      describe '#centred' do
        subject { Vedeu::Geometry.build({}) { centred true } }

        it 'sets the attribute to the value' do
          subject.centred.must_equal(true)
        end
      end

      describe '#height' do
        subject { Vedeu::Geometry.build({}) { height 6 } }

        it 'sets the attribute to the value' do
          subject.height.must_equal(6)
        end
      end

      describe '#name' do
        subject { Vedeu::Geometry.build({}) { name 'chlorine' } }

        it 'sets the attribute to the value' do
          subject.name.must_equal('chlorine')
        end
      end

      describe '#width' do
        subject { Vedeu::Geometry.build({}) { width 25 } }

        it 'sets the attribute to the value' do
          subject.width.must_equal(25)
        end
      end

      describe '#x' do
        subject { Vedeu::Geometry.build({}) { x 2 } }

        it 'sets the attribute to the value' do
          subject.x.must_equal(2)
        end
      end

      describe '#y' do
        subject { Vedeu::Geometry.build({}) { y 5 } }

        it 'sets the attribute to the value' do
          subject.y.must_equal(5)
        end
      end

    end # Geometry

  end # DSL

end # Vedeu
