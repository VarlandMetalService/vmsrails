module Thickness
  class Thickness::Block < ActiveRecord::Base

    # Associations.
    has_many :checks, class_name: 'Thickness::Check', dependent: :destroy
    belongs_to :user, class_name: '::User', foreign_key: "user_id", optional: true
    accepts_nested_attributes_for :checks
    self.table_name = "thickness_blocks"

    # Scoping.

    # has_scope :with_timestamp,    only: :index
    # has_scope :with_directory,    only: :index
    # has_scope :with_product,      only: :index
    # has_scope :with_application,  only: :index
    # has_scope :with_user,         only: :index
    # has_scope :with_customer,     only: :index
    # has_scope :with_process,      only: :index
    # has_scope :with_part,         only: :index
    # has_scope :with_rework,       only: :index
    # has_scope :with_search_term,  only: :index

    scope :with_timestamp, ->(timestamp) { joins(:checks).where(" thickness_checks.check_timestamp >= ?", timestamp) unless timestamp.nil? }
    scope :with_directory, ->(directory) { where("directory = ?", directory)unless directory.nil? }
    scope :with_product, ->(product) { where("product = ?", product) unless product.nil? }
    scope :with_application, ->(application) { where("application = ?", application) unless application.nil? }
    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_customer, ->(customer) { where("customer = ?", customer) unless customer.nil? }
    scope :with_process, ->(process) { where("process = ?", process) unless process.nil? }
    scope :with_part, ->(part) { where("part = ?", part) unless part.nil? }
    scope :with_rework, ->(rework) { where("is_rework = ?", rework) unless rework.nil? }


    # Pagination.
    paginates_per 20
  end
end