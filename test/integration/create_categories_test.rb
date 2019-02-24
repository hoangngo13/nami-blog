require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Admin Test1", email: "admin_test1@example.com", password: "Aa@123456", admin: true)
    
  end

  test "get new category form and create a category" do
    sign_in_as(@user, "Aa@123456")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "technical"}}
    end
    assert_redirected_to categories_path
    #assert_match "technical", response.body
  end

  test "invalid category submission result fault" do
    sign_in_as(@user, "Aa@123456")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: " "}}
    end
    assert_template 'categories/new'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end