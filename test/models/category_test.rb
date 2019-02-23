require 'test_helper'
 
class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = Category.new(name: "technical")
  end
  
  test "category should be valid" do
    assert @category.valid?

  end

  test "name should be present" do
    @category.name = nil
    assert_not @category.valid?
  end

  test "name should be uniq" do
    @category.save
    category_1 = Category.new(name: "technical")
    assert_not category_1.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end