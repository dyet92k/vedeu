require 'test_helper'

module Vedeu

  describe Timer do

    let(:described) { Vedeu::Timer }
    let(:instance)  { described.new(type, _message) }
    let(:type)      { :debug }
    let(:_message)  { 'Testing' }
    let(:_time)     { mock('Time') }
    let(:started)   { 1434492219.5238185 }

    before do
      Time.stubs(:now).returns(_time)
      _time.stubs(:to_f).returns(started)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@type').must_equal(type) }
      it { instance.instance_variable_get('@message').must_equal(_message) }
      it { instance.instance_variable_get('@started').must_equal(started) }
    end

    describe '.for' do
      it { described.must_respond_to(:for) }
    end

    describe '#measure' do
      subject { instance.measure { } }

      it {
        Vedeu.expects(:log).with(type: :debug,
                                 message: "Testing took 0ms.")
        subject
      }
    end

  end # Timer

end # Vedeu