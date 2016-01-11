class ProfilesController < ApplicationController

    before_action :authenticate_user!, only: [:new, :edit] # before_action<Rails, before below action; :authenticate_user<Stripe; only while new and edit action
    before_action :only_current_user
    
    def new
        # Form to user allow them to fill their own profile.
        # 'build' is rails public method; after we nested profile with users, we are able to use build_profile.
        @user = User.find(params[:user_id]) # This to make sure user who is log-in
        # @profile = @user.build_profile # This command will clean up profile data every time while user link to /users/:user_id/profile/new
        @profile = Profile.new # This is not, it only reset Profile after submit
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
    
    def edit 
        @user = User.find(params[:user_id])
        @profile = @user.profile # pull out the user profilegi
    end
    
    def update
       @user = User.find(params[:user_id])
       @profile = @user.profile
       if @profile.update_attributes(profile_params) # update_attributes is a rails method. It will save any changed to DB
       flash[:success] = "Profile Updated!"
       redirect_to user_path(params[:user_id])
        else
            render action: :edit # if save fail, stay in edit page
        end
    end
    
    private
        def profile_params # white list
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
        end
        
        def only_current_user
            @user = User.find(params[:user_id])
            redirect_to(root_url) unless @user == current_user
        end
end