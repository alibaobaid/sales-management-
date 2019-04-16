require 'test_helper'

class MarketersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketer = marketers(:one)
  end

  test "should get index" do
    get marketers_url
    assert_response :success
  end

  test "should get new" do
    get new_marketer_url
    assert_response :success
  end

  test "should create marketer" do
    assert_difference('Marketer.count') do
      post marketers_url, params: { marketer: { city: @marketer.city, for_him: @marketer.for_him, name: @marketer.name, phone_NO: @marketer.phone_NO, to_him: @marketer.to_him } }
    end

    assert_redirected_to marketer_url(Marketer.last)
  end

  test "should show marketer" do
    get marketer_url(@marketer)
    assert_response :success
  end

  test "should get edit" do
    get edit_marketer_url(@marketer)
    assert_response :success
  end

  test "should update marketer" do
    patch marketer_url(@marketer), params: { marketer: { city: @marketer.city, for_him: @marketer.for_him, name: @marketer.name, phone_NO: @marketer.phone_NO, to_him: @marketer.to_him } }
    assert_redirected_to marketer_url(@marketer)
  end

  test "should destroy marketer" do
    assert_difference('Marketer.count', -1) do
      delete marketer_url(@marketer)
    end

    assert_redirected_to marketers_url
  end
end
