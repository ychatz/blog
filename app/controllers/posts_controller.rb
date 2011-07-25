class PostsController < ApplicationController
  before_filter :check_permissions, :only => [:create, :update, :disable, :restore, :new, :edit]
  before_filter :retrieve_post, :only => [:show, :edit, :update, :disable, :restore]

  def index
    @posts = Post.recent(5)

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def archive
    @posts = Post.all_on_month(params[:month], params[:year])
    render :index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
  end

  def disable
    @post.delete

    redirect_to(posts_url)
  end

  def restore
    @post.restore

    redirect_to(posts_url)
  end

  private

  def retrieve_post
    if admin?
      @post = Post.find_by_id(params[:id])
    else
      @post = Post.active.find_by_id(params[:id])
    end

    redirect_to(posts_url) if @post.nil?
  end
end
