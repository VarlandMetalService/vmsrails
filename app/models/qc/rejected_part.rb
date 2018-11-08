module Qc
    class Qc::RejectedPart < ApplicationRecord
        self.table_name ='qc_rejected_parts'
        validates_presence_of :so_num, :weight, :defect, :user_id, :date, :cause, :reject_tag_num, :from_tag
        
        def self.process_array(array)
            str = ""
            array.each do |x|
                str << "#{x}, "
            end
            return str
        end
    end
end