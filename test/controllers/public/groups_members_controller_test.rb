require "test_helper"

class Public::GroupsMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_groups_members_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_groups_members_destroy_url
    assert_response :success
  end
end
