class User < ApplicationRecord

  include Hideable

  # has_many :tokens
  # has_many :user_apps
  # has_many :apps, :through => :user_apps

  has_many :licenses
  has_many :versions, through: :license

  belongs_to :client, optional: true

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  ROLES = %w(user admin super_admin).freeze

  scope :super_admins, -> { where(role: 'super_admin') }
  scope :admins, -> { where(role: 'admin') }
  scope :users, -> { where(role: 'user') }

  validates_presence_of :first_name, :last_name, :role

  def super_admin?
    role == 'super_admin'
  end

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
