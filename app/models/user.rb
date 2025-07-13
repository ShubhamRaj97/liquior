class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin staff customer]

    def admin?
      role == 'admin'
    end

    def staff?
      role == 'staff'
    end

    def customer?
      role == 'customer'
    end

    def self.authenticate(email, password, type = nil)
      user = User.find_by(email: email)
    
      return nil unless user&.valid_password?(password)
      return nil if type.present? && user.role != type
    
      user
    end
    
    
    
end
