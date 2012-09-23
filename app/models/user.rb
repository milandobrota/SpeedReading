class User < ActiveRecord::Base

  ROLE_NAMES = ['member', 'admin']

  ROLE_NAMES.each do |role_name|
    define_method("#{role_name}?") { ROLE_NAMES[role] == role_name }
  end

  before_save :ensure_role_present

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  def name_or_email
    email
  end

  def role_name
    ROLE_NAMES[role]
  end

  def ensure_role_present
    self.role ||= ROLE_NAMES.index('member')
  end
end
