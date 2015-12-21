class ProfilesController < ApplicationController
    def new
        # Form to user allow them to fill their own profile.
        @user = User.find(params[:user_id]) # This to make sure user who is log-in
        @profile = @user.build_profile # 'build' is rails public method; after we nested profile with users, we are able to use build_profile.
    end
    
end