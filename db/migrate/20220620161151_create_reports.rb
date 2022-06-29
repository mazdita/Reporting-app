class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :type
      t.integer :admin_id

      t.timestamps
    end
  end
end
