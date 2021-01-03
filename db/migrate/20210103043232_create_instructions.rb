class CreateInstructions < ActiveRecord::Migration[6.0]
  def change
    create_table :instructions do |t|
      t.integer :task_list_id
      t.integer :patient_id
      t.date :start_date

      t.timestamps
    end
  end
end
