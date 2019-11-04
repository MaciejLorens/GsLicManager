class App < ApplicationRecord
	has_many :app_versions
	has_many :user_apps
	has_many :users, :through => :user_apps
	has_many :user_licenses
end
