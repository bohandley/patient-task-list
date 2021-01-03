class CreateTaskItems < ActiveRecord::Migration[6.0]
  def change
    create_table :task_items do |t|
      t.string :title
      t.text :body
      t.integer :due
      t.references :task_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
