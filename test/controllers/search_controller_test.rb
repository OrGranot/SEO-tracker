require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get search_add_url
    assert_response :success
  end
end
