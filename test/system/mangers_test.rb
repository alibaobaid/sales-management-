require "application_system_test_case"

class MangersTest < ApplicationSystemTestCase
  setup do
    @manger = mangers(:one)
  end

  test "visiting the index" do
    visit mangers_url
    assert_selector "h1", text: "Mangers"
  end

  test "creating a Manger" do
    visit mangers_url
    click_on "New Manger"

    fill_in "City", with: @manger.city
    fill_in "For him", with: @manger.for_him
    fill_in "Name", with: @manger.name
    fill_in "Phone no", with: @manger.phone_NO
    fill_in "To him", with: @manger.to_him
    click_on "Create Manger"

    assert_text "Manger was successfully created"
    click_on "Back"
  end

  test "updating a Manger" do
    visit mangers_url
    click_on "Edit", match: :first

    fill_in "City", with: @manger.city
    fill_in "For him", with: @manger.for_him
    fill_in "Name", with: @manger.name
    fill_in "Phone no", with: @manger.phone_NO
    fill_in "To him", with: @manger.to_him
    click_on "Update Manger"

    assert_text "Manger was successfully updated"
    click_on "Back"
  end

  test "destroying a Manger" do
    visit mangers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Manger was successfully destroyed"
  end
end
