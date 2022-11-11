require "test_helper"

class Admin::BreweriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_breweries_create_url
    assert_response :success
  end

  test "should get index" do
    get admin_breweries_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_breweries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_breweries_destroy_url
    assert_response :success
  end
end
