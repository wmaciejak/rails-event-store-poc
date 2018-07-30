class ReservationsController < ApplicationController
  # Endpoint for showing reservation (client might probably be most interested in its status)
  # in order for the client to recognize whether reservation went fine or something has failed.
  def show
    reservation = Reservation.find_by(id: params[:id])

    render json: { reservation: reservation }, status: 200
  end

  # Endpoint for requesting a reservation for given sector and tickets amount
  def create
    reservation_id = SecureRandom.uuid

    Reservation::Worker::Process.perform_async(reservation_id, Time.zone.now.to_i, reservation_params)

    render json: { reservation_id: reservation_id }, status: 200
  end

  # Endpoint for payment gateway callback.
  # For POC purposes this endpoint accepts reservation_id and single parameter that denotes
  # whether payment was successful or not - based on this information appropriate status
  # is assigned to reservation
  def payment_callback
    cmd = Reservation::Commands::UpdateStatus.new(id: params[:reservation_id], status: params[:status])
    execute(cmd)

    if cmd.valid?
      render json: { message: "Congrats!", reservation: { id: cmd.id, status: cmd.status } },
             status: 200
    else
      render json: { error: "Something went wrong with payment", reservation: { id: cmd.id, status: cmd.status } },
             status: 422
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:sector_id, :tickets_count).to_h.deep_symbolize_keys
  end
end
