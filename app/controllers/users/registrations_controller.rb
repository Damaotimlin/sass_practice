# This file is to overwrite the defult methods Devise provide
class Users::RegistrationsController < Devise::RegistrationsController
    
    before_filter :select_plan, only: :new # Declare the name :select_plan and only been used while "new" Devises' controller
    
    def create
        super do |resource|
            if params[:plan] # if do have :plan params have been submit with form
                resource.plan_id = params[:plan] # Save the :plan id to resource.plan_id value; plan_id is Users DB table columns; In this case will be 1 or 2
                if resource.plan_id == 2
                    resource.save_with_payment # If this resource comes from plan_id=2, saves by special way
                else
                    resource.save # If plan_id=1, just saves as defult
                end
            end
        end   
    end
    
    private # private is to keep this method only using in this controller
    def select_plan
        unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
            flash[:alert] = "Please select a membership od plans to sign up."
            redirect_to root_path
        end
    end
end