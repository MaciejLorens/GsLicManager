class AppVersion < ApplicationRecord
  belongs_to :app
  has_many :user_licenses
end
