require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # Rather than testing if form works by hand
  # we can use this test to make sure form does not take
  # any invalid user information
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", email: "user@invalid", 
                               password:              "foo",
                               password_confirmation: "bar"}
    end
    assert_template 'users/new'
  end

end
