class User < ApplicationRecord

  include Hideable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :tokens
  # has_many :user_apps
  # has_many :apps, :through => :user_apps

  belongs_to :client

  ROLES = %w(user admin super_admin).freeze

  def super_admin?
    role == 'super_admin'
  end

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

end
