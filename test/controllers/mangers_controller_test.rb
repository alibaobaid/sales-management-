require 'test_helper'

class MangersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manger = mangers(:one)
  end

  test "should get index" do
    get mangers_url
    assert_response :success
  end

  test "should get new" do
    get new_manger_url
    assert_response :success
  end

  test "should create manger" do
    assert_difference('Manger.count') do
      post mangers_url, params: { manger: { city: @manger.city, for_him: @manger.for_him, name: @manger.name, phone_NO: @manger.phone_NO, to_him: @manger.to_him } }
    end

    assert_redirected_to manger_url(Manger.last)
  end

  test "should show manger" do
    get manger_url(@manger)
    assert_response :success
  end

  test "should get edit" do
    get edit_manger_url(@manger)
    assert_response :success
  end

  test "should update manger" do
    patch manger_url(@manger), params: { manger: { city: @manger.city, for_him: @manger.for_him, name: @manger.name, phone_NO: @manger.phone_NO, to_him: @manger.to_him } }
    assert_redirected_to manger_url(@manger)
  end

  test "should destroy manger" do
    assert_difference('Manger.count', -1) do
      delete manger_url(@manger)
    end

    assert_redirected_to mangers_url
  end
end
