# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_editor_).must_equal(true) }
  end

  module Editor

    describe Editor do

      let(:described) { Vedeu::Editor::Editor }
      let(:instance)  {
        described.new(input: input, name: _name)
      }
      let(:input)     {}
      let(:_name)     { :vedeu_editor_editor }
      let(:document)  { Vedeu::Editor::Document.new(data: data, name: _name) }
      let(:data)      {
        "Hydrogen\n"  \
        "Helium\n"    \
        "Lithium\n"
      }

      before do
        Vedeu.documents.stubs(:by_name).returns(document)
        # document.stubs(:clear)
        # document.stubs(:delete_character)
        # document.stubs(:delete_line)
        # document.stubs(:down)
        # document.stubs(:execute)
        # document.stubs(:left)
        # document.stubs(:right)
        # document.stubs(:insert_character)
        # document.stubs(:insert_line)
        # document.stubs(:render)
        # document.stubs(:reset!)
        # document.stubs(:up)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.keypress' do
        before { Vedeu::Terminal.stubs(:output) }

        subject { described.keypress(input: input, name: _name) }

        context 'when no name is given' do
          let(:document) {}

          it 'returns the input instead of sending to the document' do
            subject.must_equal(input)
          end
        end

        context 'when a name is given' do
          context 'when the input is :backspace' do
            let(:input) { :backspace }

            it do
              document.expects(:delete_character)
              subject
            end
          end

          context 'when the input is :ctrl_c' do
            let(:input) { :ctrl_c }

            it do
              Vedeu.expects(:trigger).with(:_exit_)
              subject
            end
          end

          context 'when the input is :down' do
            let(:input) { :down }

            it do
              document.expects(:down)
              subject
            end
          end

          context 'when the input is :enter' do
            let(:input) { :enter }

            it do
              document.expects(:insert_line)
              subject
            end
          end

          context 'when the input is :escape' do
            let(:input) { :escape }

            it do
              Vedeu.expects(:trigger).with(:_mode_switch_)
              subject
            end
          end

          context 'when the input is :left' do
            let(:input) { :left }

            it do
              document.expects(:left)
              subject
            end
          end

          context 'when the input is :right' do
            let(:input) { :right }

            it do
              document.expects(:right)
              subject
            end
          end

          context 'when the input is :tab' do
            let(:input) { :tab }
            let(:data)  { mock(:empty? => false) }

            # it do
            #   document.expects(:execute).returns(data)
            #   document.expects(:reset!)
            #   document.expects(:clear)
            #   Vedeu.expects(:trigger).with(:_command_, data)
            #   subject
            # end
          end

          context 'when the input is :up' do
            let(:input) { :up }

            it do
              document.expects(:up)
              subject
            end
          end

          context 'when the input is something else' do
            context 'when the input is a symbol' do
              let(:input) { :ctrl_p }

              it { subject.must_be_instance_of(Vedeu::Editor::Document) }
            end

            context 'when the input is not a symbol' do
              let(:input) { 'a' }

              it do
                document.expects(:insert_character).with(input)
                subject
              end
            end
          end
        end
      end

      describe '#keypress' do
        it { instance.must_respond_to(:keypress) }
      end

    end # Editor

  end # Editor

end # Vedeu
