module Qc
    class Qc::RejectedPart < ApplicationRecord
        self.table_name ='qc_rejected_parts'
        validates_presence_of :so_num, :reject_tag_num, :weight, :from_tag, :defect, :user_id, :date, :cause 
        
        def self.process_array(array)
            str = ""
            array.each do |x|
                str << "#{x}, "
            end
            return str
        end
    end
end