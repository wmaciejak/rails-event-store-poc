class Reservation
  module Worker
    class Process
      include Sidekiq::Worker
      include Command::Execute

      def perform(reservation_id, requested_at, params)
        cmd = Commands::Create.new(
          params.merge(id: reservation_id, requested_at: requested_at)
        )
        execute(cmd)
      end
    end
  end
end
