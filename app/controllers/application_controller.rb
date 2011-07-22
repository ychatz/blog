class ApplicationController < ActionController::Base
  before_filter :load_footer

  helper_method :admin?

  protect_from_forgery

  private
  def load_footer
    @archive = Post.archive
    @featured = Post.featured
    @recent = Post.recent(5)

    @info = YAML.load_file(File.join(Rails.root, "config", "layout.yml"))
  end

  def check_permissions
      redirect_to posts_url unless admin?
  end

  def admin?
    session.include?("admin")
  end
end
