class Reservation
  module CommandHandlers
    class UpdateStatus
      include Command::Handler

      def call(command)
        with_aggregate(Reservation::Aggregate, command.aggregate_id) do |reservation|
          reservation.update_status(command)
        end
      end
    end
  end
end
