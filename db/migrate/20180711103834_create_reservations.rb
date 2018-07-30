class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations, id: :uuid do |t|
      t.integer :sector_id, foreign_key: true
      t.integer :tickets_count
      t.string :status
      t.datetime :requested_at
    end
  end
end
