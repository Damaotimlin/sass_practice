class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  attr_accessor :stripe_card_token # To allow to use hidden, stripe_card_token, field we set ::_pro_form_htnl
  
  def save_with_payment
    if valid? # We did added some validation to make sure user filled in properly ::contact.rb
      # After Stripe get this info, Stripe will do the charging, this method comes from Stripe gem
      # Stripe will return an id after charging
      customer = Stripe::Customer.create(description: email, plan: plan_id, source: stripe_card_token) # Stripe had upgrade their API from card: -> source:
      # Set a property to the user after received the id Stripe returned(stripe will return customer hash)
      # 'self' means the target of this function, in this case is User, and we set a new atribute stripe_customer_token to User. 
      self.stripe_customer_token = customer.id # Setting stripe_customer_token to Stripe::customer.id 
      save!
    end
    
  end
  
end
