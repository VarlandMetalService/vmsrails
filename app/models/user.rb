class User < ApplicationRecord

  # Custom attributes.
  attr_accessor :remember_token

  # Scoping.
  default_scope { order(:employee_number) }
  scope :enabled, -> { where(is_disabled: false) }
  scope :by_name, ->(name) { where('first_name LIKE ? OR last_name LIKE ? OR nickname LIKE ? OR initials LIKE ? OR username LIKE ?',
                                   "%#{name}%",
                                   "%#{name}%",
                                   "%#{name}%",
                                   "%#{name}%",
                                   "%#{name}%") unless name.blank? }
  scope :by_category, ->(category) {
    return if category.blank?
    case category
    when "Plater"
      where('employee_number < 200')
    when "Maintenance"
      where('employee_number >= 200 and employee_number < 300')
    when "Lab"
      where('employee_number >= 300 and employee_number < 400')
    when "Shipping/QC"
      where('employee_number >= 400 and employee_number < 500')
    when "Production Supervisor"
      where('employee_number >= 600 and employee_number < 800')
    when "Office"
      where('employee_number >= 800')
    else
      return
    end
  }

  # Validation.
  validates :employee_number,
            presence: true,
            uniqueness: true,
            numericality: { only_integer: true }
  validates :username,
            presence: true,
            uniqueness: true,
            format: { with: /\A[a-z]+\z/,
                      message: 'may only contain lowercase letters' },
            length: { in: 3..20 }
  validates :first_name,
            presence: true,
            format: { with: /\A[A-Z]/,
                      message: 'must begin with a capital letter' }
  validates :last_name,
            presence: true,
            format: { with: /\A[A-Z]/,
                      message: 'must begin with a capital letter' }
  validates :initials,
            presence: true,
            length: { maximum: 5 },
            format: { with: /\A[A-Z]+\z/,
                      message: 'may only contain uppercase letters' }
  validates :nickname,
            presence: true
  validates :email,
            presence: true,
            format: { with: /\A[a-z\.]+@varland\.com\z/,
                      message: 'may be a varland.com email address' }
  validates :avatar_bg_color,
            :avatar_text_color,
            presence: true,
            format: { with: /\A#[0-9a-f]{6}\z/,
                      message: 'must be a valid hex color code' }

  # Callbacks.

  # Format fields before validation.
  before_validation do

    # Format names.
    self.first_name = self.first_name.titleize unless self.first_name.blank? || self.first_name.match(/\p{Lower}/)
    unless self.last_name.blank? || self.last_name.match(/\p{Lower}/)
      self.last_name = self.last_name.titleize
      if self.last_name.start_with? 'Mc'
        self.last_name[2] = self.last_name[2].upcase
      end
    end
    self.nickname = self.first_name if self.nickname.blank?

    # Auto generate fields that may be left blank.
    unless self.first_name.blank? || self.last_name.blank?
      self.initials = "#{self.first_name.first}#{self.last_name.first}".upcase if self.initials.blank?
      self.username = self.first_name.downcase if self.username.blank?
      self.email = "#{self.first_name}.#{self.last_name}@varland.com".downcase if self.email.blank?
    end

    # Format case-specific fields.
    ['avatar_bg_color', 'avatar_text_color', 'email', 'username'].each do |a|
      self[a].downcase! unless self[a].blank?
    end
    self.middle_initial.upcase! unless self.middle_initial.blank?

    # Disables user if necessary before saving.
    if self.is_disabled
      self.is_admin = false
      self.avatar_bg_color = '#ffffff'
      self.avatar_text_color = '#000000'
      self.remember_digest = nil
    end

  end

  # Methods.

  # Stores persistent login token.
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  # Removes persistent login token.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Authenticates user.
  def authenticate(password)
    uri = URI.parse "http://api.varland.com/v2/auth"
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Post.new uri.request_uri
    request.body = "user=#{self.username}&password=#{password}"
    response = http.request request
    return response.code.to_s == '200' && response.body.to_s == '1'
  end

  # Returns full name.
  def full_name
    "#{self.first_name} #{self.last_name} #{self.suffix}".strip
  end

  # Class methods.

  def self.options_for_category
    ['Plater',
     'Maintenance',
     'Lab',
     'Shipping/QC',
     'Production Supervisor',
     'Office']
  end

  # Returns hash digest of given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

end
