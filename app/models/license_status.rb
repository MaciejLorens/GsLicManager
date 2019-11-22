class LicenseStatus < ApplicationRecord

  include Hideable

  has_many :licenses

end
