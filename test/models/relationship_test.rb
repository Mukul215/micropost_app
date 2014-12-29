require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: 1, followed_id: 2)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should follow and unfollow a user" do
    mukul  = users(:mukul)
    archer = users(:archer)
    assert_not mukul.following?(archer)
    mukul.follow(archer)
    assert mukul.following?(archer)
    assert archer.followers.include?(mukul)
    mukul.unfollow(archer)
    assert_not mukul.following?(archer) 
  end

end
