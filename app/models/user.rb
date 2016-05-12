class User < ApplicationRecord
  has_secure_password


  email_regex = /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i
  username_regex = /\A[A-Za-z0-9_]+\z/

  validates :username,
            :presence => true,
            :length => { :within => 3..50 },
            #:exclusion => USERNAME_BLACKLIST,
            :format => { :with => username_regex }

  validates :email,
            :presence => true,
            :uniqueness => { :case_sensitive => false },
            :format => { :with => email_regex }

  before_save :generate_remember_token

  #用email和密码验证身份
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  #用token进行登录
  def self.authenticate_with_token(id, token)
    user = find_by_id(id)
    (user && user.remember_token == token) ? user : nil
  end

  def send_reset_password
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.now.utc
    save
  end

  def lock
    update_attribute :locked_at, Time.now.utc
  end

  def unlock
    update_attribute :locked_at, nil
  end

  def locked?
    locked_at.present?
  end


  def admin?
    CONFIG['admin_emails'] && CONFIG['admin_emails'].include?(self.email)
  end



  private
    def generate_remember_token
      generate_token(:remember_token) if self.password.present?
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
