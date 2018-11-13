module Thickness
  class Thickness::Block < ActiveRecord::Base

    # Associations.
    has_many :checks, class_name: 'Thickness::Check', dependent: :destroy
    belongs_to :user, class_name: '::User', foreign_key: "user_id", optional: true
    accepts_nested_attributes_for :checks
    self.table_name = "thickness_blocks"

    # Scoping.
    scope :with_timestamp, ->(timestamp) { joins(:checks).where(" thickness_checks.check_timestamp >= ?", timestamp) unless timestamp.nil? }
    scope :with_directory, ->(directory) { where("directory = ?", directory)unless directory.nil? }
    scope :with_product, ->(product) { where("product = ?", product) unless product.nil? }
    scope :with_application, ->(application) { where("application = ?", application) unless application.nil? }
    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_customer, ->(customer) { where("customer = ?", customer) unless customer.nil? }
    scope :with_process, ->(process) { where("process = ?", process) unless process.nil? }
    scope :with_part, ->(part) { where("part = ?", part) unless part.nil? }
    scope :with_rework, ->(rework) { where("is_rework = ?", rework) unless rework.nil? }
    scope :with_so_num, ->(so_num) { where("so_num = ?", so_num) unless so_num.nil? }

    # Pagination.
    paginates_per 30
    
    # Model functions
    def self.filter_form_lists
      lists = Thickness::Block.pluck(:so_num, :directory, :product, :application, :customer, :process, :part).transpose
      lists << User.pluck(:first_name, :last_name, :suffix, :id).uniq.map { |f,l,s,i| ["#{f} #{l} #{s}", i]}
      return lists
    end

    def self.remove_blank_checks(block)
      block.checks.each do |c|
        if c.thickness.blank?
          c.destroy
        end
      end
    end  
  end
end