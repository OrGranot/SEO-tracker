require "test_helper"

class SharedWebsitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shared_website = shared_websites(:one)
  end

  test "should get index" do
    get shared_websites_url
    assert_response :success
  end

  test "should get new" do
    get new_shared_website_url
    assert_response :success
  end

  test "should create shared_website" do
    assert_difference('SharedWebsite.count') do
      post shared_websites_url, params: { shared_website: { role: @shared_website.role, user_id: @shared_website.user_id, website_id: @shared_website.website_id } }
    end

    assert_redirected_to shared_website_url(SharedWebsite.last)
  end

  test "should show shared_website" do
    get shared_website_url(@shared_website)
    assert_response :success
  end

  test "should get edit" do
    get edit_shared_website_url(@shared_website)
    assert_response :success
  end

  test "should update shared_website" do
    patch shared_website_url(@shared_website), params: { shared_website: { role: @shared_website.role, user_id: @shared_website.user_id, website_id: @shared_website.website_id } }
    assert_redirected_to shared_website_url(@shared_website)
  end

  test "should destroy shared_website" do
    assert_difference('SharedWebsite.count', -1) do
      delete shared_website_url(@shared_website)
    end

    assert_redirected_to shared_websites_url
  end
end
