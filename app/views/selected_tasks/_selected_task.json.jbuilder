json.extract! selected_task, :id, :instruction_id, :task_item_id, :is_complete, :complete_date, :created_at, :updated_at
json.url selected_task_url(selected_task, format: :json)
