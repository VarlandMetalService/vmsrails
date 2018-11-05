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

  scope :with_process_code, ->(process_code) { where("process_code in #{process_group(process_code)}") unless process_code.nil? }

  def self.process_group(pc)
    return case pc
      when 'PA'  then "('PA')"

      when 'CL'  then "('CL')"

      when 'BR'  then "('BR', 'SBR')"
      when 'SBR' then "('BR', 'SBR')"

      when 'BT'  then "('BT', 'SBT')"
      when 'SBT' then "('BT', 'SBT')"

      when 'CD'  then "('CD', 'SCD')"
      when 'SCD' then "('CD', 'SCD')"

      when 'CU'  then "('CU', 'SCU')"
      when 'SCU' then "('CU', 'SCU')"

      when 'MT'  then "('MT', 'SMT')"
      when 'SMT' then "('MT', 'SMT')"

      when 'NI'  then "('NI', 'SNI')"
      when 'SNI' then "('NI', 'SNI')"

      when 'TZ'  then "('TZ', 'STZ')"
      when 'STZ' then "('TZ', 'STZ')"

      when 'ZF'  then "('ZF', 'SZF')"
      when 'SZF' then "('ZF', 'SZF')"

      when 'ZN'  then "('ZN', 'SZN')"
      when 'SZN' then "('ZN', 'SZN')"

      when 'HN'  then "('HN', 'LN', 'SHN', 'SLN')"
      when 'LN'  then "('HN', 'LN', 'SHN', 'SLN')"
      when 'SHN' then "('HN', 'LN', 'SHN', 'SLN')"
      when 'SLN' then "('HN', 'LN', 'SHN', 'SLN')"
        
      when 'EN'  then "('EN', 'SEN', 'HP', 'MP', 'SHP', 'SMP')"
      when 'SEN' then "('EN', 'SEN', 'HP', 'MP', 'SHP', 'SMP')"
      when 'HP'  then "('EN', 'SEN', 'HP', 'MP', 'SHP', 'SMP')"
      when 'MP'  then "('EN', 'SEN', 'HP', 'MP', 'SHP', 'SMP')"
      when 'SHP' then "('EN', 'SEN', 'HP', 'MP', 'SHP', 'SMP')"
      when 'SMP' then "('EN', 'SEN', 'HP', 'MP', 'SHP', 'SMP')"
    end
  end

  def self.options_for_process_code_filter 
    [['Brass (BR, SBR)',                                'BR'],
     ['Bright Acid Tin (BT, SBT)',                      'BT'],
     ['Cadmium (CD, SCD)',                              'CD'],
     ['Copper (CU, SCU)',                               'CU'],
     ['Electroless Nickel (EN, SEN, HP, MP, SHP, SMP)', 'EN'],
     ['Matte Acide Tin (MT, SMT)',                      'MT'],
     ['Nickel (NI, SNI)',                               'NI'],
     ['Zinc (ZN, SZN)',                                 'ZN'],
     ['Zinc-Iron (ZF, SZF)',                            'ZF'],
     ['Zinc-Nickel (HN, LN, SHN, SLN)',                 'HN'],
     ['Tin-Zinc (TZ, STZ)',                             'TZ'],
     ['Passivate (PA)',                                 'PA'],
     ['Clean (CL)',                                     'CL']]
  end

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
     ["EN - Electroless Nickel",                 'EN'],
     ['SEN - Strip + Electroless Nickel',       'SEN'],
     ["HP - High Phos Electroless Nickel",       'HP'],
     ["MP - Mid Phos Electroless Nickel",        'MP'],
     ["SHP - Strip + High Phos Nickel",         'SHP'],
     ["SMP - Strip + Mid Phos Nickel",          'SMP'],
     ["MT - Matte Acid Tin",                     'MT'],
     ["SMT - Strip + Matte Acid Tin",           'SMT'],
     ["NI - Nickel",                             'NI'],
     ["SNI - Strip + Nickel",                   'SNI'],
     ["TZ - Tin-Zinc",                           'TZ'],
     ["STZ - Strip + Tin-Zinc",                 'STZ'],
     ["ZF - Zinc-Iron",                          'ZF'],
     ["SZF - Strip + Zinc-Iron",                'SZF'],
     ["ZN - Zinc",                               'ZN'],
     ["SZN - Strip + Zinc",                     'SZN'],
     ["PA - Passivate",                          'PA'],
     ["CL - Clean",                              'CL']]
  end

  def self.not_recently
    preload(:salt_spray_test_checks).select { |s| s.salt_spray_test_checks.all? {|c| ((Time.now - c.date) > 4.hours) }}
  end
end