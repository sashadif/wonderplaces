class HomeController < ApplicationController
    def index
        @places = Place.filter_with_params(params[:term]) if params[:term].present?
        respond_to do |format|
            format.html {render 'index.html.haml'}
            format.json {render 'index.json.builder'}
        end
    end
    
    def about; end

    def how_it_works; end

    def faq; end
end
