module UsersHelper
    
    def job_title_icon(title)
        def insert_icon(font)
            return "<i class= 'fa #{font}'></i>".html_safe
        end
        if title == "Developer"
            insert_icon('fa-code')
        elsif title == "Entrepreneur"
           insert_icon('fa-rocket')
        elsif title == "Investor"
            insert_icon('fa-money')
        elsif title == "Manager"
            insert_icon('fa-cogs')
        end
    end
end