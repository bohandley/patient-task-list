json.extract! task_item, :id, :title, :body, :due, :task_list_id, :created_at, :updated_at
json.url task_item_url(task_item, format: :json)
