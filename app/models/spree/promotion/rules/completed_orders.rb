# frozen_string_literal: true

module Spree
  class Promotion
    module Rules
      class CompletedOrders < PromotionRule
        preference :completed_orders, :integer, default: 1

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})
          unless order.user.present?
            eligibility_errors.add(:base, eligibility_error_message(:no_user_specified))
            return false
          end

          if order.user.orders.complete.size < preferred_completed_orders
            eligibility_errors.add(:base, eligibility_error_message(:no_applicable_completed_orders, number: preferred_completed_orders))
            return false
          end

          return true
        end
      end
    end
  end
end
