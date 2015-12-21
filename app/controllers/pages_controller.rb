class PagesController < ApplicationController
    def home
        @basic_plan = Plan.find(1)
        @pro_plan = Plan.find(2)
        if user_signed_in?
            @user = User.find(current_user)
        end
        
        if current_user
            @rand_user_id = check_profile_id(rand(1..User.all.length))
        else
            @rand_user_id = nil
        end
    end
    
    def about
        
    end
    
    private
    def check_profile_id(n)
        u = User.find(n)
        if u.profile
            if u.profile.first_name != nil && u.profile.first_name != '' && u != User.find(current_user)
                @rand_user = User.find(u)
            else
                 @rand_user_id = check_profile_id(rand(1..User.all.length))
            end
        else 
             @rand_user_id = check_profile_id(rand(1..User.all.length))
        end
    end
    
end
