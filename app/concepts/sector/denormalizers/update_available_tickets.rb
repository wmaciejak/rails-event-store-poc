class Sector
  module Denormalizers
    class UpdateAvailableTickets
      include Sidekiq::Worker

      def perform(*args)
        call(args.first)
      end

      private

      def call(event)
        sector = Sector.find_by_id(event["data"]["sector_id"])
        sector.available_tickets_count -= event["data"]["tickets_count"].to_i
        sector.save!
      end
    end
  end
end
