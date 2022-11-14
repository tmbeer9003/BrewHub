require "test_helper"

class Public::CheersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_cheers_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_cheers_destroy_url
    assert_response :success
  end
end
