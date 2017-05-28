class PlacesController < ApplicationController
  def index
    if params[:term].present?
      @places = Place.filter_with(params[:term]) 
    else
      @places = Place.all
    end
   #respond_to do |format|
     # format.html {render 'index.html.haml'}
     # format.json {render 'index.json.builder'}
    #end
  end
  
  def show
    @place = Place.find(params[:id]) 
  end
  
  def new
      @place = Place.new
      render 'edit'
  end

  def create
      @place = Place.create(place_params)
      if @place.save
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
    if @place.update(place_params)
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
  
  
  private
  
  def place_params
      params.require(:place).permit(:name,:category,:address,:about,:lat,:lng,{avatars: []})
  end
end
