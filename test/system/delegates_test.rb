require "application_system_test_case"

class DelegatesTest < ApplicationSystemTestCase
  setup do
    @delegate = delegates(:one)
  end

  test "visiting the index" do
    visit delegates_url
    assert_selector "h1", text: "Delegates"
  end

  test "creating a Delegate" do
    visit delegates_url
    click_on "New Delegate"

    fill_in "Amount of box", with: @delegate.amount_of_box
    fill_in "Amount of gallon", with: @delegate.amount_of_gallon
    fill_in "City", with: @delegate.city
    fill_in "For him", with: @delegate.for_him
    fill_in "Name", with: @delegate.name
    fill_in "Phone no", with: @delegate.phone_NO
    fill_in "To him", with: @delegate.to_him
    click_on "Create Delegate"

    assert_text "Delegate was successfully created"
    click_on "Back"
  end

  test "updating a Delegate" do
    visit delegates_url
    click_on "Edit", match: :first

    fill_in "Amount of box", with: @delegate.amount_of_box
    fill_in "Amount of gallon", with: @delegate.amount_of_gallon
    fill_in "City", with: @delegate.city
    fill_in "For him", with: @delegate.for_him
    fill_in "Name", with: @delegate.name
    fill_in "Phone no", with: @delegate.phone_NO
    fill_in "To him", with: @delegate.to_him
    click_on "Update Delegate"

    assert_text "Delegate was successfully updated"
    click_on "Back"
  end

  test "destroying a Delegate" do
    visit delegates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Delegate was successfully destroyed"
  end
end
