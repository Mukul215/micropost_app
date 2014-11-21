require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  # <--- This is how it should be read --->
  # Let’s test the Home page by issuing a GET request to the home action 
  # and then making sure we receive a ‘success’ status code in response.
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home | Ruby on Rails Sample App"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Sample App"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Ruby on Rails Sample App"
  end

end
