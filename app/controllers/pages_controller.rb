class PagesController < ApplicationController
    def home
        @basic_plan = Plan.find(1)
        @pro_plan = Plan.find(2)
        
        if user_signed_in?
            @user = User.find(current_user)
        end
    end
    
    def about
        
    end
end
