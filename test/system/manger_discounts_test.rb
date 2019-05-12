require "application_system_test_case"

class MangerDiscountsTest < ApplicationSystemTestCase
  setup do
    @manger_discount = manger_discounts(:one)
  end

  test "visiting the index" do
    visit manger_discounts_url
    assert_selector "h1", text: "Manger Discounts"
  end

  test "creating a Manger discount" do
    visit manger_discounts_url
    click_on "New Manger Discount"

    fill_in "Desc", with: @manger_discount.Desc
    fill_in "Manger", with: @manger_discount.manger_id
    fill_in "Value", with: @manger_discount.value
    click_on "Create Manger discount"

    assert_text "Manger discount was successfully created"
    click_on "Back"
  end

  test "updating a Manger discount" do
    visit manger_discounts_url
    click_on "Edit", match: :first

    fill_in "Desc", with: @manger_discount.Desc
    fill_in "Manger", with: @manger_discount.manger_id
    fill_in "Value", with: @manger_discount.value
    click_on "Update Manger discount"

    assert_text "Manger discount was successfully updated"
    click_on "Back"
  end

  test "destroying a Manger discount" do
    visit manger_discounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Manger discount was successfully destroyed"
  end
end
