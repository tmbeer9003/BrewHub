require "test_helper"

class Admin::BeerStylesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_beer_styles_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_beer_styles_create_url
    assert_response :success
  end

  test "should get index" do
    get admin_beer_styles_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_beer_styles_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_beer_styles_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_beer_styles_destroy_url
    assert_response :success
  end
end
