require 'test_helper'

class TaskItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_item = task_items(:one)
  end

  test "should get index" do
    get task_items_url
    assert_response :success
  end

  test "should get new" do
    get new_task_item_url
    assert_response :success
  end

  test "should create task_item" do
    assert_difference('TaskItem.count') do
      post task_items_url, params: { task_item: { body: @task_item.body, due: @task_item.due, task_list_id: @task_item.task_list_id, title: @task_item.title } }
    end

    assert_redirected_to task_item_url(TaskItem.last)
  end

  test "should show task_item" do
    get task_item_url(@task_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_item_url(@task_item)
    assert_response :success
  end

  test "should update task_item" do
    patch task_item_url(@task_item), params: { task_item: { body: @task_item.body, due: @task_item.due, task_list_id: @task_item.task_list_id, title: @task_item.title } }
    assert_redirected_to task_item_url(@task_item)
  end

  test "should destroy task_item" do
    assert_difference('TaskItem.count', -1) do
      delete task_item_url(@task_item)
    end

    assert_redirected_to task_items_url
  end
end
