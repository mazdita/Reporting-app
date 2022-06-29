class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :admin_id
      t.integer :report_id
      t.text :content

      t.timestamps
    end
  end
end
