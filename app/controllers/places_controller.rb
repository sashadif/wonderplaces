class PlacesController < ApplicationController
  
  def index
      @places = Place.all
  end
  
  def show
     @place = Place.find(params[:id]) 
  end
  
  def new
    if admin_signed_in?
      @place = Place.new
      render 'edit'
    end
  end

  def create
    @place = Place.create(place_params)
    if @place.save
      Category.find(@place.category_id).places << @place 
      redirect_to place_url(@place)
    else
      render 'edit'
    end
  end
  
  def edit
    @place = Place.find(params[:id])
  end
  
  def update
    @place = Place.find(params[:id])
    @category_id_old = @place.category_id
    
    if @place.update(place_params)
 
 #     if @category_id_old!=0 && !Place.all.find(@category_id_old)
 #      Category.find(Place.find(@category_id_old).category_id).places.delete(@place)
   #     Category.find(@place.category_id).places << @place 
  #    else
        Category.find(@place.category_id).places << @place
   #   end
      redirect_to place_url(@place)
    else
      render :edit
    end
  end
  
  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to '/places'
  end
  
  def add_to
    @place = Place.find(params[:id])
    @user_id = current_user
    @user = User.find(current_user)
    @user.places << @place
    @user.save!
    redirect_to place_path(@place)
  end
  
  private
  
  def place_params
      params.require(:place).permit(:name,:category_id,:address,:about,:lat,:lng,{avatars: []})
  end
end
