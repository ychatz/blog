require 'util'

class SessionsController < ApplicationController
  def new
  end

  def destroy
    session.delete(:admin) if admin?
    redirect_to :posts
  end

  def create
    if ( params[:password].to_s == Util.load_config("admin", :key => :password) ) then
      session[:admin] = true
      redirect_to :new_post
    else
      redirect_to :posts
    end
  end
end
