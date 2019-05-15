require 'test_helper'

class ProductDiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_discount = product_discounts(:one)
  end

  test "should get index" do
    get product_discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_product_discount_url
    assert_response :success
  end

  test "should create product_discount" do
    assert_difference('ProductDiscount.count') do
      post product_discounts_url, params: { product_discount: { amount: @product_discount.amount, delegate_id: @product_discount.delegate_id, discount_date: @product_discount.discount_date, product_type: @product_discount.product_type, reason: @product_discount.reason } }
    end

    assert_redirected_to product_discount_url(ProductDiscount.last)
  end

  test "should show product_discount" do
    get product_discount_url(@product_discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_discount_url(@product_discount)
    assert_response :success
  end

  test "should update product_discount" do
    patch product_discount_url(@product_discount), params: { product_discount: { amount: @product_discount.amount, delegate_id: @product_discount.delegate_id, discount_date: @product_discount.discount_date, product_type: @product_discount.product_type, reason: @product_discount.reason } }
    assert_redirected_to product_discount_url(@product_discount)
  end

  test "should destroy product_discount" do
    assert_difference('ProductDiscount.count', -1) do
      delete product_discount_url(@product_discount)
    end

    assert_redirected_to product_discounts_url
  end
end
