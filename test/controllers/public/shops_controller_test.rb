require "test_helper"

class Public::ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_shops_create_url
    assert_response :success
  end
end
