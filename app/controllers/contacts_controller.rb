class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            flash[:success] = "Message sent successfully." # Rails flash notice
            redirect_to new_contact_path #, notice: "Message sent."
        else
            flash[:warning] = "ERROR: Massage fail to sent; please be sure you type in your name and email."
            redirect_to new_contact_path #, notice: "ERROR: Message don\'t sent"
        end
    end
    
    
    private
    
    # 'white list' which Rails-4v required for security reason
    def contact_params
       params.require(:contact).permit(:name, :email, :comments) 
    end
    
end