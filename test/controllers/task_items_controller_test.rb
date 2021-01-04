require 'test_helper'

class TaskItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_item = task_items(:one)
  end

  test "should get index" do
    get task_list_task_items_path(@task_item)
    assert_response :success
  end

  test "should get new" do
    get new_task_list_task_item_path(@task_item)
    assert_response :success
  end

  test "should show task_item" do
    get task_item_url(@task_item)
    assert_response :success
  end

end
