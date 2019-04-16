require "application_system_test_case"

class AssistantsTest < ApplicationSystemTestCase
  setup do
    @assistant = assistants(:one)
  end

  test "visiting the index" do
    visit assistants_url
    assert_selector "h1", text: "Assistants"
  end

  test "creating a Assistant" do
    visit assistants_url
    click_on "New Assistant"

    fill_in "City", with: @assistant.city
    fill_in "For him", with: @assistant.for_him
    fill_in "Name", with: @assistant.name
    fill_in "Phone no", with: @assistant.phone_NO
    fill_in "To him", with: @assistant.to_him
    click_on "Create Assistant"

    assert_text "Assistant was successfully created"
    click_on "Back"
  end

  test "updating a Assistant" do
    visit assistants_url
    click_on "Edit", match: :first

    fill_in "City", with: @assistant.city
    fill_in "For him", with: @assistant.for_him
    fill_in "Name", with: @assistant.name
    fill_in "Phone no", with: @assistant.phone_NO
    fill_in "To him", with: @assistant.to_him
    click_on "Update Assistant"

    assert_text "Assistant was successfully updated"
    click_on "Back"
  end

  test "destroying a Assistant" do
    visit assistants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assistant was successfully destroyed"
  end
end
