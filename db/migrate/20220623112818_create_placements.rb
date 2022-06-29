class CreatePlacements < ActiveRecord::Migration[6.1]
  def change
    create_table :placements do |t|
      t.string :client_name
      t.string :worker_first_name
      t.string :job_function
      t.date :start_date
      t.date :end_date
      t.decimal :monthly_salary, precision: 25, scale: 10

      t.timestamps
    end
  end
end
