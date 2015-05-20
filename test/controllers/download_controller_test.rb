require 'test_helper'

class DownloadControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get srt" do
    get :srt
    assert_response :success
  end

end
