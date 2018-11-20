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

        def increment_reject_tag_count
            url = "http://as400railsapi.varland.com/v1/increment_reject_tag_count?shop_order=#{self.so_num}"
            uri = URI(url)
            response = Net::HTTP.get(uri)
            response = JSON.parse(response)
            puts response["result"]
            if (response["result"] == false)
                puts "yahtzee"
                return false
            else
                return true
            end
        end
    end
end