class ShiftNote < ApplicationRecord

    # Pagination.
    paginates_per 30

    # Associations.
    belongs_to :user, class_name: '::User', optional: true
    has_many :comments, as: :commentable, dependent: :destroy
   
    # Validations
    validates :user_id,    presence: true
    validates :dept,       presence: true
    validates :shift_time, presence: true
    validates :shift_type, presence: true

    # Scoping.
    scope :with_timestamp, ->(timestamp) { where("created_at >= ?", timestamp) unless timestamp.nil? }
    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_dept, ->(dept) { where("dept = ?", dept) unless dept.nil? }
    scope :with_shift_type, ->(type) { where("shift_type = ?", type) unless type.nil? }
    scope :with_shift_time, ->(time) { where("shift_time = ?", time) unless time.nil? }

    scope :sorted_by, ->(sort){
    case sort
    when 'oldest'
        order(updated_at: :asc)
    else
        order(updated_at: :desc)
    end } 

    scope :with_search_term, ->(term){
        unless term.blank?
        search = ApplicationController.helpers.split_search_terms(term)
        conditions = []
        parameters = {}
        term_index = 1
        search[:include].each do |t|
            key = "search#{term_index}"
            conditions << "message LIKE :#{key}"
            parameters[key] = "%#{t}%"
            term_index += 1
        end
        search[:exclude].each do |t|
            key = "search#{term_index}"
            conditions << "message NOT LIKE :#{key}"
            parameters[key] = "%#{t}%"
            term_index += 1
        end
        where(conditions.join(' AND '), parameters.symbolize_keys)
        end}

    # Options for sorting.    
    def self.options_for(field)
        case field
        when "user"
            User.pluck(:first_name, :last_name, :suffix, :id).uniq.map { 
                |f,l,s,i| 
                    ["#{f} #{l} #{s}", i] }
        when "sorted_by"
            [['Newest', 'newest'],
             ['Oldest', 'oldest']]
        when "shift_time"
            [['1', '1'],
             ['2', '2'],
             ['3', '3']]
        when "shift_type"
            [['IT',                   'IT'],
             ['Lab',                 'Lab'],
             ['Maintenance', 'Maintenance'],
             ['Plating',         'Plating'],
             ['QC',                   'QC'],
             ['Shipping',       'Shipping']]
        when "dept"
            [['Dept. 3',      '3'],
             ['Dept. 5',      '5'],
             ['Dept. 6',      '6'],
             ['Dept. 7',      '7'],
             ['Dept. 4',      '4'],
             ['Dept. 8',      '8'],
             ['Dept. 10',    '10'],
             ['Dept. 12',    '12'],
             ['Waste Water', '30']]
        end 
    end 
end
