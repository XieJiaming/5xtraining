class User < ApplicationRecord
  validates :email, :password, presence: true

  has_many :products, :dependent => :destroy

  before_create :encrypt_password

  def self.log_in(params)
    pwd = params[:password]
    pwd = Digest::SHA1.hexdigest("a#{pwd}z")
    User.find_by(email: params[:email], password: pwd)
  end

  private

  def encrypt_password
    self.password = Digest::SHA1.hexdigest("a#{self.password}z")
  end
end