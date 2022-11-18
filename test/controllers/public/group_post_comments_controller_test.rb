require "test_helper"

class Public::GroupPostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_group_post_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_group_post_comments_destroy_url
    assert_response :success
  end
end
