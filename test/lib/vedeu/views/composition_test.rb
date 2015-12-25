# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    describe Composition do

      let(:described)  { Vedeu::Views::Composition }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          client: client,
          colour: colour,
          parent: parent,
          style:  style,
          value:  _value,
        }
      }
      let(:client) {}
      let(:colour) {}
      let(:parent) {}
      let(:style)  {}
      let(:_value) {}

      describe '.build' do
        subject {
          described.build({}) do
            # ...
          end
        }

        it { subject.must_be_instance_of(described) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@client').must_equal(client) }
        it { instance.instance_variable_get('@colour').must_equal(colour) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
        it { instance.instance_variable_get('@style').must_equal(style) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '#attributes' do
        it { instance.must_respond_to(:attributes) }
      end

      describe '#parent' do
        it { instance.must_respond_to(:parent) }
      end

      describe '#value' do
        it { instance.must_respond_to(:value) }
      end

      describe '#views' do
        it { instance.must_respond_to(:views) }
      end

      describe '#add' do
        let(:child) { Vedeu::Views::View.new }

        subject { instance.add(child) }

        it { subject.must_be_instance_of(Vedeu::Views::Views) }
      end

      describe '#<<' do
        it { instance.must_respond_to(:<<) }
      end

    end # Composition

  end # Views

end # Vedeu
