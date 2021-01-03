require 'test_helper'

class SelectedTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @selected_task = selected_tasks(:one)
  end

  test "should get index" do
    get selected_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_selected_task_url
    assert_response :success
  end

  test "should create selected_task" do
    assert_difference('SelectedTask.count') do
      post selected_tasks_url, params: { selected_task: { complete_date: @selected_task.complete_date, instruction_id: @selected_task.instruction_id, is_complete: @selected_task.is_complete, task_item_id: @selected_task.task_item_id } }
    end

    assert_redirected_to selected_task_url(SelectedTask.last)
  end

  test "should show selected_task" do
    get selected_task_url(@selected_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_selected_task_url(@selected_task)
    assert_response :success
  end

  test "should update selected_task" do
    patch selected_task_url(@selected_task), params: { selected_task: { complete_date: @selected_task.complete_date, instruction_id: @selected_task.instruction_id, is_complete: @selected_task.is_complete, task_item_id: @selected_task.task_item_id } }
    assert_redirected_to selected_task_url(@selected_task)
  end

  test "should destroy selected_task" do
    assert_difference('SelectedTask.count', -1) do
      delete selected_task_url(@selected_task)
    end

    assert_redirected_to selected_tasks_url
  end
end
