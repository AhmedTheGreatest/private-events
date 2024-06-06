require "test_helper"

class EventAttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get event_attendances_new_url
    assert_response :success
  end

  test "should get create" do
    get event_attendances_create_url
    assert_response :success
  end
end
