require "test_helper"

class Public::BeersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_beers_create_url
    assert_response :success
  end

  test "should get index" do
    get public_beers_index_url
    assert_response :success
  end

  test "should get new" do
    get public_beers_new_url
    assert_response :success
  end

  test "should get show" do
    get public_beers_show_url
    assert_response :success
  end
end
