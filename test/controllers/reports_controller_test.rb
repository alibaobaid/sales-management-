require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get sales_report" do
    get reports_sales_report_url
    assert_response :success
  end

end
