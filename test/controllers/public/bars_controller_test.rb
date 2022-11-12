require "test_helper"

class Public::BarsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_bars_create_url
    assert_response :success
  end
end
