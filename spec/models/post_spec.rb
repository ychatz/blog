require 'spec_helper'

describe Post do
  it "should not return archived posts" do
    post = Factory(:post, :created_at => Date.new(2011, 07, 20))
    Post.all_on_month("07", "2011").should include(post)
  end

  it "should not return deleted posts in archive" do
    post = Factory(:post, :deleted => true, :created_at => Date.new(2011, 07, 20))
    Post.all_on_month("07", "2011").should_not include(post)
  end

  it "should delete posts" do
    post = Factory(:post)
    Post.active.should include(post)
    post.delete
    Post.active.should_not include(post)
  end

  it "should restore posts" do
    post = Factory(:post, :deleted => true)
    Post.active.should_not include(post)
    post.restore
    Post.active.should include(post)
  end

  it "should show recent posts" do
    post = Factory(:post, :created_at => Date.new(2011, 07, 20))
    post2 = Factory(:post, :created_at => Date.new(2011, 07, 21))
    post3 = Factory(:post, :created_at => Date.new(2011, 07, 22))

    Post.recent(2).should include(post2, post3)
    Post.recent(2).should_not include(post)
  end

  it "should include featured posts in the featured list" do
    featured_post = Factory(:post, :featured => true)
    Post.featured.should include(featured_post)
  end

  it "should not include unfeatured posts in the featured list" do
    unfeatured_post = Factory(:post, :featured => false)
    Post.featured.should_not include(unfeatured_post)
  end
end
