require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @user = users(:user)
    @category = categories(:category)
    @task = tasks(:task)
    sign_in @user
    visit categories_url
  end

  test "visiting the index" do
    click_on(class: "show-category")
    assert_text "Scheduled Tasks"
  end

  test "creating a task" do
    click_on(class: "show-category")

    click_on "+ Add New Task"
    fill_in "Title", with: @task.title
    fill_in "Notes", with: @task.body
    click_on "Create Task"

    assert_text "Task was successfully created."
  end

  test "view a task" do
    click_on(class: "show-category")
    click_on(class: "show-task")
    assert_text "Edit"
  end

  test "updating a task" do
    click_on(class: "show-category")

    click_on(class: "edit-task")
    fill_in "Title", with: @task.title
    fill_in "Notes", with: @task.body
    click_on "Update Task"

    assert_text "Successfully updated task!"
  end

  test "deleting a task" do
    click_on(class: "show-category")
    
    page.accept_confirm do
      click_on(class: "delete-task")
    end

    assert_text "Task was successfully deleted."
  end
end
