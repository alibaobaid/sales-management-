require 'test_helper'

class BankTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_transfer = bank_transfers(:one)
  end

  test "should get index" do
    get bank_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_bank_transfer_url
    assert_response :success
  end

  test "should create bank_transfer" do
    assert_difference('BankTransfer.count') do
      post bank_transfers_url, params: { bank_transfer: { date_of_transfer: @bank_transfer.date_of_transfer, delegates_id: @bank_transfer.delegates_id, mangers_id: @bank_transfer.mangers_id, marketers_id: @bank_transfer.marketers_id, price: @bank_transfer.price, section_type: @bank_transfer.section_type, transfer_type: @bank_transfer.transfer_type } }
    end

    assert_redirected_to bank_transfer_url(BankTransfer.last)
  end

  test "should show bank_transfer" do
    get bank_transfer_url(@bank_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_bank_transfer_url(@bank_transfer)
    assert_response :success
  end

  test "should update bank_transfer" do
    patch bank_transfer_url(@bank_transfer), params: { bank_transfer: { date_of_transfer: @bank_transfer.date_of_transfer, delegates_id: @bank_transfer.delegates_id, mangers_id: @bank_transfer.mangers_id, marketers_id: @bank_transfer.marketers_id, price: @bank_transfer.price, section_type: @bank_transfer.section_type, transfer_type: @bank_transfer.transfer_type } }
    assert_redirected_to bank_transfer_url(@bank_transfer)
  end

  test "should destroy bank_transfer" do
    assert_difference('BankTransfer.count', -1) do
      delete bank_transfer_url(@bank_transfer)
    end

    assert_redirected_to bank_transfers_url
  end
end
