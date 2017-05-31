class UsersController < ApplicationController
    
    def show
        @user = User.find(params[:id])
        @places = Place.all
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @place = Place.find(params[:id])
        @user.places.delete(@place)
        redirect_to '/show.html.haml'
    end

    def index 
        @user = Users.all
    end

end
