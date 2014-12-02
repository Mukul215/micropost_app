class User < ActiveRecord::Base
  # create an accessible attribute
  attr_accessor :remember_token
  # callback used to make sure email is downcased before saved
  before_save { self.email = email.downcase }
  # validates if the user name is blank and maximum characters allowed
  # will give an error if user leaves field blank
  # looks like magic, but validates is just a method
  # validates(:name, presence: true) is acceptable
  validates :name,  presence: true, length: { maximum: 50 }
  # email regular expression needed to valid emails
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    # unique validation is case sensitive
                    # set to false to it catches dup emails
                    uniqueness: { case_sensitive: false }

  # this is used to create a hash for passwords, it is a rails method
  # 1.) The ability to save a securely hashed password_digest attribute to 
  # the database
  # 2.) A pair of virtual attributes18 (password and password_confirmation), 
  # including presence validations upon object creation and a validation 
  # requiring that they match
  # 3.) An authenticate method that returns the user when the password is 
  # correct (and false otherwise)
  has_secure_password
  validates :password, length: { minimum: 6 }

  # returns the hash digest of a given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)              
  end

  # returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

end