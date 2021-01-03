class AddArchiveToTaskList < ActiveRecord::Migration[6.0]
  def change
    add_column :task_lists, :archive, :boolean
  end
end
