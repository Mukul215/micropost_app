require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  # Creating a instance variable to DRY up code for base title
  def setup
    @base_title = "Ruby on Rails Sample App"
  end

  # <--- This is how it should be read --->
  # Let’s test the Home page by issuing a GET request to the home action 
  # and then making sure we receive a ‘success’ status code in response.
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
