require 'test_helper'

module Vedeu

  module Config

    describe API do

      let(:described) { Vedeu::Config::API }
      let(:instance)  { described.new }

      before { Configuration.reset! }
      after  { test_configuration }

      describe 'alias_methods' do
        it { instance.must_respond_to(:interactive) }
        it { instance.must_respond_to(:standalone) }
        it { instance.must_respond_to(:run_once) }
        it { instance.must_respond_to(:drb) }
        it { instance.must_respond_to(:cooked) }
        it { instance.must_respond_to(:raw) }
        it { instance.must_respond_to(:debug) }
        it { instance.must_respond_to(:trace) }
      end

      describe '.configure' do
        it 'returns the configuration singleton' do
          Vedeu.configure do
            # ...
          end.must_equal(Vedeu::Configuration)
        end
      end

      describe '#interactive!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive! }
          configuration.interactive?.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive(false) }
          configuration.interactive?.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive(true) }
          configuration.interactive?.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { interactive }
          configuration.interactive?.must_equal(true)
        end
      end

      describe '#standalone!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone! }
          configuration.interactive?.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone(false) }
          configuration.interactive?.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone(true) }
          configuration.interactive?.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { standalone }
          configuration.interactive?.must_equal(false)
        end
      end

      describe '#run_once!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once! }
          configuration.once.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once(false) }
          configuration.once.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once(true) }
          configuration.once.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { run_once }
          configuration.once.must_equal(true)
        end
      end

      describe '#drb!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb! }
          configuration.drb.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb(false) }
          configuration.drb.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb(true) }
          configuration.drb.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { drb }
          configuration.drb.must_equal(true)
        end
      end

      describe '#drb_host' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_host('localhost') }
          configuration.drb_host.must_equal('localhost')
        end
      end

      describe '#drb_port' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_port('12345') }
          configuration.drb_port.must_equal('12345')
        end
      end

      describe '#drb_height' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_height(15) }
          configuration.drb_height.must_equal(15)
        end
      end

      describe '#drb_width' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { drb_width(40) }
          configuration.drb_width.must_equal(40)
        end
      end

      describe '#cooked!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { cooked! }
          configuration.terminal_mode.must_equal(:cooked)
        end
      end

      describe '#raw!' do
        subject { Vedeu.configure { raw! } }

        it 'sets the option to the desired value' do
          subject.terminal_mode.must_equal(:raw)
        end
      end

      describe '#debug!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { debug! }
          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { debug(true) }
          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { debug(false) }
          configuration.debug.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { trace(true) }
          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure do
            debug(false)
            trace(true)
          end

          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure do
            debug(true)
            trace(false)
          end

          configuration.debug.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure do
            debug(false)
            trace(false)
          end

          configuration.debug.must_equal(false)
        end
      end

      describe '#trace!' do
        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { trace! }

          configuration.trace.must_equal(true)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { trace(false) }

          configuration.trace.must_equal(false)
          configuration.debug.must_equal(false)
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { trace(true) }

          configuration.trace.must_equal(true)
          configuration.debug.must_equal(true)
        end
      end

      describe '#colour_mode' do
        context 'when the value is invalid (nil)' do
          it { proc {
            Vedeu.configure { colour_mode(nil) }
          }.must_raise(InvalidSyntax) }
        end

        context 'when the value is invalid (empty)' do
          it { proc {
            Vedeu.configure { colour_mode('') }
          }.must_raise(InvalidSyntax) }
        end

        context 'when the value is invalid' do
          it { proc {
            Vedeu.configure { colour_mode(1234) }
          }.must_raise(InvalidSyntax) }
        end

        it 'sets the option to the desired value' do
          configuration = Vedeu.configure { colour_mode(256) }
          configuration.colour_mode.must_equal(256)
        end
      end

      describe '#log' do
        it 'sets the options to the desired value' do
          configuration = Vedeu.configure { log('/tmp/vedeu_api_test.log') }
          configuration.log.must_equal('/tmp/vedeu_api_test.log')
        end
      end

      describe 'redefining system keys' do
        methods_and_keys = {
          exit_key:        :exit,
          focus_next_key:  :focus_next,
          focus_prev_key:  :focus_prev,
          mode_switch_key: :mode_switch,
        }

        context 'when using an invalid value' do
          invalid_params = [nil, '', 123, 'oops']

          methods_and_keys.each do |meth, _|
            invalid_params.each do |param|
              context 'when the parameter is invalid' do
                it { proc { Vedeu.configure { send(meth, param) } }.must_raise(InvalidSyntax) }
              end
            end
          end
        end

        context 'when using a valid value' do
          valid_params = ['v', :f1]

          methods_and_keys.each do |meth, key|
            valid_params.each do |param|
              it 'sets the system key to the desired value' do
                configuration = Vedeu.configure { send(meth, param) }

                configuration.system_keys[key].must_equal(param)
              end
            end
          end
        end
      end

    end # API

  end # Config

end # Vedeu
