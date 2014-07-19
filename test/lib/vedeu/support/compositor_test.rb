require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/compositor'

module Vedeu
  describe Compositor do
    describe '.enqueue' do
      it 'enqueues the interfaces for rendering' do
        attributes = {
          interfaces: [
            {
              name: 'Compositor.enqueue_1',
              width: 5,
              height: 5,
              lines: {
                streams: {
                  text: 'bd459118e6175689e4394e242debc2ae'
                }
              }
            }, {
              name: 'Compositor.enqueue_2',
              width: 5,
              height: 5,
              lines: {
                streams: {
                  text: '837acb2cb2ea3ef359257851142a7830'
                }
              }
            }
          ]
        }

        Compositor.enqueue(attributes)
        InterfaceRepository.find('Compositor.enqueue_1').dequeue
          .must_match(/bd459118e6175689e4394e242debc2ae/)
        InterfaceRepository.find('Compositor.enqueue_2').dequeue
          .must_match(/837acb2cb2ea3ef359257851142a7830/)
      end
    end
  end
end
