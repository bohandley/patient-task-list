class CreateSelectedTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_tasks do |t|
      t.references :instruction, null: false, foreign_key: true
      t.references :task_item, null: false, foreign_key: true
      t.boolean :is_complete
      t.date :complete_date

      t.timestamps
    end
  end
end
