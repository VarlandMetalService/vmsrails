class SaltSprayTest < ApplicationRecord
  acts_as_paranoid
  serialize :process, Array
  # Associations.
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :salt_spray_test_checks, class_name: "SaltSprayTestCheck", dependent: :destroy 
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  accepts_nested_attributes_for :salt_spray_test_checks

  # Validations.
  validates_presence_of :so_num, :load_num

  scope :with_process_code, ->(process_code) { where("process_code = ?", process_code) unless process_code.nil? }

  def self.options_for_process_code
    [["BR - Brass",                              'BR'],
     ["BT - Bright Acid Tin",                    'BT'],
     ["CD - Cadmium",                            'CD'],
     ["CL - Clean",                              'CL'],
     ["CU - Copper",                             'CU'],
     ["HN - Zinc-Nickel, High Nickel",           'HN'],
     ["HP - High Phos Electroless Nickel",       'HP'],
     ["LN - Zing-Nickel, Low Nickel",            'LN'],
     ["MP - Mid Phos Electroless Nickel",        'MP'],
     ["MT - Matte Acid Tin",                     'MT'],
     ["NI - Nickel",                             'NI'],
     ["PA - Passivate",                          'PA'],
     ["SBR - Strip + Brass",                    'SBR'],
     ["SBT - Strip + Bright Acid Tin",          'SBT'],
     ["SCD - Strip + Cadmium",                  'SCD'],
     ["SCU - Strip + Copper",                   'SCU'],
     ["SHN - Strip + Zinc-Nickel, High Nickel", 'SHN'],
     ["SLN - Strip + Zinc-Nickel, Low Nickel",  'SLN'],
     ["SMT - Strip + Matte Acid Tin",           'SMT'],
     ["SNI - Strip + Nickel",                   'SNI'],
     ["STZ - Strip + Tin-Zinc",                 'STZ'],
     ["SZF - Strip + Zinc-Iron",                'SZF'],
     ["SZN - Strip + Zinc",                     'SZN'],
     ["TZ - Tin-Zinc",                           'TZ'],
     ["ZF - Zinc-Iron",                          'ZF'],
     ["ZN - Zinc",                               'ZN']]
  end

  def self.not_recently
    preload(:salt_spray_test_checks).select { |s| s.salt_spray_test_checks.all? {|c| ((Time.now - c.date) > 4.hours) }}
  end
end