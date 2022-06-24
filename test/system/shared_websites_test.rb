require "application_system_test_case"

class SharedWebsitesTest < ApplicationSystemTestCase
  setup do
    @shared_website = shared_websites(:one)
  end

  test "visiting the index" do
    visit shared_websites_url
    assert_selector "h1", text: "Shared Websites"
  end

  test "creating a Shared website" do
    visit shared_websites_url
    click_on "New Shared Website"

    fill_in "Role", with: @shared_website.role
    fill_in "User", with: @shared_website.user_id
    fill_in "Website", with: @shared_website.website_id
    click_on "Create Shared website"

    assert_text "Shared website was successfully created"
    click_on "Back"
  end

  test "updating a Shared website" do
    visit shared_websites_url
    click_on "Edit", match: :first

    fill_in "Role", with: @shared_website.role
    fill_in "User", with: @shared_website.user_id
    fill_in "Website", with: @shared_website.website_id
    click_on "Update Shared website"

    assert_text "Shared website was successfully updated"
    click_on "Back"
  end

  test "destroying a Shared website" do
    visit shared_websites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shared website was successfully destroyed"
  end
end
