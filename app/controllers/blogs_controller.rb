class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :edit_confirm]
  before_action :login, only: [:new, :edit, :show, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.create(blog_params)
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache! params[:cache][:image]
    
    respond_to do |format|
      if @blog.save
        MakeblogMailer.makeblog_mail(@blog).deliver
        format.html { redirect_to blogs_path, notice: 'Blog was successfully created.' }
        format.json { render :index, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        MakeblogMailer.makeblog_mail(@blog).deliver  
        format.html { redirect_to blogs_path, notice: 'Blog was successfully updated.' }
        format.json { render :index, status: :created, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end


  def confirm
    @blog = Blog.new(blog_params)
    render :new  if @blog.invalid?
  end
  
  def edit_confirm
    @blog = Blog.new(blog_params)
    @blog.id = params[:id]
    render :edit  if @blog.invalid?
  end

    
  private
  def blog_params
    params.require(:blog).permit(:title,:content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def login
    if not logged_in?
      redirect_to new_session_path
    end
  end

end
