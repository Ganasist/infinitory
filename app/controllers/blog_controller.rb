class BlogController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: :index
  before_action :authenticate_super_admin, except: [:index, :show]

  def index
    @blogs = Blog.all.page(params[:page]).per(3).order('created_at DESC')
    @blog_days = @blogs.group_by { |t|  t.created_at.beginning_of_day }
  end

  def new
    @blog = Blog.new
  end

  def show
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_index_path, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_index_path, notice: 'Entry was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @blog }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blog_index_path, notice: 'Entry was deleted' }
      format.json { head :no_content }
    end
  end

  private
    def authenticate_super_admin
      unless user_signed_in? && current_user.super_admin?
        redirect_to root_path
        flash[:alert] = "You cannot access that page"
      end
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :subtitle, :entry, :url)
    end
end
