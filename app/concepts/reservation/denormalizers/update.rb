class Reservation
  module Denormalizers
    class Update
      include Sidekiq::Worker

      def perform(*args)
        call(args.first)
      end

      private

      def call(event)
        Reservation.find(event["data"]["id"]).lock!.update(status: event["data"]["status"])
      end
    end
  end
end
