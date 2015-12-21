class ProfilesController < ApplicationController

    def new
        # Form to user allow them to fill their own profile.
        # 'build' is rails public method; after we nested profile with users, we are able to use build_profile.
        @user = User.find(params[:user_id]) # This to make sure user who is log-in
        @profile = @user.build_profile 
        @user_email = @user[:email]
    end
    
    def create
        # profile_params is to collect all data on the form.
        @user = User.find(params[:user_id])
        if @user == current_user 
            @profile = @user.build_profile(profile_params)
            if @profile.save # if profile alreade saved,  
                flash[:success] = "Profile Updated!"
                redirect_to user_path(params[:user_id])
            else
                render action: :new # Run new method
                flash[:success] = "Profile Created!"
                redirect_to user_path(params[:user_id])
            end
        else
           flash[:warning] = "You are not in a correct url"
           redirect_to new_user_profile_path(params[:user_id])
        end
    end
    
    private
        def profile_params # white list
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
        end
end