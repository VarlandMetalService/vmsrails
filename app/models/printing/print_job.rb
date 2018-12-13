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
    scope :with_description, -> (description) { where("description LIKE ?", '%' + description + '%')}

    default_scope { order("created_at DESC") }

    paginates_per 25


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
      groups = Printing::WorkstationGroup.joins(:workstations).where('workstations.id = ?', print_job.workstation_id).map { |x| x.id }
      rules = Printing::PrintQueueRule.where(:user_id => print_job.user_id).or(Printing::PrintQueueRule.where(:document_type_id => print_job.document_type_id)).or(Printing::PrintQueueRule.where('workstation_group_id = ?', groups))

      x = rules.map { |x| [x.print_queue_id, x.weight] }.sort_by { |y| -y[1]}.first

      if rules.blank?
        print_job.update_attribute(:print_queue_id, nil)
      else
        print_job.update_attribute(:print_queue_id, x[0])
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

    def self.filter_form_lists
      lists = []
      lists[0] = Printing::DocumentType.pluck(:name, :id).uniq.sort
      lists[1] = Printing::Workstation.pluck(:name, :id).uniq.sort
      lists[2] = User.pluck(:nickname, :last_name, :id).uniq.map { |f,l,i| ["#{f} #{l}", i]}.uniq
      return lists
    end
  end
end 