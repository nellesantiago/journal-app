require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user)
    @category = categories(:category)
    sign_in @user
    visit categories_url
  end

  test "visiting the index" do
    assert_text "Task Categories"
  end

  test "creating a category" do
    click_on(class: "add-category")

    visit new_category_path
    fill_in "Title", with: @category.title
    click_on "Create Category"

    assert_text "Category was successfully created."
  end

  test "view a category" do
    click_on(class: "show-category")
    assert_text "Today's Task"
  end

  test "updating a category" do
    click_on(class: "edit-category")
    fill_in "Title", with: @category.title
    click_on "Update Category"

    assert_text "Category was successfully updated."
  end

  test "deleting a category" do
    page.accept_confirm do
      click_on(class: "delete-category")
    end

    assert_text "Category was successfully deleted."
  end
  
  test "view all today's task" do
    assert_text "Today's Task"
  end
end
