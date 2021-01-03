require "application_system_test_case"

class TaskItemsTest < ApplicationSystemTestCase
  setup do
    @task_item = task_items(:one)
  end

  test "visiting the index" do
    visit task_items_url
    assert_selector "h1", text: "Task Items"
  end

  test "creating a Task item" do
    visit task_items_url
    click_on "New Task Item"

    fill_in "Body", with: @task_item.body
    fill_in "Due", with: @task_item.due
    fill_in "Task list", with: @task_item.task_list_id
    fill_in "Title", with: @task_item.title
    click_on "Create Task item"

    assert_text "Task item was successfully created"
    click_on "Back"
  end

  test "updating a Task item" do
    visit task_items_url
    click_on "Edit", match: :first

    fill_in "Body", with: @task_item.body
    fill_in "Due", with: @task_item.due
    fill_in "Task list", with: @task_item.task_list_id
    fill_in "Title", with: @task_item.title
    click_on "Update Task item"

    assert_text "Task item was successfully updated"
    click_on "Back"
  end

  test "destroying a Task item" do
    visit task_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task item was successfully destroyed"
  end
end
