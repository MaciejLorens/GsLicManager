class UserLicense < ApplicationRecord
  belongs_to :app
  belongs_to :app_version
end
