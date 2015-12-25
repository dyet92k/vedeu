# frozen_string_literal: true

require 'test_helper'

class OtherKlass
end # OtherKlass

module MyFirstApp

  class SomeKlass

  end # SomeKlass

end # MyFirstApp

module Vedeu

  class VedeuCommonClass

    include Vedeu::Common

    def defined_value_test(variable)
      present?(variable)
    end

    def undefined_value_test(variable)
      absent?(variable)
    end

  end # VedeuCommonClass

  describe Common do

    let(:described) { Vedeu::VedeuCommonClass }
    let(:instance)  { described.new }

    describe '#absent?' do
      subject { instance.undefined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(false) }
      end

      context 'when the variable is not nil or empty' do
        let(:_value) { 'not empty' }

        it { subject.must_equal(false) }
      end

      context 'when the variable is nil or empty' do
        let(:_value) { [] }

        it { subject.must_equal(true) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:_value)     { attributes[:not_found] }

        it { subject.must_equal(true) }
      end
    end

    describe '#become' do
      let(:instance)   { Vedeu::Cells::Border.new }
      let(:klass)      { Vedeu::Cells::Char }
      let(:attributes) { instance.attributes }

      subject { instance.become(klass, attributes) }

      it { subject.must_be_instance_of(Vedeu::Cells::Char) }
    end

    describe '#boolean' do
      subject { instance.boolean(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(false) }
      end

      context 'when the value is nil' do
        let(:_value) {}

        it { subject.must_equal(false) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(true) }
      end
    end

    describe '#boolean?' do
      subject { instance.boolean?(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(false) }
      end
    end

    describe '#falsy?' do
      subject { instance.falsy?(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(false) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(true) }
      end

      context 'when the value is nil' do
        let(:_value) {}

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(false) }
      end
    end

    describe '#hash?' do
      let(:_value) {}

      subject { instance.hash?(_value) }

      context 'when the value is a Hash' do
        let(:_value) { { element: :hydrogen } }

        it { subject.must_equal(true) }
      end

      context 'when the value is not a Hash' do
        it { subject.must_equal(false) }
      end
    end

    describe '#numeric?' do
      let(:_value) {}

      subject { instance.numeric?(_value) }

      context 'when the value is numeric' do
        let(:_value) { 16 }

        it { subject.must_equal(true) }
      end

      context 'when the value is not numeric' do
        it { subject.must_equal(false) }
      end
    end

    describe '#present?' do
      subject { instance.defined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(true) }
      end

      context 'when the variable is a Symbol' do
        let(:_value) { :some_value }

        it { subject.must_equal(true) }
      end

      context 'when the variable is not nil or empty' do
        let(:_value) { 'not empty' }

        it { subject.must_equal(true) }
      end

      context 'when the variable is nil or empty' do
        let(:_value) { [] }

        it { subject.must_equal(false) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:_value)     { attributes[:not_found] }

        it { subject.must_equal(false) }
      end
    end

    describe '#snake_case' do
      subject { instance.snake_case(klass) }

      context 'when empty' do
        let(:klass) { '' }

        it { subject.must_equal('') }
      end

      context 'when a single module' do
        let(:klass) { MyFirstApp }

        it { subject.must_equal('my_first_app') }
      end

      context 'when namespaced class' do
        let(:klass) { MyFirstApp::SomeKlass }

        it { subject.must_equal('my_first_app/some_klass') }
      end

      context 'when single class' do
        let(:klass) { ::OtherKlass }

        it { subject.must_equal('other_klass') }
      end

      context 'when a string' do
        let(:klass) { 'MyFirstApp' }

        it { subject.must_equal('my_first_app') }
      end
    end

    describe '#string?' do
      let(:_value) {}

      subject { instance.string?(_value) }

      context 'when the value is string' do
        let(:_value) { 'test' }

        it { subject.must_equal(true) }
      end

      context 'when the value is not string' do
        it { subject.must_equal(false) }
      end
    end

    describe '#truthy?' do
      subject { instance.truthy?(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(false) }
      end

      context 'when the value is nil' do
        let(:_value) {}

        it { subject.must_equal(false) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(true) }
      end
    end

  end # Common

end # Vedeu
