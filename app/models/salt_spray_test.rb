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
     ["SBR - Strip + Brass",                    'SBR'],

     ["BT - Bright Acid Tin",                    'BT'],
     ["SBT - Strip + Bright Acid Tin",          'SBT'],

     ["CD - Cadmium",                            'CD'],
     ["SCD - Strip + Cadmium",                  'SCD'],

     ["CU - Copper",                             'CU'],
     ["SCU - Strip + Copper",                   'SCU'],

     ["HN - Zinc-Nickel, High Nickel",           'HN'],
     ["LN - Zing-Nickel, Low Nickel",            'LN'],
     ["SHN - Strip + Zinc-Nickel, High Nickel", 'SHN'],
     ["SLN - Strip + Zinc-Nickel, Low Nickel",  'SLN'],

     ["MP - Mid Phos Electroless Nickel",        'MP'],
     ["PA - Passivate",                          'PA'],
     ["HP - High Phos Electroless Nickel",       'HP'],
     ["CL - Clean",                              'CL'],

     ["MT - Matte Acid Tin",                     'MT'],
     ["SMT - Strip + Matte Acid Tin",           'SMT'],

     ["NI - Nickel",                             'NI'],
     ["SNI - Strip + Nickel",                   'SNI'],

     ["TZ - Tin-Zinc",                           'TZ'],
     ["STZ - Strip + Tin-Zinc",                 'STZ'],

     ["ZF - Zinc-Iron",                          'ZF'],
     ["SZF - Strip + Zinc-Iron",                'SZF'],

     ["ZN - Zinc",                               'ZN'],
     ["SZN - Strip + Zinc",                     'SZN']]
  end

  def self.not_recently
    preload(:salt_spray_test_checks).select { |s| s.salt_spray_test_checks.all? {|c| ((Time.now - c.date) > 4.hours) }}
  end
end