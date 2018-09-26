module Qc
    class Qc::RejectedPart < ApplicationRecord
        self.table_name ='qc_rejected_parts'
        validates_presence_of :so_num, message: 'bleh', as: 'Shop Order Number'
        validates_presence_of :reject_tag_num, :weight, :from_tag, :defect, :user_id, :date, :cause 
        
    end
end