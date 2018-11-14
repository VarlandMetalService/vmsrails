require 'rails_helper'

RSpec.describe User do
  subject(:user) { described_class.new(:id => blah, 
    :employee_number => "xyz", 
           :username => "xyz", 
         :first_name => "xyz", 
     :middle_initial => "xyz", 
          :last_name => "xyz", 
             :suffix => "xyz", 
           :nickname => "xyz", 
           :initials => "xyz", 
              :email => "xyz", 
    :avatar_bg_color => "xyz", 
  :avatar_text_color => "xyz", 
           :is_admin => "xyz", 
        :is_disabled => "xyz", 
     :remeber_digest => "xyz", 
         :created_at => "xyz", 
         :updated_at => "xyz", 
            :address => "xyz", 
               :city => "xyz", 
              :state => "xyz", 
           :zip_code => "xyz", 
       :phone_number => "xyz", 
                :pin => "xyz", 
       :is_clockedin => "xyz" )}
end