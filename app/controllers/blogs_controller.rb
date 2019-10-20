class BlogsController < ApplicationController
  def index
  end
  
  def show
    render params[:slug] 
  end
end
