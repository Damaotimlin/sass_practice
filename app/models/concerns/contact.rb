class Contact < ActiveRecord::Base
    # To avoid customer sent a empty form
    validates :name, presence: true
    validates :email, presence: true
end