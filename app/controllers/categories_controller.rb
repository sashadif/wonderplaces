class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end
  

  def new
    @category = Category.new
    render :edit
  end
  
  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to '/categories'
    else
      render :edit
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to '/categories'
    else
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to '/categories'
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end
