class StayedCountriesController < ApplicationController
    before_action :set_user, only: [:edit, :update]

    def new
        @stayed_country = StayedCountry.new
    end

    def create 
        @stayed_country = StayedCountry.create(stayed_country_params)
        if @stayed_country.save
            redirect_to user_path(current_user.id)
        else
            render :new
        end
    end

    def edit
    end

    def update
        @stayed_country.update(stayed_country_params)
        if @stayed_country.save
            redirect_to user_path(current_user.id)
        else
            render :edit
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end
    

    def stayed_country_params
        params.require(:stayed_country).permit(
            :country_id
        ).merge(user_id: current_user.id, tag_list: params[:stayed_country][:tag])
    end
end
