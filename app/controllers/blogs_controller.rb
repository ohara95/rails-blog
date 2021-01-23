class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end
  
  def new
    @blog = Blog.new
  end

  def create
    Blog.create(blog_params)
  end

  def show
  end
  

  private

  def blog_params
    params.require(:blog).permit(:name, :title, :body)
  end
  
  
end
