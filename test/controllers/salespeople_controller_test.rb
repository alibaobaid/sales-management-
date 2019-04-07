require 'test_helper'

class SalespeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salesperson = salespeople(:one)
  end

  test "should get index" do
    get salespeople_url
    assert_response :success
  end

  test "should get new" do
    get new_salesperson_url
    assert_response :success
  end

  test "should create salesperson" do
    assert_difference('Salesperson.count') do
      post salespeople_url, params: { salesperson: { amount_of_box: @salesperson.amount_of_box, amount_of_gallon: @salesperson.amount_of_gallon, city: @salesperson.city, for_him: @salesperson.for_him, name: @salesperson.name, phone_NO: @salesperson.phone_NO, to_him: @salesperson.to_him } }
    end

    assert_redirected_to salesperson_url(Salesperson.last)
  end

  test "should show salesperson" do
    get salesperson_url(@salesperson)
    assert_response :success
  end

  test "should get edit" do
    get edit_salesperson_url(@salesperson)
    assert_response :success
  end

  test "should update salesperson" do
    patch salesperson_url(@salesperson), params: { salesperson: { amount_of_box: @salesperson.amount_of_box, amount_of_gallon: @salesperson.amount_of_gallon, city: @salesperson.city, for_him: @salesperson.for_him, name: @salesperson.name, phone_NO: @salesperson.phone_NO, to_him: @salesperson.to_him } }
    assert_redirected_to salesperson_url(@salesperson)
  end

  test "should destroy salesperson" do
    assert_difference('Salesperson.count', -1) do
      delete salesperson_url(@salesperson)
    end

    assert_redirected_to salespeople_url
  end
end
