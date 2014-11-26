class User < ActiveRecord::Base
  # callback used to make sure email is downcased before saved
  before_save { self.email = email.downcase }
  # validates if the user name is blank and maximum characters allowed
  # will give an error if user leaves field blank
  # looks like magic, but validates is just a method
  # validates(:name, presence: true) is acceptable
  validates :name,  presence: true, length: { maximum: 50 }
  # email regular expression needed to valid emails
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
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
end
