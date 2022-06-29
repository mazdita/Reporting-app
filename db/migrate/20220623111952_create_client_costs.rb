class CreateClientCosts < ActiveRecord::Migration[6.1]
  def change
    create_table :client_costs do |t|
      t.string :client
      t.string :month
      t.decimal :cost, precision: 25, scale: 10

      t.timestamps
    end
  end
end
