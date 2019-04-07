require "application_system_test_case"

class SalespeopleTest < ApplicationSystemTestCase
  setup do
    @salesperson = salespeople(:one)
  end

  test "visiting the index" do
    visit salespeople_url
    assert_selector "h1", text: "Salespeople"
  end

  test "creating a Salesperson" do
    visit salespeople_url
    click_on "New Salesperson"

    fill_in "Amount of box", with: @salesperson.amount_of_box
    fill_in "Amount of gallon", with: @salesperson.amount_of_gallon
    fill_in "City", with: @salesperson.city
    fill_in "For him", with: @salesperson.for_him
    fill_in "Name", with: @salesperson.name
    fill_in "Phone no", with: @salesperson.phone_NO
    fill_in "To him", with: @salesperson.to_him
    click_on "Create Salesperson"

    assert_text "Salesperson was successfully created"
    click_on "Back"
  end

  test "updating a Salesperson" do
    visit salespeople_url
    click_on "Edit", match: :first

    fill_in "Amount of box", with: @salesperson.amount_of_box
    fill_in "Amount of gallon", with: @salesperson.amount_of_gallon
    fill_in "City", with: @salesperson.city
    fill_in "For him", with: @salesperson.for_him
    fill_in "Name", with: @salesperson.name
    fill_in "Phone no", with: @salesperson.phone_NO
    fill_in "To him", with: @salesperson.to_him
    click_on "Update Salesperson"

    assert_text "Salesperson was successfully updated"
    click_on "Back"
  end

  test "destroying a Salesperson" do
    visit salespeople_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Salesperson was successfully destroyed"
  end
end
