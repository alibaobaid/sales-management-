require 'test_helper'

class DelegatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delegate = delegates(:one)
  end

  test "should get index" do
    get delegates_url
    assert_response :success
  end

  test "should get new" do
    get new_delegate_url
    assert_response :success
  end

  test "should create delegate" do
    assert_difference('Delegate.count') do
      post delegates_url, params: { delegate: { amount_of_box: @delegate.amount_of_box, amount_of_gallon: @delegate.amount_of_gallon, city: @delegate.city, for_him: @delegate.for_him, name: @delegate.name, phone_NO: @delegate.phone_NO, to_him: @delegate.to_him } }
    end

    assert_redirected_to delegate_url(Delegate.last)
  end

  test "should show delegate" do
    get delegate_url(@delegate)
    assert_response :success
  end

  test "should get edit" do
    get edit_delegate_url(@delegate)
    assert_response :success
  end

  test "should update delegate" do
    patch delegate_url(@delegate), params: { delegate: { amount_of_box: @delegate.amount_of_box, amount_of_gallon: @delegate.amount_of_gallon, city: @delegate.city, for_him: @delegate.for_him, name: @delegate.name, phone_NO: @delegate.phone_NO, to_him: @delegate.to_him } }
    assert_redirected_to delegate_url(@delegate)
  end

  test "should destroy delegate" do
    assert_difference('Delegate.count', -1) do
      delete delegate_url(@delegate)
    end

    assert_redirected_to delegates_url
  end
end
