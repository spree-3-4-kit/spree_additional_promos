# frozen_string_literal: true

module Spree
  class Promotion
    module Rules
      class ItemQuantity < PromotionRule
        preference :quantity, :integer, :default => 10
        preference :operator, :string, :default => '>'

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        OPERATORS = ['gt', 'gte']

        def eligible?(order, options = {})
          item_total = order.line_items.map(&:quantity).sum
          item_total.send(preferred_operator == 'gte' ? :>= : :>, preferred_quantity)
        end

      end
    end
  end
end
