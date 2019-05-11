require 'test_helper'

class MangerDiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manger_discount = manger_discounts(:one)
  end

  test "should get index" do
    get manger_discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_manger_discount_url
    assert_response :success
  end

  test "should create manger_discount" do
    assert_difference('MangerDiscount.count') do
      post manger_discounts_url, params: { manger_discount: { Desc: @manger_discount.Desc, manger_id: @manger_discount.manger_id, value: @manger_discount.value } }
    end

    assert_redirected_to manger_discount_url(MangerDiscount.last)
  end

  test "should show manger_discount" do
    get manger_discount_url(@manger_discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_manger_discount_url(@manger_discount)
    assert_response :success
  end

  test "should update manger_discount" do
    patch manger_discount_url(@manger_discount), params: { manger_discount: { Desc: @manger_discount.Desc, manger_id: @manger_discount.manger_id, value: @manger_discount.value } }
    assert_redirected_to manger_discount_url(@manger_discount)
  end

  test "should destroy manger_discount" do
    assert_difference('MangerDiscount.count', -1) do
      delete manger_discount_url(@manger_discount)
    end

    assert_redirected_to manger_discounts_url
  end
end
