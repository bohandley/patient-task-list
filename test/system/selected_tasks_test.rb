require "application_system_test_case"

class SelectedTasksTest < ApplicationSystemTestCase
  setup do
    @selected_task = selected_tasks(:one)
  end

  test "visiting the index" do
    visit selected_tasks_url
    assert_selector "h1", text: "Selected Tasks"
  end

  test "creating a Selected task" do
    visit selected_tasks_url
    click_on "New Selected Task"

    fill_in "Complete date", with: @selected_task.complete_date
    fill_in "Instruction", with: @selected_task.instruction_id
    check "Is complete" if @selected_task.is_complete
    fill_in "Task item", with: @selected_task.task_item_id
    click_on "Create Selected task"

    assert_text "Selected task was successfully created"
    click_on "Back"
  end

  test "updating a Selected task" do
    visit selected_tasks_url
    click_on "Edit", match: :first

    fill_in "Complete date", with: @selected_task.complete_date
    fill_in "Instruction", with: @selected_task.instruction_id
    check "Is complete" if @selected_task.is_complete
    fill_in "Task item", with: @selected_task.task_item_id
    click_on "Update Selected task"

    assert_text "Selected task was successfully updated"
    click_on "Back"
  end

  test "destroying a Selected task" do
    visit selected_tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Selected task was successfully destroyed"
  end
end
