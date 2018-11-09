module Printing
  class PrintJob < ApplicationRecord
    mount_base64_uploader :file, PrintJobUploader, file_name: -> (u) { u.created_at }

    belongs_to :document_type, optional: true
    belongs_to :print_queue, optional: true
    belongs_to :workstation, optional: true
    belongs_to :user, optional: true

    validates_presence_of :file
    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_doc_type, ->(doc_type) { where("document_type_id = ?", doc_type) unless doc_type.nil? }
    scope :with_workstation, ->(workstation) { where("workstation_id = ?", workstation) unless workstation.nil? }
    scope :with_is_complete, ->(is_complete) { where("is_complete = false") unless !is_complete.blank? }

    default_scope { order("created_at DESC") }


    def self.send_print_cmd(print_job)
      if print_job.print_queue_id.blank?
        print_job.update_attribute(:is_complete, false)
      else
        queue = Printing::PrintQueue.find(print_job.print_queue_id)
        cmd = "lpr "
        cmd << queue.printer << " " << queue.options << " "
        cmd << print_job.file.current_path
        print_job.update_attribute(:is_complete,                                     system(cmd))
      end
    end
  
    def self.set_queue(print_job)
      p = print_job
      applicable_rules = []
      Printing::PrintQueueRule.all.each do |r|
        if r.user_id == p.user_id || r.user_id.blank?
          if r.workstation_id == p.workstation_id || r.workstation_id.blank?
            if r.document_type_id == p.document_type_id ||    r.document_type_id.blank?
              applicable_rules << r
            end
          end
        end
      end
      applicable_rules = applicable_rules.sort_by { |x| -x[:weight] }
      
      if applicable_rules.blank?
        p.update_attribute(:print_queue_id, nil)
      else
        p.update_attribute(:print_queue_id, applicable_rules.first.print_queue_id)
      end
    end

    # Parse incoming json into file/options
    def self.parse_data(dat)
      data = {}
      temp = JSON.parse(dat)
      temp.symbolize_keys!
      temp[:file].gsub!(' ', '+')

      data[:file] = temp[:file]
      data[:description] = temp[:description]
      data[:user_id] = User.find_by(username: temp[:user]).id unless User.find_by(username: temp[:user]).blank?
      data[:workstation_id] = Printing::Workstation.find_by(ip_address: temp[:ip_address]).id unless Printing::Workstation.find_by(ip_address: temp[:ip_address]).blank?
      data[:document_type_id] = Printing::DocumentType.find_by(name: temp[:document_type]).id unless Printing::DocumentType.find_by(name: temp[:document_type]).blank?
      return data
    end
  end
end 