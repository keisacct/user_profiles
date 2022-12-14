class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show, :edit, :update]
    before_action :move_to_curernt_page, only: [:edit, :update]
    before_action :set_user, only: [:show, :edit, :update]
    before_action :set_stayed_country, only: :show
    
    def show
        @country_tags = @user.tag_counts_on(:countries)
    end

    def edit
    end

    def update
        @user.update(user_params)
        if @user.save
            redirect_to user_path(current_user.id)
        else
            render :edit
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def set_stayed_country
        set_user
        @stayed_country = StayedCountry.find_by(user_id: @user.id)
    end

    def move_to_curernt_page
        set_user
        if @user.id != current_user.id
            redirect_to action: :show
        end
    end

    def user_params
        params.require(:user).permit(
            :user_icon, :username, :description, 
            :twitter_url, :linkedin_url, :facebook_url, 
            :blog_url, :tag_list
        )
    end
end  