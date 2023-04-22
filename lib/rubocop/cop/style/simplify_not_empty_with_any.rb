# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # `array.any?` is a simplified way to say `!array.empty?`
      #
      # @example
      #   # bad
      #   !array.empty?
      #
      #   # good
      #   array.any?
      #
      class SimplifyNotEmptyWithAny < Base
        extend AutoCorrector
        MSG = 'Use `.any?` and remove the negation part.'
        RESTRICT_ON_SEND = [:!].freeze # optimization: don't call `on_send` unless
                                       # the method name is in the list

        # @!method bad_method?(node)
        def_node_matcher :not_empty_call?, <<~PATTERN
          (send (send $(...) :empty?) :!)
        PATTERN

        def on_send(node)
          expression = not_empty_call?(node)
          return unless not_empty_call?(node)

          add_offense(node) do |corrector|
            corrector.replace(node, "#{expression.source}.any?")
          end
        end
      end
    end
  end
end
