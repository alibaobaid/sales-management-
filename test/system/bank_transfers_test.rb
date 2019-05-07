require "application_system_test_case"

class BankTransfersTest < ApplicationSystemTestCase
  setup do
    @bank_transfer = bank_transfers(:one)
  end

  test "visiting the index" do
    visit bank_transfers_url
    assert_selector "h1", text: "Bank Transfers"
  end

  test "creating a Bank transfer" do
    visit bank_transfers_url
    click_on "New Bank Transfer"

    fill_in "Date of transfer", with: @bank_transfer.date_of_transfer
    fill_in "Delegates", with: @bank_transfer.delegates_id
    fill_in "Mangers", with: @bank_transfer.mangers_id
    fill_in "Marketers", with: @bank_transfer.marketers_id
    fill_in "Price", with: @bank_transfer.price
    fill_in "Section type", with: @bank_transfer.section_type
    fill_in "Transfer type", with: @bank_transfer.transfer_type
    click_on "Create Bank transfer"

    assert_text "Bank transfer was successfully created"
    click_on "Back"
  end

  test "updating a Bank transfer" do
    visit bank_transfers_url
    click_on "Edit", match: :first

    fill_in "Date of transfer", with: @bank_transfer.date_of_transfer
    fill_in "Delegates", with: @bank_transfer.delegates_id
    fill_in "Mangers", with: @bank_transfer.mangers_id
    fill_in "Marketers", with: @bank_transfer.marketers_id
    fill_in "Price", with: @bank_transfer.price
    fill_in "Section type", with: @bank_transfer.section_type
    fill_in "Transfer type", with: @bank_transfer.transfer_type
    click_on "Update Bank transfer"

    assert_text "Bank transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a Bank transfer" do
    visit bank_transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bank transfer was successfully destroyed"
  end
end
