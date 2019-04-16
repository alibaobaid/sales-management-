require "application_system_test_case"

class MarketersTest < ApplicationSystemTestCase
  setup do
    @marketer = marketers(:one)
  end

  test "visiting the index" do
    visit marketers_url
    assert_selector "h1", text: "Marketers"
  end

  test "creating a Marketer" do
    visit marketers_url
    click_on "New Marketer"

    fill_in "City", with: @marketer.city
    fill_in "For him", with: @marketer.for_him
    fill_in "Name", with: @marketer.name
    fill_in "Phone no", with: @marketer.phone_NO
    fill_in "To him", with: @marketer.to_him
    click_on "Create Marketer"

    assert_text "Marketer was successfully created"
    click_on "Back"
  end

  test "updating a Marketer" do
    visit marketers_url
    click_on "Edit", match: :first

    fill_in "City", with: @marketer.city
    fill_in "For him", with: @marketer.for_him
    fill_in "Name", with: @marketer.name
    fill_in "Phone no", with: @marketer.phone_NO
    fill_in "To him", with: @marketer.to_him
    click_on "Update Marketer"

    assert_text "Marketer was successfully updated"
    click_on "Back"
  end

  test "destroying a Marketer" do
    visit marketers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Marketer was successfully destroyed"
  end
end
