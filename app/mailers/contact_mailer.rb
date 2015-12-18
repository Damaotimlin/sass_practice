class ContactMailer < ActionMailer::Base
    
    default to: 'damao.republic@gmail.com'
    
    def contact_sent_email(name, email, body)
        
        @name = name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Contact Form Messagr')
    end
end