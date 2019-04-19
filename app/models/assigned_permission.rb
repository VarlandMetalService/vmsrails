class AssignedPermission < ApplicationRecord

  # Associations.
  belongs_to      :user, optional: true
  belongs_to      :permission

  accepts_nested_attributes_for   :permission,
                                  reject_if: :all_blank
  accepts_nested_attributes_for   :user,
                                  reject_if: :all_blank

  # Validations.
  validates :user_id,
            uniqueness: { scope: :permission_id, message: 'cannot be assigned more than once' }

  # Select options for value.
  def self.options_for_value label_set = false
    case label_set
      when 1 #sysadmin
        [
          ['No Admin Access', '0'],
          ['Admin Access', '3']
        ]
      when 2 #specifications
        [
          ['View Only', '0'],
          ['View Archived', '2'],
          ['Admin Access', '3']
        ]
      when 4 #employee_notes
        [
          ['No Access', '0'],
          ['Manage Own Notes', '2'],
          ['Manage Everybody\'s Notes', '3']
        ]
      else
        [
          ['No Access', '0'],
          ['Read-Only', '1'],
          ['Edit', '2'],
          ['Admin', '3']
        ]
      end
  end

end