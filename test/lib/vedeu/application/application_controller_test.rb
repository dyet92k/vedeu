# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe ApplicationController do

    let(:described) { Vedeu::ApplicationController }
    let(:instance)  { described.new(params) }
    let(:params)    { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@params').must_equal(params) }
    end

    describe '#redirect_to' do
      let(:controller) {}
      let(:action)     {}
      let(:params)     { {} }

      before { Vedeu.stubs(:trigger) }

      subject { instance.redirect_to(controller, action, params) }

      it do
        Vedeu.expects(:trigger).with(:_goto_, controller, action, params)
        subject
      end
    end

    describe '#redirect' do
      it { instance.must_respond_to(:redirect) }
    end

    describe '#goto' do
      it { instance.must_respond_to(:goto) }
    end

  end # ApplicationController

end # Vedeu
