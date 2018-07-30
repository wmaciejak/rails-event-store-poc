class Reservation
  module CommandHandlers
    class Create
      include Command::Handler

      def call(command)
        with_aggregate(Reservation::Aggregate, command.aggregate_id) do |reservation|
          reservation.create(command)
        end
      end
    end
  end
end
