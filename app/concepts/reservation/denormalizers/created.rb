class Reservation
  module Denormalizers
    class Created
      include Sidekiq::Worker

      def perform(*args)
        call(args.first)
      end

      private

      def call(event)
        reservation = Reservation.new(event["data"])
        reservation.status = "payment_pending"
        reservation.save!
      # rescue ActiveRecord::StatementInvalid
      #   reservation.status = "not_enough_tickets_in_sector"
      #   reservation.save!
      end
    end
  end
end
